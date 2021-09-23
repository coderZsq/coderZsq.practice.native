上一章，我们解析了文件系统，最后讲文件系统读写的流程到达底层的时候，没有更深入地分析下去，这是因为文件系统再往下就是硬盘设备了。上两节，我们解析了字符设备的 mknod、打开和读写流程。那这一节我们就来讲块设备的 mknod、打开流程，以及文件系统和下层的硬盘设备的读写流程。

块设备一般会被格式化为文件系统，但是，下面的讲述中，你可能会有一点困惑。你会看到各种各样的 dentry 和 inode。块设备涉及三种文件系统，所以你看到的这些 dentry 和 inode 可能都不是一回事儿，请注意分辨。

块设备需要 mknod 吗？对于启动盘，你可能觉得，启动了就在那里了。可是如果我们要插进一块新的 USB 盘，还是要有这个操作的。

mknod 还是会创建在 /dev 路径下面，这一点和字符设备一样。/dev 路径下面是 devtmpfs 文件系统。这是块设备遇到的第一个文件系统。我们会为这个块设备文件，分配一个特殊的 inode，这一点和字符设备也是一样的。只不过字符设备走 S_ISCHR 这个分支，对应 inode 的 file_operations 是 def_chr_fops；而块设备走 S_ISBLK 这个分支，对应的 inode 的 file_operations 是 def_blk_fops。这里要注意，inode 里面的 i_rdev 被设置成了块设备的设备号 dev_t，这个我们后面会用到，你先记住有这么一回事儿。

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

特殊 inode 的默认 file_operations 是 def_blk_fops，就像字符设备一样，有打开、读写这个块设备文件，但是我们常规操作不会这样做。我们会将这个块设备文件 mount 到一个文件夹下面。

```cpp
const struct file_operations def_blk_fops = {
        .open           = blkdev_open,
        .release        = blkdev_close,
        .llseek         = block_llseek,
        .read_iter      = blkdev_read_iter,
        .write_iter     = blkdev_write_iter,
        .mmap           = generic_file_mmap,
        .fsync          = blkdev_fsync,
        .unlocked_ioctl = block_ioctl,
        .splice_read    = generic_file_splice_read,
        .splice_write   = iter_file_splice_write,
        .fallocate      = blkdev_fallocate,
};
```

不过，这里我们还是简单看一下，打开这个块设备的操作 blkdev_open。它里面调用的是 blkdev_get 打开这个块设备，了解到这一点就可以了。

接下来，我们要调用 mount，将这个块设备文件挂载到一个文件夹下面。如果这个块设备原来被格式化为一种文件系统的格式，例如 ext4，那我们调用的就是 ext4 相应的 mount 操作。这是块设备遇到的第二个文件系统，也是向这个块设备读写文件，需要基于的主流文件系统。咱们在文件系统那一节解析的对于文件的读写流程，都是基于这个文件系统的。

还记得，咱们注册 ext4 文件系统的时候，有下面这样的结构：

```cpp
static struct file_system_type ext4_fs_type = {
  .owner    = THIS_MODULE,
  .name    = "ext4",
  .mount    = ext4_mount,
  .kill_sb  = kill_block_super,
  .fs_flags  = FS_REQUIRES_DEV,
};
```

在将一个硬盘的块设备 mount 成为 ext4 的时候，我们会调用 ext4_mount->mount_bdev。

```cpp
static struct dentry *ext4_mount(struct file_system_type *fs_type, int flags, const char *dev_name, void *data)
{
  return mount_bdev(fs_type, flags, dev_name, data, ext4_fill_super);
}


struct dentry *mount_bdev(struct file_system_type *fs_type,
  int flags, const char *dev_name, void *data,
  int (*fill_super)(struct super_block *, void *, int))
{
  struct block_device *bdev;
  struct super_block *s;
  fmode_t mode = FMODE_READ | FMODE_EXCL;
  int error = 0;


  if (!(flags & MS_RDONLY))
    mode |= FMODE_WRITE;


  bdev = blkdev_get_by_path(dev_name, mode, fs_type);
......
  s = sget(fs_type, test_bdev_super, set_bdev_super, flags | MS_NOSEC, bdev);
......
  return dget(s->s_root);
......
}
```

mount_bdev 主要做了两件大事情。第一，blkdev_get_by_path 根据 /dev/xxx 这个名字，找到相应的设备并打开它；第二，sget 根据打开的设备文件，填充 ext4 文件系统的 super_block，从而以此为基础，建立一整套咱们在文件系统那一章讲的体系。

一旦这套体系建立起来以后，对于文件的读写都是通过 ext4 文件系统这个体系进行的，创建的 inode 结构也是指向 ext4 文件系统的。文件系统那一章我们只解析了这部分，由于没有到达底层，也就没有关注块设备相关的操作。这一章我们重新回过头来，一方面看 mount 的时候，对于块设备都做了哪些操作，另一方面看读写的时候，到了底层，对于块设备做了哪些操作。

这里我们先来看 mount_bdev 做的第一件大事情，通过 blkdev_get_by_path，根据设备名 /dev/xxx，得到 struct block_device \*bdev。

```cpp
/**
 * blkdev_get_by_path - open a block device by name
 * @path: path to the block device to open
 * @mode: FMODE_* mask
 * @holder: exclusive holder identifier
 *
 * Open the blockdevice described by the device file at @path.  @mode
 * and @holder are identical to blkdev_get().
 *
 * On success, the returned block_device has reference count of one.
 */
struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
          void *holder)
{
  struct block_device *bdev;
  int err;


  bdev = lookup_bdev(path);
......
  err = blkdev_get(bdev, mode, holder);
......
  return bdev;
}
```

blkdev_get_by_path 干了两件事情。第一个，lookup_bdev 根据设备路径 /dev/xxx 得到 block_device。第二个，打开这个设备，调用 blkdev_get。

咱们上面分析过 def_blk_fops 的默认打开设备函数 blkdev_open，它也是调用 blkdev_get 的。块设备的打开往往不是直接调用设备文件的打开函数，而是调用 mount 来打开的。

```cpp
/**
 * lookup_bdev  - lookup a struct block_device by name
 * @pathname:  special file representing the block device
 *
 * Get a reference to the blockdevice at @pathname in the current
 * namespace if possible and return it.  Return ERR_PTR(error)
 * otherwise.
 */
struct block_device *lookup_bdev(const char *pathname)
{
  struct block_device *bdev;
  struct inode *inode;
  struct path path;
  int error;


  if (!pathname || !*pathname)
    return ERR_PTR(-EINVAL);


  error = kern_path(pathname, LOOKUP_FOLLOW, &path);
  if (error)
    return ERR_PTR(error);


  inode = d_backing_inode(path.dentry);
......
  bdev = bd_acquire(inode);
......
  goto out;
}
```

lookup_bdev 这里的 pathname 是设备的文件名，例如 /dev/xxx。这个文件是在 devtmpfs 文件系统中的，kern_path 可以在这个文件系统里面，一直找到它对应的 dentry。接下来，d_backing_inode 会获得 inode。这个 inode 就是那个 init_special_inode 生成的特殊 inode。

接下来，bd_acquire 通过这个特殊的 inode，找到 struct block_device。

```cpp
static struct block_device *bd_acquire(struct inode *inode)
{
  struct block_device *bdev;
......
  bdev = bdget(inode->i_rdev);
  if (bdev) {
    spin_lock(&bdev_lock);
    if (!inode->i_bdev) {
      /*
       * We take an additional reference to bd_inode,
       * and it's released in clear_inode() of inode.
       * So, we can access it via ->i_mapping always
       * without igrab().
       */
      bdgrab(bdev);
      inode->i_bdev = bdev;
      inode->i_mapping = bdev->bd_inode->i_mapping;
    }
  }
  return bdev;
}
```

bd_acquire 中最主要的就是调用 bdget，它的参数是特殊 inode 的 i_rdev。这里面在 mknod 的时候，放的是设备号 dev_t。

```cpp
struct block_device *bdget(dev_t dev)
{
        struct block_device *bdev;
        struct inode *inode;


        inode = iget5_locked(blockdev_superblock, hash(dev),
                        bdev_test, bdev_set, &dev);

        bdev = &BDEV_I(inode)->bdev;


        if (inode->i_state & I_NEW) {
                bdev->bd_contains = NULL;
                bdev->bd_super = NULL;
                bdev->bd_inode = inode;
                bdev->bd_block_size = i_blocksize(inode);
                bdev->bd_part_count = 0;
                bdev->bd_invalidated = 0;
                inode->i_mode = S_IFBLK;
                inode->i_rdev = dev;
                inode->i_bdev = bdev;
                inode->i_data.a_ops = &def_blk_aops;
                mapping_set_gfp_mask(&inode->i_data, GFP_USER);
                spin_lock(&bdev_lock);
                list_add(&bdev->bd_list, &all_bdevs);
                spin_unlock(&bdev_lock);
                unlock_new_inode(inode);
        }
        return bdev;
}
```

在 bdget 中，我们遇到了第三个文件系统，bdev 伪文件系统。bdget 函数根据传进来的 dev_t，在 blockdev_superblock 这个文件系统里面找到 inode。这里注意，这个 inode 已经不是 devtmpfs 文件系统的 inode 了。blockdev_superblock 的初始化在整个系统初始化的时候，会调用 bdev_cache_init 进行初始化。它的定义如下：

```cpp
struct super_block *blockdev_superblock __read_mostly;


static struct file_system_type bd_type = {
        .name           = "bdev",
        .mount          = bd_mount,
        .kill_sb        = kill_anon_super,
};


void __init bdev_cache_init(void)
{
        int err;
        static struct vfsmount *bd_mnt;


        bdev_cachep = kmem_cache_create("bdev_cache", sizeof(struct bdev_inode), 0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|SLAB_ACCOUNT|SLAB_PANIC), init_once);
        err = register_filesystem(&bd_type);
        if (err)
                panic("Cannot register bdev pseudo-fs");
        bd_mnt = kern_mount(&bd_type);
        if (IS_ERR(bd_mnt))
                panic("Cannot create bdev pseudo-fs");
        blockdev_superblock = bd_mnt->mnt_sb;   /* For writeback */
}
```

所有表示块设备的 inode 都保存在伪文件系统 bdev 中，这些对用户层不可见，主要为了方便块设备的管理。Linux 将块设备的 block_device 和 bdev 文件系统的块设备的 inode，通过 struct bdev_inode 进行关联。所以，在 bdget 中，BDEV_I 就是通过 bdev 文件系统的 inode，获得整个 struct bdev_inode 结构的地址，然后取成员 bdev，得到 block_device。

```cpp
struct bdev_inode {
  struct block_device bdev;
  struct inode vfs_inode;
};
```

绕了一大圈，我们终于通过设备文件 /dev/xxx，获得了设备的结构 block_device。有点儿绕，我们再捋一下。设备文件 /dev/xxx 在 devtmpfs 文件系统中，找到 devtmpfs 文件系统中的 inode，里面有 dev_t。我们可以通过 dev_t，在伪文件系统 bdev 中找到对应的 inode，然后根据 struct bdev_inode 找到关联的 block_device。

接下来，blkdev_get_by_path 开始做第二件事情，在找到 block_device 之后，要调用 blkdev_get 打开这个设备。blkdev_get 会调用 \_\_blkdev_get。

在分析打开一个设备之前，我们先来看 block_device 这个结构是什么样的。

```cpp
struct block_device {
  dev_t      bd_dev;  /* not a kdev_t - it's a search key */
  int      bd_openers;
  struct super_block *  bd_super;
......
  struct block_device *  bd_contains;
  unsigned    bd_block_size;
  struct hd_struct *  bd_part;
  unsigned    bd_part_count;
  int      bd_invalidated;
  struct gendisk *  bd_disk;
  struct request_queue *  bd_queue;
  struct backing_dev_info *bd_bdi;
  struct list_head  bd_list;
......
} ;
```

你应该能发现，这个结构和其他几个结构有着千丝万缕的联系，比较复杂。这是因为块设备本身就比较复杂。

比方说，我们有一个磁盘 /dev/sda，我们既可以把它整个格式化成一个文件系统，也可以把它分成多个分区 /dev/sda1、 /dev/sda2，然后把每个分区格式化成不同的文件系统。如果我们访问某个分区的设备文件 /dev/sda2，我们应该能知道它是哪个磁盘设备的。按说它们的驱动应该是一样的。如果我们访问整个磁盘的设备文件 /dev/sda，我们也应该能知道它分了几个区域，所以就有了下图这个复杂的关系结构。

![](https://static001.geekbang.org/resource/image/85/76/85f4d83e7ebf2aadf7ffcd5fd393b176.png)

struct gendisk 是用来描述整个设备的，因而上面的例子中，gendisk 只有一个实例，指向 /dev/sda。它的定义如下：

```cpp
struct gendisk {
  int major;      /* major number of driver */
  int first_minor;
  int minors;                     /* maximum number of minors, =1 for disks that can't be partitioned. */
  char disk_name[DISK_NAME_LEN];  /* name of major driver */
  char *(*devnode)(struct gendisk *gd, umode_t *mode);
......
  struct disk_part_tbl __rcu *part_tbl;
  struct hd_struct part0;


  const struct block_device_operations *fops;
  struct request_queue *queue;
  void *private_data;


  int flags;
  struct kobject *slave_dir;
......
};
```

这里 major 是主设备号，first_minor 表示第一个分区的从设备号，minors 表示分区的数目。

disk_name 给出了磁盘块设备的名称。

struct disk_part_tbl 结构里是一个 struct hd_struct 的数组，用于表示各个分区。struct block_device_operations fops 指向对于这个块设备的各种操作。struct request_queue queue 是表示在这个块设备上的请求队列。

struct hd_struct 是用来表示某个分区的，在上面的例子中，有两个 hd_struct 的实例，分别指向 /dev/sda1、 /dev/sda2。它的定义如下：

```cpp
struct hd_struct {
  sector_t start_sect;
  sector_t nr_sects;
......
  struct device __dev;
  struct kobject *holder_dir;
  int policy, partno;
  struct partition_meta_info *info;
......
  struct disk_stats dkstats;
  struct percpu_ref ref;
  struct rcu_head rcu_head;
};
```

在 hd_struct 中，比较重要的成员变量保存了如下的信息：从磁盘的哪个扇区开始，到哪个扇区结束。

而 block_device 既可以表示整个块设备，也可以表示某个分区，所以对于上面的例子，block_device 有三个实例，分别指向 /dev/sda1、/dev/sda2、/dev/sda。

block_device 的成员变量 bd_disk，指向的 gendisk 就是整个块设备。这三个实例都指向同一个 gendisk。bd_part 指向的某个分区的 hd_struct，bd_contains 指向的是整个块设备的 block_device。

了解了这些复杂的关系，我们再来看打开设备文件的代码，就会清晰很多。

```cpp
static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
{
  struct gendisk *disk;
  struct module *owner;
  int ret;
  int partno;
  int perm = 0;


  if (mode & FMODE_READ)
    perm |= MAY_READ;
  if (mode & FMODE_WRITE)
    perm |= MAY_WRITE;
......
  disk = get_gendisk(bdev->bd_dev, &partno);
......
  owner = disk->fops->owner;
......
  if (!bdev->bd_openers) {
    bdev->bd_disk = disk;
    bdev->bd_queue = disk->queue;
    bdev->bd_contains = bdev;


    if (!partno) {
      ret = -ENXIO;
      bdev->bd_part = disk_get_part(disk, partno);
......
      if (disk->fops->open) {
        ret = disk->fops->open(bdev, mode);
......
      }


      if (!ret)
        bd_set_size(bdev,(loff_t)get_capacity(disk)<<9);


      if (bdev->bd_invalidated) {
        if (!ret)
          rescan_partitions(disk, bdev);
......
      }
......
    } else {
      struct block_device *whole;
      whole = bdget_disk(disk, 0);
......
      ret = __blkdev_get(whole, mode, 1);
......
      bdev->bd_contains = whole;
      bdev->bd_part = disk_get_part(disk, partno);
......
      bd_set_size(bdev, (loff_t)bdev->bd_part->nr_sects << 9);
    }
  }
......
  bdev->bd_openers++;
  if (for_part)
    bdev->bd_part_count++;
.....
}

```

在 \_\_blkdev_get 函数中，我们先调用 get_gendisk，根据 block_device 获取 gendisk。具体代码如下：

```cpp
/**
 * get_gendisk - get partitioning information for a given device
 * @devt: device to get partitioning information for
 * @partno: returned partition index
 *
 * This function gets the structure containing partitioning
 * information for the given device @devt.
 */
struct gendisk *get_gendisk(dev_t devt, int *partno)
{
  struct gendisk *disk = NULL;


  if (MAJOR(devt) != BLOCK_EXT_MAJOR) {
    struct kobject *kobj;


    kobj = kobj_lookup(bdev_map, devt, partno);
    if (kobj)
      disk = dev_to_disk(kobj_to_dev(kobj));
  } else {
    struct hd_struct *part;
    part = idr_find(&ext_devt_idr, blk_mangle_minor(MINOR(devt)));
    if (part && get_disk(part_to_disk(part))) {
      *partno = part->partno;
      disk = part_to_disk(part);
    }
  }
  return disk;
}
```

我们可以想象这里面有两种情况。第一种情况是，block_device 是指向整个磁盘设备的。这个时候，我们只需要根据 dev_t，在 bdev_map 中将对应的 gendisk 拿出来就好。

bdev_map 是干什么的呢？前面咱们学习字符设备驱动的时候讲过，任何一个字符设备初始化的时候，都需要调用 \_\_register_chrdev_region，注册这个字符设备。对于块设备也是类似的，每一个块设备驱动初始化的时候，都会调用 add_disk 注册一个 gendisk。

这里需要说明一下，gen 的意思是 general 通用的意思，也就是说，所有的块设备，不仅仅是硬盘 disk，都会用一个 gendisk 来表示，然后通过调用链 add_disk->device_add_disk->blk_register_region，将 dev_t 和一个 gendisk 关联起来，保存在 bdev_map 中。

```cpp
static struct kobj_map *bdev_map;


static inline void add_disk(struct gendisk *disk)
{
  device_add_disk(NULL, disk);
}


/**
 * device_add_disk - add partitioning information to kernel list
 * @parent: parent device for the disk
 * @disk: per-device partitioning information
 *
 * This function registers the partitioning information in @disk
 * with the kernel.
 */
void device_add_disk(struct device *parent, struct gendisk *disk)
{
......
blk_register_region(disk_devt(disk), disk->minors, NULL,
          exact_match, exact_lock, disk);
.....
}


/*
 * Register device numbers dev..(dev+range-1)
 * range must be nonzero
 * The hash chain is sorted on range, so that subranges can override.
 */
void blk_register_region(dev_t devt, unsigned long range, struct module *module,
       struct kobject *(*probe)(dev_t, int *, void *),
       int (*lock)(dev_t, void *), void *data)
{
  kobj_map(bdev_map, devt, range, module, probe, lock, data);
}
```

get_gendisk 要处理的第二种情况是，block_device 是指向某个分区的。这个时候我们要先得到 hd_struct，然后通过 hd_struct，找到对应的整个设备的 gendisk，并且把 partno 设置为分区号。

我们再回到 \_\_blkdev_get 函数中，得到 gendisk。接下来我们可以分两种情况。

如果 partno 为 0，也就是说，打开的是整个设备而不是分区，那我们就调用 disk_get_part，获取 gendisk 中的分区数组，然后调用 block_device_operations 里面的 open 函数打开设备。

如果 partno 不为 0，也就是说打开的是分区，那我们就获取整个设备的 block_device，赋值给变量 struct block_device \*whole，然后调用递归 \_\_blkdev_get，打开 whole 代表的整个设备，将 bd_contains 设置为变量 whole。

block_device_operations 就是在驱动层了。例如在 drivers/scsi/sd.c 里面，也就是 MODULE_DESCRIPTION(“SCSI disk (sd) driver”) 中，就有这样的定义。

```cpp
static const struct block_device_operations sd_fops = {
  .owner      = THIS_MODULE,
  .open      = sd_open,
  .release    = sd_release,
  .ioctl      = sd_ioctl,
  .getgeo      = sd_getgeo,
#ifdef CONFIG_COMPAT
  .compat_ioctl    = sd_compat_ioctl,
#endif
  .check_events    = sd_check_events,
  .revalidate_disk  = sd_revalidate_disk,
  .unlock_native_capacity  = sd_unlock_native_capacity,
  .pr_ops      = &sd_pr_ops,
};


/**
 *  sd_open - open a scsi disk device
 *  @bdev: Block device of the scsi disk to open
 *  @mode: FMODE_* mask
 *
 *  Returns 0 if successful. Returns a negated errno value in case
 *  of error.
 **/
static int sd_open(struct block_device *bdev, fmode_t mode)
{
......
}
```

在驱动层打开了磁盘设备之后，我们可以看到，在这个过程中，block_device 相应的成员变量该填的都填上了，这才完成了 mount_bdev 的第一件大事，通过 blkdev_get_by_path 得到 block_device。

接下来就是第二件大事情，我们要通过 sget，将 block_device 塞进 superblock 里面。注意，调用 sget 的时候，有一个参数是一个函数 set_bdev_super。这里面将 block_device 设置进了 super_block。而 sget 要做的，就是分配一个 super_block，然后调用 set_bdev_super 这个 callback 函数。这里的 super_block 是 ext4 文件系统的 super_block。

sget(fs_type, test_bdev_super, set_bdev_super, flags | MS_NOSEC, bdev);

```cpp
static int set_bdev_super(struct super_block *s, void *data)
{
  s->s_bdev = data;
  s->s_dev = s->s_bdev->bd_dev;
  s->s_bdi = bdi_get(s->s_bdev->bd_bdi);
  return 0;
}


/**
 *  sget  -  find or create a superblock
 *  @type:    filesystem type superblock should belong to
 *  @test:    comparison callback
 *  @set:    setup callback
 *  @flags:    mount flags
 *  @data:    argument to each of them
 */
struct super_block *sget(struct file_system_type *type,
      int (*test)(struct super_block *,void *),
      int (*set)(struct super_block *,void *),
      int flags,
      void *data)
{
......
  return sget_userns(type, test, set, flags, user_ns, data);
}


/**
 *  sget_userns -  find or create a superblock
 *  @type:  filesystem type superblock should belong to
 *  @test:  comparison callback
 *  @set:  setup callback
 *  @flags:  mount flags
 *  @user_ns: User namespace for the super_block
 *  @data:  argument to each of them
 */
struct super_block *sget_userns(struct file_system_type *type,
      int (*test)(struct super_block *,void *),
      int (*set)(struct super_block *,void *),
      int flags, struct user_namespace *user_ns,
      void *data)
{
  struct super_block *s = NULL;
  struct super_block *old;
  int err;
......
  if (!s) {
    s = alloc_super(type, (flags & ~MS_SUBMOUNT), user_ns);
......
  }
  err = set(s, data);
......
  s->s_type = type;
  strlcpy(s->s_id, type->name, sizeof(s->s_id));
  list_add_tail(&s->s_list, &super_blocks);
  hlist_add_head(&s->s_instances, &type->fs_supers);
  spin_unlock(&sb_lock);
  get_filesystem(type);
  register_shrinker(&s->s_shrink);
  return s;
}
```

好了，到此为止，mount 中一个块设备的过程就结束了。设备打开了，形成了 block_device 结构，并且塞到了 super_block 中。

有了 ext4 文件系统的 super_block 之后，接下来对于文件的读写过程，就和文件系统那一章的过程一摸一样了。只要不涉及真正写入设备的代码，super_block 中的这个 block_device 就没啥用处。这也是为什么文件系统那一章，我们丝毫感觉不到它的存在，但是一旦到了底层，就到了 block_device 起作用的时候了，这个我们下一节仔细分析。

### 总结时刻

从这一节我们可以看出，块设备比字符设备复杂多了，涉及三个文件系统，工作过程我用一张图总结了一下，下面带你总结一下。

1. 所有的块设备被一个 map 结构管理从 dev_t 到 gendisk 的映射；
2. 所有的 block_device 表示的设备或者分区都在 bdev 文件系统的 inode 列表中；
3. mknod 创建出来的块设备文件在 devtemfs 文件系统里面，特殊 inode 里面有块设备号；
4. mount 一个块设备上的文件系统，调用这个文件系统的 mount 接口；
5. 通过按照 /dev/xxx 在文件系统 devtmpfs 文件系统上搜索到特殊 inode，得到块设备号；
6. 根据特殊 inode 里面的 dev_t 在 bdev 文件系统里面找到 inode；
7. 根据 bdev 文件系统上的 inode 找到对应的 block_device，根据 dev_t 在 map 中找到 gendisk，将两者关联起来；
8. 找到 block_device 后打开设备，调用和 block_device 关联的 gendisk 里面的 block_device_operations 打开设备；
9. 创建被 mount 的文件系统的 super_block。

![](https://static001.geekbang.org/resource/image/62/20/6290b73283063f99d6eb728c26339620.png)

### 课堂练习

到这里，你是否真的体会到了 Linux 里面“一切皆文件”了呢？那个特殊的 inode 除了能够表示字符设备和块设备，还能表示什么呢？请你看代码分析一下。

欢迎留言和我分享你的疑惑和见解 ，也欢迎可以收藏本节内容，反复研读。你也可以把今天的内容分享给你的朋友，和他一起学习和进步。
