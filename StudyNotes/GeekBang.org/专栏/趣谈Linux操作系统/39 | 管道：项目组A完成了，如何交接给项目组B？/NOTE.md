在这一章的第一节里，我们大致讲了管道的使用方式以及相应的命令行。这一节，我们就具体来看一下管道是如何实现的。

我们先来看，我们常用的匿名管道（Anonymous Pipes），也即将多个命令串起来的竖线，背后的原理到底是什么。

上次我们说，它是基于管道的，那管道如何创建呢？管道的创建，需要通过下面这个系统调用。

```cpp
int pipe(int fd[2])
```

在这里，我们创建了一个管道 pipe，返回了两个文件描述符，这表示管道的两端，一个是管道的读取端描述符 fd[0]，另一个是管道的写入端描述符 fd[1]。

![](https://static001.geekbang.org/resource/image/8f/a7/8fa3144bf3a34ddf789884a75fa2d4a7.png)

我们来看在内核里面是如何实现的。

```cpp
SYSCALL_DEFINE1(pipe, int __user *, fildes)
{
  return sys_pipe2(fildes, 0);
}

SYSCALL_DEFINE2(pipe2, int __user *, fildes, int, flags)
{
  struct file *files[2];
  int fd[2];
  int error;

  error = __do_pipe_flags(fd, files, flags);
  if (!error) {
    if (unlikely(copy_to_user(fildes, fd, sizeof(fd)))) {
......
      error = -EFAULT;
    } else {
      fd_install(fd[0], files[0]);
      fd_install(fd[1], files[1]);
    }
  }
  return error;
}
```

在内核中，主要的逻辑在 pipe2 系统调用中。这里面要创建一个数组 files，用来存放管道的两端的打开文件，另一个数组 fd 存放管道的两端的文件描述符。如果调用 \_\_do_pipe_flags 没有错误，那就调用 fd_install，将两个 fd 和两个 struct file 关联起来。这一点和打开一个文件的过程很像了。

我们来看 \_\_do_pipe_flags。这里面调用了 create_pipe_files，然后生成了两个 fd。从这里可以看出，fd[0]是用于读的，fd[1]是用于写的。

```cpp
static int __do_pipe_flags(int *fd, struct file **files, int flags)
{
  int error;
  int fdw, fdr;
......
  error = create_pipe_files(files, flags);
......
  error = get_unused_fd_flags(flags);
......
  fdr = error;

  error = get_unused_fd_flags(flags);
......
  fdw = error;

  fd[0] = fdr;
  fd[1] = fdw;
  return 0;
......
}
```

创建一个管道，大部分的逻辑其实都是在 create_pipe_files 函数里面实现的。这一章第一节的时候，我们说过，命名管道是创建在文件系统上的。从这里我们可以看出，匿名管道，也是创建在文件系统上的，只不过是一种特殊的文件系统，创建一个特殊的文件，对应一个特殊的 inode，就是这里面的 get_pipe_inode。

```cpp
int create_pipe_files(struct file **res, int flags)
{
  int err;
  struct inode *inode = get_pipe_inode();
  struct file *f;
  struct path path;
......
  path.dentry = d_alloc_pseudo(pipe_mnt->mnt_sb, &empty_name);
......
  path.mnt = mntget(pipe_mnt);

  d_instantiate(path.dentry, inode);

  f = alloc_file(&path, FMODE_WRITE, &pipefifo_fops);
......
  f->f_flags = O_WRONLY | (flags & (O_NONBLOCK | O_DIRECT));
  f->private_data = inode->i_pipe;

  res[0] = alloc_file(&path, FMODE_READ, &pipefifo_fops);
......
  path_get(&path);
  res[0]->private_data = inode->i_pipe;
  res[0]->f_flags = O_RDONLY | (flags & O_NONBLOCK);
  res[1] = f;
  return 0;
......
}
```

从 get_pipe_inode 的实现，我们可以看出，匿名管道来自一个特殊的文件系统 pipefs。这个文件系统被挂载后，我们就得到了 struct vfsmount \*pipe_mnt。然后挂载的文件系统的 superblock 就变成了：pipe_mnt->mnt_sb。如果你对文件系统的操作还不熟悉，要返回去复习一下文件系统那一章啊。

```cpp
static struct file_system_type pipe_fs_type = {
  .name    = "pipefs",
  .mount    = pipefs_mount,
  .kill_sb  = kill_anon_super,
};

static int __init init_pipe_fs(void)
{
  int err = register_filesystem(&pipe_fs_type);

  if (!err) {
    pipe_mnt = kern_mount(&pipe_fs_type);
  }
......
}

static struct inode * get_pipe_inode(void)
{
  struct inode *inode = new_inode_pseudo(pipe_mnt->mnt_sb);
  struct pipe_inode_info *pipe;
......
  inode->i_ino = get_next_ino();

  pipe = alloc_pipe_info();
......
  inode->i_pipe = pipe;
  pipe->files = 2;
  pipe->readers = pipe->writers = 1;
  inode->i_fop = &pipefifo_fops;
  inode->i_state = I_DIRTY;
  inode->i_mode = S_IFIFO | S_IRUSR | S_IWUSR;
  inode->i_uid = current_fsuid();
  inode->i_gid = current_fsgid();
  inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);

  return inode;
......
}
```

我们从 new_inode_pseudo 函数创建一个 inode。这里面开始填写 Inode 的成员，这里和文件系统的很像。这里值得注意的是 struct pipe_inode_info，这个结构里面有个成员是 struct pipe_buffer \*bufs。我们可以知道，所谓的匿名管道，其实就是内核里面的一串缓存。

另外一个需要注意的是 pipefifo_fops，将来我们对于文件描述符的操作，在内核里面都是对应这里面的操作。

```cpp
const struct file_operations pipefifo_fops = {
  .open    = fifo_open,
  .llseek    = no_llseek,
  .read_iter  = pipe_read,
  .write_iter  = pipe_write,
  .poll    = pipe_poll,
  .unlocked_ioctl  = pipe_ioctl,
  .release  = pipe_release,
  .fasync    = pipe_fasync,
};
```

我们回到 create_pipe_files 函数，创建完了 inode，还需创建一个 dentry 和他对应。dentry 和 inode 对应好了，我们就要开始创建 struct file 对象了。先创建用于写入的，对应的操作为 pipefifo_fops；再创建读取的，对应的操作也为 pipefifo_fops。然后把 private_data 设置为 pipe_inode_info。这样从 struct file 这个层级上，就能直接操作底层的读写操作。

至此，一个匿名管道就创建成功了。如果对于 fd[1]写入，调用的是 pipe_write，向 pipe_buffer 里面写入数据；如果对于 fd[0]的读入，调用的是 pipe_read，也就是从 pipe_buffer 里面读取数据。

但是这个时候，两个文件描述符都是在一个进程里面的，并没有起到进程间通信的作用，怎么样才能使得管道是跨两个进程的呢？还记得创建进程调用的 fork 吗？在这里面，创建的子进程会复制父进程的 struct files_struct，在这里面 fd 的数组会复制一份，但是 fd 指向的 struct file 对于同一个文件还是只有一份，这样就做到了，两个进程各有两个 fd 指向同一个 struct file 的模式，两个进程就可以通过各自的 fd 写入和读取同一个管道文件实现跨进程通信了。

![](https://static001.geekbang.org/resource/image/9c/a3/9c0e38e31c7a51da12faf4a1aca10ba3.png)

由于管道只能一端写入，另一端读出，所以上面的这种模式会造成混乱，因为父进程和子进程都可以写入，也都可以读出，通常的方法是父进程关闭读取的 fd，只保留写入的 fd，而子进程关闭写入的 fd，只保留读取的 fd，如果需要双向通行，则应该创建两个管道。

一个典型的使用管道在父子进程之间的通信代码如下：

```cpp
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>

int main(int argc, char *argv[])
{
  int fds[2];
  if (pipe(fds) == -1)
    perror("pipe error");

  pid_t pid;
  pid = fork();
  if (pid == -1)
    perror("fork error");

  if (pid == 0){
    close(fds[0]);
    char msg[] = "hello world";
    write(fds[1], msg, strlen(msg) + 1);
    close(fds[1]);
    exit(0);
  } else {
    close(fds[1]);
    char msg[128];
    read(fds[0], msg, 128);
    close(fds[0]);
    printf("message : %s\n", msg);
    return 0;
  }
}
```

![](https://static001.geekbang.org/resource/image/71/b6/71eb7b4d026d04e4093daad7e24feab6.png)

到这里，我们仅仅解析了使用管道进行父子进程之间的通信，但是我们在 shell 里面的不是这样的。在 shell 里面运行 A|B 的时候，A 进程和 B 进程都是 shell 创建出来的子进程，A 和 B 之间不存在父子关系。

不过，有了上面父子进程之间的管道这个基础，实现 A 和 B 之间的管道就方便多了。

我们首先从 shell 创建子进程 A，然后在 shell 和 A 之间建立一个管道，其中 shell 保留读取端，A 进程保留写入端，然后 shell 再创建子进程 B。这又是一次 fork，所以，shell 里面保留的读取端的 fd 也被复制到了子进程 B 里面。这个时候，相当于 shell 和 B 都保留读取端，只要 shell 主动关闭读取端，就变成了一管道，写入端在 A 进程，读取端在 B 进程。

![](https://static001.geekbang.org/resource/image/81/fa/81be4d460aaa804e9176ec70d59fdefa.png)

接下来我们要做的事情就是，将这个管道的两端和输入输出关联起来。这就要用到 dup2 系统调用了。

```cpp
int dup2(int oldfd, int newfd);
```

这个系统调用，将老的文件描述符赋值给新的文件描述符，让 newfd 的值和 oldfd 一样。

我们还是回忆一下，在 files_struct 里面，有这样一个表，下标是 fd，内容指向一个打开的文件 struct file。

```cpp
struct files_struct {
  struct file __rcu * fd_array[NR_OPEN_DEFAULT];
}
```

在这个表里面，前三项是定下来的，其中第零项 STDIN_FILENO 表示标准输入，第一项 STDOUT_FILENO 表示标准输出，第三项 STDERR_FILENO 表示错误输出。

在 A 进程中，写入端可以做这样的操作：dup2(fd[1],STDOUT_FILENO)，将 STDOUT_FILENO（也即第一项）不再指向标准输出，而是指向创建的管道文件，那么以后往标准输出写入的任何东西，都会写入管道文件。

在 B 进程中，读取端可以做这样的操作，dup2(fd[0],STDIN_FILENO)，将 STDIN_FILENO 也即第零项不再指向标准输入，而是指向创建的管道文件，那么以后从标准输入读取的任何东西，都来自于管道文件。

至此，我们才将 A|B 的功能完成。

![](https://static001.geekbang.org/resource/image/c0/e2/c042b12de704995e4ba04173e0a304e2.png)

为了模拟 A|B 的情况，我们可以将前面的那一段代码，进一步修改成下面这样：

```cpp
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>

int main(int argc, char *argv[])
{
  int fds[2];
  if (pipe(fds) == -1)
    perror("pipe error");

  pid_t pid;
  pid = fork();
  if (pid == -1)
    perror("fork error");

  if (pid == 0){
    dup2(fds[1], STDOUT_FILENO);
    close(fds[1]);
    close(fds[0]);
    execlp("ps", "ps", "-ef", NULL);
  } else {
    dup2(fds[0], STDIN_FILENO);
    close(fds[0]);
    close(fds[1]);
    execlp("grep", "grep", "systemd", NULL);
  }

  return 0;
}
```

接下来，我们来看命名管道。我们在讲命令的时候讲过，命名管道需要事先通过命令 mkfifo，进行创建。如果是通过代码创建命名管道，也有一个函数，但是这不是一个系统调用，而是 Glibc 提供的函数。它的定义如下：

```cpp
int
mkfifo (const char *path, mode_t mode)
{
  dev_t dev = 0;
  return __xmknod (_MKNOD_VER, path, mode | S_IFIFO, &dev);
}

int
__xmknod (int vers, const char *path, mode_t mode, dev_t *dev)
{
  unsigned long long int k_dev;
......
  /* We must convert the value to dev_t type used by the kernel.  */
  k_dev = (*dev) & ((1ULL << 32) - 1);
......
  return INLINE_SYSCALL (mknodat, 4, AT_FDCWD, path, mode,
                         (unsigned int) k_dev);
}
```

Glibc 的 mkfifo 函数会调用 mknodat 系统调用，还记得咱们学字符设备的时候，创建一个字符设备的时候，也是调用的 mknod。这里命名管道也是一个设备，因而我们也用 mknod。

```cpp
SYSCALL_DEFINE4(mknodat, int, dfd, const char __user *, filename, umode_t, mode, unsigned, dev)
{
  struct dentry *dentry;
  struct path path;
  unsigned int lookup_flags = 0;
......
retry:
  dentry = user_path_create(dfd, filename, &path, lookup_flags);
......
  switch (mode & S_IFMT) {
......
    case S_IFIFO: case S_IFSOCK:
      error = vfs_mknod(path.dentry->d_inode,dentry,mode,0);
      break;
  }
......
}
```

对于 mknod 的解析，我们在字符设备那一节已经解析过了，先是通过 user_path_create 对于这个管道文件创建一个 dentry，然后因为是 S_IFIFO，所以调用 vfs_mknod。由于这个管道文件是创建在一个普通文件系统上的，假设是在 ext4 文件上，于是 vfs_mknod 会调用 ext4_dir_inode_operations 的 mknod，也即会调用 ext4_mknod。

```cpp
const struct inode_operations ext4_dir_inode_operations = {
......
  .mknod    = ext4_mknod,
......
};

static int ext4_mknod(struct inode *dir, struct dentry *dentry,
          umode_t mode, dev_t rdev)
{
  handle_t *handle;
  struct inode *inode;
......
  inode = ext4_new_inode_start_handle(dir, mode, &dentry->d_name, 0,
              NULL, EXT4_HT_DIR, credits);
  handle = ext4_journal_current_handle();
  if (!IS_ERR(inode)) {
    init_special_inode(inode, inode->i_mode, rdev);
    inode->i_op = &ext4_special_inode_operations;
    err = ext4_add_nondir(handle, dentry, inode);
    if (!err && IS_DIRSYNC(dir))
      ext4_handle_sync(handle);
  }
  if (handle)
    ext4_journal_stop(handle);
......
}

#define ext4_new_inode_start_handle(dir, mode, qstr, goal, owner, \
            type, nblocks)        \
  __ext4_new_inode(NULL, (dir), (mode), (qstr), (goal), (owner), \
       0, (type), __LINE__, (nblocks))

void init_special_inode(struct inode *inode, umode_t mode, dev_t rdev)
{
  inode->i_mode = mode;
  if (S_ISCHR(mode)) {
    inode->i_fop = &def_chr_fops;
    inode->i_rdev = rdev;
  } else if (S_ISBLK(mode)) {
    inode->i_fop = &def_blk_fops;
    inode->i_rdev = rdev;
  } else if (S_ISFIFO(mode))
    inode->i_fop = &pipefifo_fops;
  else if (S_ISSOCK(mode))
    ;  /* leave it no_open_fops */
  else
......
}
```

在 ext4_mknod 中，ext4_new_inode_start_handle 会调用 \_\_ext4_new_inode，在 ext4 文件系统上真的创建一个文件，但是会调用 init_special_inode，创建一个内存中特殊的 inode，这个函数我们在字符设备文件中也遇到过，只不过当时 inode 的 i_fop 指向的是 def_chr_fops，这次换成管道文件了，inode 的 i_fop 变成指向 pipefifo_fops，这一点和匿名管道是一样的。

这样，管道文件就创建完毕了。

接下来，要打开这个管道文件，我们还是会调用文件系统的 open 函数。还是沿着文件系统的调用方式，一路调用到 pipefifo_fops 的 open 函数，也就是 fifo_open。

```cpp
static int fifo_open(struct inode *inode, struct file *filp)
{
  struct pipe_inode_info *pipe;
  bool is_pipe = inode->i_sb->s_magic == PIPEFS_MAGIC;
  int ret;
  filp->f_version = 0;

  if (inode->i_pipe) {
    pipe = inode->i_pipe;
    pipe->files++;
  } else {
    pipe = alloc_pipe_info();
    pipe->files = 1;
    inode->i_pipe = pipe;
    spin_unlock(&inode->i_lock);
  }
  filp->private_data = pipe;
  filp->f_mode &= (FMODE_READ | FMODE_WRITE);

  switch (filp->f_mode) {
  case FMODE_READ:
    pipe->r_counter++;
    if (pipe->readers++ == 0)
      wake_up_partner(pipe);
    if (!is_pipe && !pipe->writers) {
      if ((filp->f_flags & O_NONBLOCK)) {
      filp->f_version = pipe->w_counter;
      } else {
        if (wait_for_partner(pipe, &pipe->w_counter))
          goto err_rd;
      }
    }
    break;
  case FMODE_WRITE:
    pipe->w_counter++;
    if (!pipe->writers++)
      wake_up_partner(pipe);
    if (!is_pipe && !pipe->readers) {
      if (wait_for_partner(pipe, &pipe->r_counter))
        goto err_wr;
    }
    break;
  case FMODE_READ | FMODE_WRITE:
    pipe->readers++;
    pipe->writers++;
    pipe->r_counter++;
    pipe->w_counter++;
    if (pipe->readers == 1 || pipe->writers == 1)
      wake_up_partner(pipe);
    break;
......
  }
......
}
```

在 fifo_open 里面，创建 pipe_inode_info，这一点和匿名管道也是一样的。这个结构里面有个成员是 struct pipe_buffer \*bufs。我们可以知道，所谓的命名管道，其实是也是内核里面的一串缓存。

接下来，对于命名管道的写入，我们还是会调用 pipefifo_fops 的 pipe_write 函数，向 pipe_buffer 里面写入数据。对于命名管道的读入，我们还是会调用 pipefifo_fops 的 pipe_read，也就是从 pipe_buffer 里面读取数据。

### 总结时刻

无论是匿名管道，还是命名管道，在内核都是一个文件。只要是文件就要有一个 inode。这里我们又用到了特殊 inode、字符设备、块设备，其实都是这种特殊的 inode。

在这种特殊的 inode 里面，file_operations 指向管道特殊的 pipefifo_fops，这个 inode 对应内存里面的缓存。

当我们用文件的 open 函数打开这个管道设备文件的时候，会调用 pipefifo_fops 里面的方法创建 struct file 结构，他的 inode 指向特殊的 inode，也对应内存里面的缓存，file_operations 也指向管道特殊的 pipefifo_fops。

写入一个 pipe 就是从 struct file 结构找到缓存写入，读取一个 pipe 就是从 struct file 结构找到缓存读出。

![](https://static001.geekbang.org/resource/image/48/97/486e2bc73abbe91d7083bb1f4f678097.png)

### 课堂练习

上面创建匿名管道的程序，你一定要运行一下，然后试着通过 strace 查看自己写的程序的系统调用，以及直接在命令行使用匿名管道的系统调用，做一个比较。

欢迎留言和我分享你的疑惑和见解 ，也欢迎可以收藏本节内容，反复研读。你也可以把今天的内容分享给你的朋友，和他一起学习和进步。
