上一节，我们讲了输入输出设备的层次模型，还是比较复杂的，块设备尤其复杂。这一节为了让你更清晰地了解设备驱动程序的架构，我们先来讲稍微简单一点的字符设备驱动。

这一节，我找了两个比较简单的字符设备驱动来解析一下。一个是输入字符设备，鼠标。代码在 drivers/input/mouse/logibm.c 这里。

```cpp
/*
 * Logitech Bus Mouse Driver for Linux
 */
module_init(logibm_init);
module_exit(logibm_exit);
```

另外一个是输出字符设备，打印机，代码 drivers/char/lp.c 这里。

```cpp
/*
 * Generic parallel printer driver
 */
module_init(lp_init_module);
module_exit(lp_cleanup_module);
```

### 内核模块

上一节，我们讲过，设备驱动程序是一个内核模块，以 ko 的文件形式存在，可以通过 insmod 加载到内核中。那我们首先来看一下，怎么样才能构建一个内核模块呢？

一个内核模块应该由以下几部分组成。

第一部分，头文件部分。一般的内核模块，都需要 include 下面两个头文件：

```cpp
#include <linux/module.h>
#include <linux/init.h>
```

如果你去看上面两个驱动程序，都能找到这两个头文件。当然如果需要的话，我们还可以引入更多的头文件。

第二部分，定义一些函数，用于处理内核模块的主要逻辑。例如打开、关闭、读取、写入设备的函数或者响应中断的函数。

例如，logibm.c 里面就定义了 logibm_open。logibm_close 就是处理打开和关闭的，定义了 logibm_interrupt 就是用来响应中断的。再如，lp.c 里面就定义了 lp_read，lp_write 就是处理读写的。

第三部分，定义一个 file_operations 结构。前面我们讲过，设备是可以通过文件系统的接口进行访问的。咱们讲文件系统的时候说过，对于某种文件系统的操作，都是放在 file_operations 里面的。例如 ext4 就定义了这么一个结构，里面都是 ext4_xxx 之类的函数。设备要想被文件系统的接口操作，也需要定义这样一个结构。

例如，lp.c 里面就定义了这样一个结构。

```cpp
static const struct file_operations lp_fops = {
  .owner    = THIS_MODULE,
  .write    = lp_write,
  .unlocked_ioctl  = lp_ioctl,
#ifdef CONFIG_COMPAT
  .compat_ioctl  = lp_compat_ioctl,
#endif
  .open    = lp_open,
  .release  = lp_release,
#ifdef CONFIG_PARPORT_1284
  .read    = lp_read,
#endif
  .llseek    = noop_llseek,
};
```

在 logibm.c 里面，我们找不到这样的结构，是因为它属于众多输入设备的一种，而输入设备的操作被统一定义在 drivers/input/input.c 里面，logibm.c 只是定义了一些自己独有的操作。

```cpp
static const struct file_operations input_devices_fileops = {
  .owner    = THIS_MODULE,
  .open    = input_proc_devices_open,
  .poll    = input_proc_devices_poll,
  .read    = seq_read,
  .llseek    = seq_lseek,
  .release  = seq_release,
};
```

第四部分，定义整个模块的初始化函数和退出函数，用于加载和卸载这个 ko 的时候调用。

例如 lp.c 就定义了 lp_init_module 和 lp_cleanup_module，logibm.c 就定义了 logibm_init 和 logibm_exit。

第五部分，调用 module_init 和 module_exit，分别指向上面两个初始化函数和退出函数。就像本节最开头展示的一样。

第六部分，声明一下 lisense，调用 MODULE_LICENSE。

有了这六部分，一个内核模块就基本合格了，可以工作了。

### 打开字符设备

字符设备可不是一个普通的内核模块，它有自己独特的行为。接下来，我们就沿着打开一个字符设备的过程，看看字符设备这个内核模块做了哪些特殊的事情。

![](https://static001.geekbang.org/resource/image/2e/e6/2e29767e84b299324ea7fc524a3dcee6.jpeg)

要使用一个字符设备，我们首先要把写好的内核模块，通过 insmod 加载进内核。这个时候，先调用的就是 module_init 调用的初始化函数。

例如，在 lp.c 的初始化函数 lp_init 对应的代码如下：

```cpp
static int __init lp_init (void)
{
......
  if (register_chrdev (LP_MAJOR, "lp", &lp_fops)) {
    printk (KERN_ERR "lp: unable to get major %d\n", LP_MAJOR);
    return -EIO;
  }
......
}


int __register_chrdev(unsigned int major, unsigned int baseminor,
          unsigned int count, const char *name,
          const struct file_operations *fops)
{
  struct char_device_struct *cd;
  struct cdev *cdev;
  int err = -ENOMEM;
......
  cd = __register_chrdev_region(major, baseminor, count, name);
  cdev = cdev_alloc();
  cdev->owner = fops->owner;
  cdev->ops = fops;
  kobject_set_name(&cdev->kobj, "%s", name);
  err = cdev_add(cdev, MKDEV(cd->major, baseminor), count);
  cd->cdev = cdev;
  return major ? 0 : cd->major;
}
```

在字符设备驱动的内核模块加载的时候，最重要的一件事情就是，注册这个字符设备。注册的方式是调用 \_\_register_chrdev_region，注册字符设备的主次设备号和名称，然后分配一个 struct cdev 结构，将 cdev 的 ops 成员变量指向这个模块声明的 file_operations。然后，cdev_add 会将这个字符设备添加到内核中一个叫作 struct kobj_map \*cdev_map 的结构，来统一管理所有字符设备。

其中，MKDEV(cd->major, baseminor) 表示将主设备号和次设备号生成一个 dev_t 的整数，然后将这个整数 dev_t 和 cdev 关联起来。

```cpp
/**
 * cdev_add() - add a char device to the system
 * @p: the cdev structure for the device
 * @dev: the first device number for which this device is responsible
 * @count: the number of consecutive minor numbers corresponding to this
 *         device
 *
 * cdev_add() adds the device represented by @p to the system, making it
 * live immediately.  A negative error code is returned on failure.
 */
int cdev_add(struct cdev *p, dev_t dev, unsigned count)
{
  int error;


  p->dev = dev;
  p->count = count;


  error = kobj_map(cdev_map, dev, count, NULL,
       exact_match, exact_lock, p);
  kobject_get(p->kobj.parent);


  return 0;
```

在 logibm.c 中，我们在 logibm_init 找不到注册字符设备，这是因为 input.c 里面的初始化函数 input_init 会调用 register_chrdev_region，注册输入的字符设备，会在 logibm_init 中调用 input_register_device，将 logibm.c 这个字符设备注册到 input.c 里面去，这就相当于 input.c 对多个输入字符设备进行统一的管理。

内核模块加载完毕后，接下来要通过 mknod 在 /dev 下面创建一个设备文件，只有有了这个设备文件，我们才能通过文件系统的接口，对这个设备文件进行操作。

mknod 也是一个系统调用，定义如下：

```cpp
SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, dev)
{
  return sys_mknodat(AT_FDCWD, filename, mode, dev);
}


SYSCALL_DEFINE4(mknodat, int, dfd, const char __user *, filename, umode_t, mode,
    unsigned, dev)
{
  struct dentry *dentry;
  struct path path;
......
  dentry = user_path_create(dfd, filename, &path, lookup_flags);
......
  switch (mode & S_IFMT) {
......
    case S_IFCHR: case S_IFBLK:
      error = vfs_mknod(path.dentry->d_inode,dentry,mode,
          new_decode_dev(dev));
      break;
......
  }
}
```

我们可以在这个系统调用里看到，在文件系统上，顺着路径找到 /dev/xxx 所在的文件夹，然后为这个新创建的设备文件创建一个 dentry。这是维护文件和 inode 之间的关联关系的结构。

接下来，如果是字符文件 S_IFCHR 或者设备文件 S_IFBLK，我们就调用 vfs_mknod。

```cpp
int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
{
......
  error = dir->i_op->mknod(dir, dentry, mode, dev);
......
}
```

这里需要调用对应的文件系统的 inode_operations。应该调用哪个文件系统呢？

如果我们在 linux 下面执行 mount 命令，能看到下面这一行：

```
devtmpfs on /dev type devtmpfs (rw,nosuid,size=3989584k,nr_inodes=997396,mode=755)
```

也就是说，/dev 下面的文件系统的名称为 devtmpfs，我们可以在内核中找到它。

```cpp
static struct dentry *dev_mount(struct file_system_type *fs_type, int flags,
          const char *dev_name, void *data)
{
#ifdef CONFIG_TMPFS
  return mount_single(fs_type, flags, data, shmem_fill_super);
#else
  return mount_single(fs_type, flags, data, ramfs_fill_super);
#endif
}


static struct file_system_type dev_fs_type = {
  .name = "devtmpfs",
  .mount = dev_mount,
  .kill_sb = kill_litter_super,
};
```

从这里可以看出，devtmpfs 在挂载的时候，有两种模式，一种是 ramfs，一种是 shmem 都是基于内存的文件系统。这里你先不用管，基于内存的文件系统具体是怎么回事儿。

```cpp
static const struct inode_operations ramfs_dir_inode_operations = {
......
  .mknod    = ramfs_mknod,
};


static const struct inode_operations shmem_dir_inode_operations = {
#ifdef CONFIG_TMPFS
......
  .mknod    = shmem_mknod,
};
```

这两个 mknod 虽然实现不同，但是都会调用到同一个函数 init_special_inode。

```cpp
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
}
```

显然这个文件是个特殊文件，inode 也是特殊的。这里这个 inode 可以关联字符设备、块设备、FIFO 文件、Socket 等。我们这里只看字符设备。

这里的 inode 的 file_operations 指向一个 def_chr_fops，这里面只有一个 open，就等着你打开它。

另外，inode 的 i_rdev 指向这个设备的 dev_t。还记得 cdev_map 吗？通过这个 dev_t，可以找到我们刚在加载的字符设备 cdev。

```cpp
const struct file_operations def_chr_fops = {
  .open = chrdev_open,
};
```

到目前为止，我们只是创建了 /dev 下面的一个文件，并且和相应的设备号关联起来。但是，我们还没有打开这个 /dev 下面的设备文件。

现在我们来打开它。打开一个文件的流程，我们在文件系统那一节讲过了，这里不再重复。最终就像打开字符设备的图中一样，打开文件的进程的 task_struct 里，有一个数组代表它打开的文件，下标就是文件描述符 fd，每一个打开的文件都有一个 struct file 结构，会指向一个 dentry 项。dentry 可以用来关联 inode。这个 dentry 就是咱们上面 mknod 的时候创建的。

在进程里面调用 open 函数，最终会调用到这个特殊的 inode 的 open 函数，也就是 chrdev_open。

```cpp
static int chrdev_open(struct inode *inode, struct file *filp)
{
  const struct file_operations *fops;
  struct cdev *p;
  struct cdev *new = NULL;
  int ret = 0;


  p = inode->i_cdev;
  if (!p) {
    struct kobject *kobj;
    int idx;
    kobj = kobj_lookup(cdev_map, inode->i_rdev, &idx);
    new = container_of(kobj, struct cdev, kobj);
    p = inode->i_cdev;
    if (!p) {
      inode->i_cdev = p = new;
      list_add(&inode->i_devices, &p->list);
      new = NULL;
    }
  }
......
  fops = fops_get(p->ops);
......
  replace_fops(filp, fops);
  if (filp->f_op->open) {
    ret = filp->f_op->open(inode, filp);
......
  }
......
}
```

在这个函数里面，我们首先看这个 inode 的 i_cdev，是否已经关联到 cdev。如果第一次打开，当然没有。没有没关系，inode 里面有 i_rdev 呀，也就是有 dev_t。我们可以通过它在 cdev_map 中找 cdev。咱们上面注册过了，所以肯定能够找到。找到后我们就将 inode 的 i_cdev，关联到找到的 cdev new。

找到 cdev 就好办了。cdev 里面有 file_operations，这是设备驱动程序自己定义的。我们可以通过它来操作设备驱动程序，把它付给 struct file 里面的 file_operations。这样以后操作文件描述符，就是直接操作设备了。

最后，我们需要调用设备驱动程序的 file_operations 的 open 函数，真正打开设备。对于打印机，调用的是 lp_open。对于鼠标调用的是 input_proc_devices_open，最终会调用到 logibm_open。这些多和设备相关，你不必看懂它们。

### 写入字符设备

当我们像打开一个文件一样打开一个字符设备之后，接下来就是对这个设备的读写。对于文件的读写咱们在文件系统那一章详细讲述过，读写的过程是类似的，所以这里我们只解析打印机驱动写入的过程。

![](https://static001.geekbang.org/resource/image/9b/e2/9bd3cd8a8705dbf69f889ba3b2b5c2e2.jpeg)

写入一个字符设备，就是用文件系统的标准接口 write，参数文件描述符 fd，在内核里面调用的 sys_write，在 sys_write 里面根据文件描述符 fd 得到 struct file 结构。接下来再调用 vfs_write。

```cpp
ssize_t __vfs_write(struct file *file, const char __user *p, size_t count, loff_t *pos)
{
  if (file->f_op->write)
    return file->f_op->write(file, p, count, pos);
  else if (file->f_op->write_iter)
    return new_sync_write(file, p, count, pos);
  else
    return -EINVAL;
}
```

我们可以看到，在 \_\_vfs_write 里面，我们会调用 struct file 结构里的 file_operations 的 write 函数。上面我们打开字符设备的时候，已经将 struct file 结构里面的 file_operations 指向了设备驱动程序的 file_operations 结构，所以这里的 write 函数最终会调用到 lp_write。

```cpp
static ssize_t lp_write(struct file * file, const char __user * buf,
            size_t count, loff_t *ppos)
{
  unsigned int minor = iminor(file_inode(file));
  struct parport *port = lp_table[minor].dev->port;
  char *kbuf = lp_table[minor].lp_buffer;
  ssize_t retv = 0;
  ssize_t written;
  size_t copy_size = count;
......
  /* Need to copy the data from user-space. */
  if (copy_size > LP_BUFFER_SIZE)
    copy_size = LP_BUFFER_SIZE;
......
  if (copy_from_user (kbuf, buf, copy_size)) {
    retv = -EFAULT;
    goto out_unlock;
  }
......
  do {
    /* Write the data. */
    written = parport_write (port, kbuf, copy_size);
    if (written > 0) {
      copy_size -= written;
      count -= written;
      buf  += written;
      retv += written;
    }
......
        if (need_resched())
      schedule ();


    if (count) {
      copy_size = count;
      if (copy_size > LP_BUFFER_SIZE)
        copy_size = LP_BUFFER_SIZE;


      if (copy_from_user(kbuf, buf, copy_size)) {
        if (retv == 0)
          retv = -EFAULT;
        break;
      }
    }
  } while (count > 0);
......
```

这个设备驱动程序的写入函数的实现还是比较典型的。先是调用 copy_from_user 将数据从用户态拷贝到内核态的缓存中，然后调用 parport_write 写入外部设备。这里还有一个 schedule 函数，也即写入的过程中，给其他线程抢占 CPU 的机会。然后，如果 count 还是大于 0，也就是数据还没有写完，那我们就接着 copy_from_user，接着 parport_write，直到写完为止。

### 使用 IOCTL 控制设备

![](https://static001.geekbang.org/resource/image/c3/1d/c3498dad4f15712529354e0fa123c31d.jpeg)

ioctl 也是一个系统调用，它在内核里面的定义如下：

```cpp
SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
{
  int error;
  struct fd f = fdget(fd);
......
  error = do_vfs_ioctl(f.file, fd, cmd, arg);
  fdput(f);
  return error;
}
```

其中，fd 是这个设备的文件描述符，cmd 是传给这个设备的命令，arg 是命令的参数。其中，对于命令和命令的参数，使用 ioctl 系统调用的用户和驱动程序的开发人员约定好行为即可。

其实 cmd 看起来是一个 int，其实他的组成比较复杂，它由几部分组成：

- 最低八位为 NR，是命令号；
- 然后八位是 TYPE，是类型；
- 然后十四位是参数的大小；
- 最高两位是 DIR，是方向，表示写入、读出，还是读写。

由于组成比较复杂，有一些宏是专门用于组成这个 cmd 值的。

```cpp
/*
 * Used to create numbers.
 */
#define _IO(type,nr)    _IOC(_IOC_NONE,(type),(nr),0)
#define _IOR(type,nr,size)  _IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
#define _IOW(type,nr,size)  _IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
#define _IOWR(type,nr,size)  _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))


/* used to decode ioctl numbers.. */
#define _IOC_DIR(nr)    (((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
#define _IOC_TYPE(nr)    (((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
#define _IOC_NR(nr)    (((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
#define _IOC_SIZE(nr)    (((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
```

在用户程序中，可以通过上面的“Used to create numbers”这些宏，根据参数生成 cmd，在驱动程序中，可以通过下面的“used to decode ioctl numbers”这些宏，解析 cmd 后，执行指令。

ioctl 中会调用 do_vfs_ioctl，这里面对于已经定义好的 cmd，进行相应的处理。如果不是默认定义好的 cmd，则执行默认操作。对于普通文件，调用 file_ioctl；对于其他文件调用 vfs_ioctl。

```cpp
int do_vfs_ioctl(struct file *filp, unsigned int fd, unsigned int cmd,
       unsigned long arg)
{
  int error = 0;
  int __user *argp = (int __user *)arg;
  struct inode *inode = file_inode(filp);


  switch (cmd) {
......
  case FIONBIO:
    error = ioctl_fionbio(filp, argp);
    break;


  case FIOASYNC:
    error = ioctl_fioasync(fd, filp, argp);
    break;
......
  case FICLONE:
    return ioctl_file_clone(filp, arg, 0, 0, 0);


  default:
    if (S_ISREG(inode->i_mode))
      error = file_ioctl(filp, cmd, arg);
    else
      error = vfs_ioctl(filp, cmd, arg);
    break;
  }
  return error;
```

由于咱们这里是设备驱动程序，所以调用的是 vfs_ioctl。

```cpp
/**
 * vfs_ioctl - call filesystem specific ioctl methods
 * @filp:  open file to invoke ioctl method on
 * @cmd:  ioctl command to execute
 * @arg:  command-specific argument for ioctl
 *
 * Invokes filesystem specific ->unlocked_ioctl, if one exists; otherwise
 * returns -ENOTTY.
 *
 * Returns 0 on success, -errno on error.
 */
long vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
{
  int error = -ENOTTY;


  if (!filp->f_op->unlocked_ioctl)
    goto out;


  error = filp->f_op->unlocked_ioctl(filp, cmd, arg);
  if (error == -ENOIOCTLCMD)
    error = -ENOTTY;
 out:
  return error;
```

这里面调用的是 struct file 里 file_operations 的 unlocked_ioctl 函数。我们前面初始化设备驱动的时候，已经将 file_operations 指向设备驱动的 file_operations 了。这里调用的是设备驱动的 unlocked_ioctl。对于打印机程序来讲，调用的是 lp_ioctl。可以看出来，这里面就是 switch 语句，它会根据不同的 cmd，做不同的操作。

```cpp
static long lp_ioctl(struct file *file, unsigned int cmd,
      unsigned long arg)
{
  unsigned int minor;
  struct timeval par_timeout;
  int ret;


  minor = iminor(file_inode(file));
  mutex_lock(&lp_mutex);
  switch (cmd) {
......
  default:
    ret = lp_do_ioctl(minor, cmd, arg, (void __user *)arg);
    break;
  }
  mutex_unlock(&lp_mutex);
  return ret;
}


static int lp_do_ioctl(unsigned int minor, unsigned int cmd,
  unsigned long arg, void __user *argp)
{
  int status;
  int retval = 0;


  switch ( cmd ) {
    case LPTIME:
      if (arg > UINT_MAX / HZ)
        return -EINVAL;
      LP_TIME(minor) = arg * HZ/100;
      break;
    case LPCHAR:
      LP_CHAR(minor) = arg;
      break;
    case LPABORT:
      if (arg)
        LP_F(minor) |= LP_ABORT;
      else
        LP_F(minor) &= ~LP_ABORT;
      break;
    case LPABORTOPEN:
      if (arg)
        LP_F(minor) |= LP_ABORTOPEN;
      else
        LP_F(minor) &= ~LP_ABORTOPEN;
      break;
    case LPCAREFUL:
      if (arg)
        LP_F(minor) |= LP_CAREFUL;
      else
        LP_F(minor) &= ~LP_CAREFUL;
      break;
    case LPWAIT:
      LP_WAIT(minor) = arg;
      break;
    case LPSETIRQ:
      return -EINVAL;
      break;
    case LPGETIRQ:
      if (copy_to_user(argp, &LP_IRQ(minor),
          sizeof(int)))
        return -EFAULT;
      break;
    case LPGETSTATUS:
      if (mutex_lock_interruptible(&lp_table[minor].port_mutex))
        return -EINTR;
      lp_claim_parport_or_block (&lp_table[minor]);
      status = r_str(minor);
      lp_release_parport (&lp_table[minor]);
      mutex_unlock(&lp_table[minor].port_mutex);


      if (copy_to_user(argp, &status, sizeof(int)))
        return -EFAULT;
      break;
    case LPRESET:
      lp_reset(minor);
      break;
     case LPGETFLAGS:
       status = LP_F(minor);
      if (copy_to_user(argp, &status, sizeof(int)))
        return -EFAULT;
      break;
    default:
      retval = -EINVAL;
  }
  return retval
```

### 总结时刻

这一节我们讲了字符设备的打开、写入和 ioctl 等最常见的操作。一个字符设备要能够工作，需要三部分配合。

第一，有一个设备驱动程序的 ko 模块，里面有模块初始化函数、中断处理函数、设备操作函数。这里面封装了对于外部设备的操作。加载设备驱动程序模块的时候，模块初始化函数会被调用。在内核维护所有字符设备驱动的数据结构 cdev_map 里面注册，我们就可以很容易根据设备号，找到相应的设备驱动程序。

第二，在 /dev 目录下有一个文件表示这个设备，这个文件在特殊的 devtmpfs 文件系统上，因而也有相应的 dentry 和 inode。这里的 inode 是一个特殊的 inode，里面有设备号。通过它，我们可以在 cdev_map 中找到设备驱动程序，里面还有针对字符设备文件的默认操作 def_chr_fops。

第三，打开一个字符设备文件和打开一个普通的文件有类似的数据结构，有文件描述符、有 struct file、指向字符设备文件的 dentry 和 inode。字符设备文件的相关操作 file_operations 一开始指向 def_chr_fops，在调用 def_chr_fops 里面的 chrdev_open 函数的时候，修改为指向设备操作函数，从而读写一个字符设备文件就会直接变成读写外部设备了。

![](https://static001.geekbang.org/resource/image/fb/cd/fba61fe95e0d2746235b1070eb4c18cd.jpeg)

### 课堂练习

这节我用打印机驱动程序作为例子来给你讲解字符设备，请你仔细看一下它的代码，设想一下，如果让你自己写一个字符设备驱动程序，应该实现哪些函数呢？

欢迎留言和我分享你的疑惑和见解 ，也欢迎可以收藏本节内容，反复研读。你也可以把今天的内容分享给你的朋友，和他一起学习和进步。
