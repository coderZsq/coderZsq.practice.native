上一节我们讲了，task_struct 这个结构非常长。由此我们可以看出，Linux 内核的任务管理是非常复杂的。上一节，我们只是讲了一部分，今天我们接着来解析剩下的部分。

### 运行统计信息

作为项目经理，你肯定需要了解项目的运行情况。例如，有的员工很长时间都在做一个任务，这个时候你就需要特别关注一下；再如，有的员工的琐碎任务太多，这会大大影响他的工作效率。

那如何才能知道这些员工的工作情况呢？在进程的运行过程中，会有一些统计量，具体你可以看下面的列表。这里面有进程在用户态和内核态消耗的时间、上下文切换的次数等等。

```cpp
u64        utime;//用户态消耗的CPU时间
u64        stime;//内核态消耗的CPU时间
unsigned long      nvcsw;//自愿(voluntary)上下文切换计数
unsigned long      nivcsw;//非自愿(involuntary)上下文切换计数
u64        start_time;//进程启动时间，不包含睡眠时间
u64        real_start_time;//进程启动时间，包含睡眠时间
```

### 进程亲缘关系

从我们之前讲的创建进程的过程，可以看出，任何一个进程都有父进程。所以，整个进程其实就是一棵进程树。而拥有同一父进程的所有进程都具有兄弟关系。

```cpp
struct task_struct __rcu *real_parent; /* real parent process */
struct task_struct __rcu *parent; /* recipient of SIGCHLD, wait4() reports */
struct list_head children;      /* list of my children */
struct list_head sibling;       /* linkage in my parent's children list */
```

- parent 指向其父进程。当它终止时，必须向它的父进程发送信号。
- children 表示链表的头部。链表中的所有元素都是它的子进程。
- sibling 用于把当前进程插入到兄弟链表中。

![](https://static001.geekbang.org/resource/image/92/04/92711107d8dcdf2c19e8fe4ee3965304.jpeg)

通常情况下，real_parent 和 parent 是一样的，但是也会有另外的情况存在。例如，bash 创建一个进程，那进程的 parent 和 real_parent 就都是 bash。如果在 bash 上使用 GDB 来 debug 一个进程，这个时候 GDB 是 parent，bash 是这个进程的 real_parent。

### 进程权限

了解了运行统计信息，接下来，我们需要关注一下项目组权限的控制。什么是项目组权限控制呢？这么说吧，我这个项目组能否访问某个文件，能否访问其他的项目组，以及我这个项目组能否被其他项目组访问等等，这都是项目组权限的控制范畴。

在 Linux 里面，对于进程权限的定义如下：

```cpp
/* Objective and real subjective task credentials (COW): */
const struct cred __rcu         *real_cred;
/* Effective (overridable) subjective task credentials (COW): */
const struct cred __rcu         *cred;
```

这个结构的注释里，有两个名词比较拗口，Objective 和 Subjective。事实上，所谓的权限，就是我能操纵谁，谁能操纵我。

“谁能操作我”，很显然，这个时候我就是被操作的对象，就是 Objective，那个想操作我的就是 Subjective。“我能操作谁”，这个时候我就是 Subjective，那个要被我操作的就是 Objectvie。

“操作”，就是一个对象对另一个对象进行某些动作。当动作要实施的时候，就要审核权限，当两边的权限匹配上了，就可以实施操作。其中，real_cred 就是说明谁能操作我这个进程，而 cred 就是说明我这个进程能够操作谁。

这里 cred 的定义如下：

```cpp
struct cred {
......
        kuid_t          uid;            /* real UID of the task */
        kgid_t          gid;            /* real GID of the task */
        kuid_t          suid;           /* saved UID of the task */
        kgid_t          sgid;           /* saved GID of the task */
        kuid_t          euid;           /* effective UID of the task */
        kgid_t          egid;           /* effective GID of the task */
        kuid_t          fsuid;          /* UID for VFS ops */
        kgid_t          fsgid;          /* GID for VFS ops */
......
        kernel_cap_t    cap_inheritable; /* caps our children can inherit */
        kernel_cap_t    cap_permitted;  /* caps we're permitted */
        kernel_cap_t    cap_effective;  /* caps we can actually use */
        kernel_cap_t    cap_bset;       /* capability bounding set */
        kernel_cap_t    cap_ambient;    /* Ambient capability set */
......
} __randomize_layout;
```

从这里的定义可以看出，大部分是关于用户和用户所属的用户组信息。

第一个是 uid 和 gid，注释是 real user/group id。一般情况下，谁启动的进程，就是谁的 ID。但是权限审核的时候，往往不比较这两个，也就是说不大起作用。

第二个是 euid 和 egid，注释是 effective user/group id。一看这个名字，就知道这个是起“作用”的。当这个进程要操作消息队列、共享内存、信号量等对象的时候，其实就是在比较这个用户和组是否有权限。

第三个是 fsuid 和 fsgid，也就是 filesystem user/group id。这个是对文件操作会审核的权限。

一般说来，fsuid、euid，和 uid 是一样的，fsgid、egid，和 gid 也是一样的。因为谁启动的进程，就应该审核启动的用户到底有没有这个权限。

但是也有特殊的情况。

![](https://static001.geekbang.org/resource/image/c4/f7/c4688c36afd90f933727483c56500ff7.jpeg)

例如，用户 A 想玩一个游戏，这个游戏的程序是用户 B 安装的。游戏这个程序文件的权限为 rwxr–r--。A 是没有权限运行这个程序的，所以用户 B 要给用户 A 权限才行。用户 B 说没问题，都是朋友嘛，于是用户 B 就给这个程序设定了所有的用户都能执行的权限 rwxr-xr-x，说兄弟你玩吧。

于是，用户 A 就获得了运行这个游戏的权限。当游戏运行起来之后，游戏进程的 uid、euid、fsuid 都是用户 A。看起来没有问题，玩得很开心。

用户 A 好不容易通过一关，想保留通关数据的时候，发现坏了，这个游戏的玩家数据是保存在另一个文件里面的。这个文件权限 rw-------，只给用户 B 开了写入权限，而游戏进程的 euid 和 fsuid 都是用户 A，当然写不进去了。完了，这一局白玩儿了。

那怎么解决这个问题呢？我们可以通过 chmod u+s program 命令，给这个游戏程序设置 set-user-ID 的标识位，把游戏的权限变成 rwsr-xr-x。这个时候，用户 A 再启动这个游戏的时候，创建的进程 uid 当然还是用户 A，但是 euid 和 fsuid 就不是用户 A 了，因为看到了 set-user-id 标识，就改为文件的所有者的 ID，也就是说，euid 和 fsuid 都改成用户 B 了，这样就能够将通关结果保存下来。

在 Linux 里面，一个进程可以随时通过 setuid 设置用户 ID，所以，游戏程序的用户 B 的 ID 还会保存在一个地方，这就是 suid 和 sgid，也就是 saved uid 和 save gid。这样就可以很方便地使用 setuid，通过设置 uid 或者 suid 来改变权限。

除了以用户和用户组控制权限，Linux 还有另一个机制就是 capabilities。

原来控制进程的权限，要么是高权限的 root 用户，要么是一般权限的普通用户，这时候的问题是，root 用户权限太大，而普通用户权限太小。有时候一个普通用户想做一点高权限的事情，必须给他整个 root 的权限。这个太不安全了。

于是，我们引入新的机制 capabilities，用位图表示权限，在 capability.h 可以找到定义的权限。我这里列举几个。

```cpp
#define CAP_CHOWN            0
#define CAP_KILL             5
#define CAP_NET_BIND_SERVICE 10
#define CAP_NET_RAW          13
#define CAP_SYS_MODULE       16
#define CAP_SYS_RAWIO        17
#define CAP_SYS_BOOT         22
#define CAP_SYS_TIME         25
#define CAP_AUDIT_READ          37
#define CAP_LAST_CAP         CAP_AUDIT_READ
```

对于普通用户运行的进程，当有这个权限的时候，就能做这些操作；没有的时候，就不能做，这样粒度要小很多。

cap_permitted 表示进程能够使用的权限。但是真正起作用的是 cap_effective。cap_permitted 中可以包含 cap_effective 中没有的权限。一个进程可以在必要的时候，放弃自己的某些权限，这样更加安全。假设自己因为代码漏洞被攻破了，但是如果啥也干不了，就没办法进一步突破。

cap_inheritable 表示当可执行文件的扩展属性设置了 inheritable 位时，调用 exec 执行该程序会继承调用者的 inheritable 集合，并将其加入到 permitted 集合。但在非 root 用户下执行 exec 时，通常不会保留 inheritable 集合，但是往往又是非 root 用户，才想保留权限，所以非常鸡肋。

cap_bset，也就是 capability bounding set，是系统中所有进程允许保留的权限。如果这个集合中不存在某个权限，那么系统中的所有进程都没有这个权限。即使以超级用户权限执行的进程，也是一样的。

这样有很多好处。例如，系统启动以后，将加载内核模块的权限去掉，那所有进程都不能加载内核模块。这样，即便这台机器被攻破，也做不了太多有害的事情。

cap_ambient 是比较新加入内核的，就是为了解决 cap_inheritable 鸡肋的状况，也就是，非 root 用户进程使用 exec 执行一个程序的时候，如何保留权限的问题。当执行 exec 的时候，cap_ambient 会被添加到 cap_permitted 中，同时设置到 cap_effective 中。

### 内存管理

每个进程都有自己独立的虚拟内存空间，这需要有一个数据结构来表示，就是 mm_struct。这个我们在内存管理那一节详细讲述。这里你先有个印象。

```cpp
struct mm_struct                *mm;
struct mm_struct                *active_mm;
```

### 文件与文件系统

每个进程有一个文件系统的数据结构，还有一个打开文件的数据结构。这个我们放到文件系统那一节详细讲述。

```cpp
/* Filesystem information: */
struct fs_struct                *fs;
/* Open file information: */
struct files_struct             *files;
```

### 总结时刻

这一节，我们终于把进程管理复杂的数据结构基本讲完了，请你重点记住以下两点：

- 进程亲缘关系维护的数据结构，是一种很有参考价值的实现方式，在内核中会多个地方出现类似的结构；
- 进程权限中 setuid 的原理，这一点比较难理解，但是很重要，面试经常会考。

你可以对着下面这张图，看看自己是否真的理解了，进程树是如何组织的，以及如何控制进程的权限的。

![](https://static001.geekbang.org/resource/image/1c/bc/1c91956b52574b62a4418a7c6993d8bc.jpeg)

### 课堂练习

通过这一节的学习，你会发现，一个进程的运行竟然要保存这么多信息，这些信息都可以通过命令行取出来，所以今天的练习题就是，对于一个正在运行的进程，通过命令行找到上述进程运行的所有信息。

欢迎留言和我分享你的疑惑和见解，也欢迎你收藏本节内容，反复研读。你也可以把今天的内容分享给你的朋友，和他一起学习、进步。
