前面两节，我们讲了如何使用系统调用，创建进程和线程。你是不是觉得进程和线程管理，还挺复杂的呢？如此复杂的体系，在内核里面应该如何管理呢？

有的进程只有一个线程，有的进程有多个线程，它们都需要由内核分配 CPU 来干活。可是 CPU 总共就这么几个，应该怎么管理，怎么调度呢？你是老板，这个事儿得你来操心。

首先，我们得明确，公司的项目售前售后人员，接来了这么多的项目，这是个好事儿。这些项目都通过办事大厅立了项的，有的需要整个项目组一起开发，有的是一个项目组分成多个小组并行开发。无论哪种模式，到你这个老板这里，都需要有一个项目管理体系，进行统一排期、统一管理和统一协调。这样，你才能对公司的业务了如指掌。

那具体应该怎么做呢？还记得咱们平时开发的时候，用的项目管理软件 Jira 吧？它的办法对我们来讲，就很有参考意义。

我们这么来看，其实，无论是一个大的项目组一起完成一个大的功能（单体应用模式），还是把一个大的功能拆成小的功能并行开发（微服务模式），这些都是开发组根据客户的需求来定的，项目经理没办法决定，但是从项目经理的角度来看，这些都是任务，需要同样关注进度、协调资源等等。

同样在 Linux 里面，无论是进程，还是线程，到了内核里面，我们统一都叫任务（Task），由一个统一的结构 task_struct 进行管理。这个结构非常复杂，但你也不用怕，我们慢慢来解析。

![](https://static001.geekbang.org/resource/image/75/2d/75c4d28a9d2daa4acc1107832be84e2d.jpeg)

接下来，我们沿着建立项目管理体系的思路，设想一下，Linux 的任务管理都应该干些啥？

首先，所有执行的项目应该有个项目列表吧，所以 Linux 内核也应该先弄一个链表，将所有的 task_struct 串起来。

```cpp
struct list_head    tasks;
```

接下来，我们来看每一个任务都应该包含哪些字段。

### 任务 ID

每一个任务都应该有一个 ID，作为这个任务的唯一标识。到时候排期啊、下发任务啊等等，都按 ID 来，就不会产生歧义。

task_struct 里面涉及任务 ID 的，有下面几个：

```cpp
pid_t pid;
pid_t tgid;
struct task_struct *group_leader;
```

你可能觉得奇怪，既然是 ID，有一个就足以做唯一标识了，这个怎么看起来这么麻烦？这是因为，上面的进程和线程到了内核这里，统一变成了任务，这就带来两个问题。

第一个问题是，任务展示。

啥是任务展示呢？这么说吧，你作为老板，想了解的肯定是，公司都接了哪些项目，每个项目多少营收。什么项目执行是不是分了小组，每个小组是啥情况，这些细节，项目经理没必要全都展示给你看。

前面我们学习命令行的时候，知道 ps 命令可以展示出所有的进程。但是如果你是这个命令的实现者，到了内核，按照上面的任务列表把这些命令都显示出来，把所有的线程全都平摊开来显示给用户。用户肯定觉得既复杂又困惑。复杂在于，列表这么长；困惑在于，里面出现了很多并不是自己创建的线程。

第二个问题是，给任务下发指令。

如果客户突然给项目组提个新的需求，比如说，有的客户觉得项目已经完成，可以终止；再比如说，有的客户觉得项目做到一半没必要再进行下去了，可以中止，这时候应该给谁发指令？当然应该给整个项目组，而不是某个小组。我们不能让客户看到，不同的小组口径不一致。这就好比说，中止项目的指令到达一个小组，这个小组很开心就去休息了，同一个项目组的其他小组还干的热火朝天的。

Linux 也一样，前面我们学习命令行的时候，知道可以通过 kill 来给进程发信号，通知进程退出。如果发给了其中一个线程，我们就不能只退出这个线程，而是应该退出整个进程。当然，有时候，我们希望只给某个线程发信号。

所以在内核中，它们虽然都是任务，但是应该加以区分。其中，pid 是 process id，tgid 是 thread group ID。

任何一个进程，如果只有主线程，那 pid 是自己，tgid 是自己，group_leader 指向的还是自己。

但是，如果一个进程创建了其他线程，那就会有所变化了。线程有自己的 pid，tgid 就是进程的主线程的 pid，group_leader 指向的就是进程的主线程。

好了，有了 tgid，我们就知道 tast_struct 代表的是一个进程还是代表一个线程了。

### 信号处理

这里既然提到了下发指令的问题，我就顺便提一下 task_struct 里面关于信号处理的字段。

```cpp
/* Signal handlers: */
struct signal_struct    *signal;
struct sighand_struct    *sighand;
sigset_t      blocked;
sigset_t      real_blocked;
sigset_t      saved_sigmask;
struct sigpending    pending;
unsigned long      sas_ss_sp;
size_t        sas_ss_size;
unsigned int      sas_ss_flags;
```

这里定义了哪些信号被阻塞暂不处理（blocked），哪些信号尚等待处理（pending），哪些信号正在通过信号处理函数进行处理（sighand）。处理的结果可以是忽略，可以是结束进程等等。

信号处理函数默认使用用户态的函数栈，当然也可以开辟新的栈专门用于信号处理，这就是 sas_ss_xxx 这三个变量的作用。

上面我说了下发信号的时候，需要区分进程和线程。从这里我们其实也能看出一些端倪。

task_struct 里面有一个 struct sigpending pending。如果我们进入 struct signal_struct \*signal 去看的话，还有一个 struct sigpending shared_pending。它们一个是本任务的，一个是线程组共享的。

关于信号，你暂时了解到这里就够用了，后面我们会有单独的章节进行解读。

### 任务状态

作为一个项目经理，另外一个需要关注的是项目当前的状态。例如，在 Jira 里面，任务的运行就可以分成下面的状态。

![](https://static001.geekbang.org/resource/image/e0/21/e0019fcd11ff1ba33a3389e285b6a121.jpg)

在 task_struct 里面，涉及任务状态的是下面这几个变量：

```cpp
 volatile long state;    /* -1 unrunnable, 0 runnable, >0 stopped */
 int exit_state;
 unsigned int flags;
```

state（状态）可以取的值定义在 include/linux/sched.h 头文件中。

```cpp
/* Used in tsk->state: */
#define TASK_RUNNING                    0
#define TASK_INTERRUPTIBLE              1
#define TASK_UNINTERRUPTIBLE            2
#define __TASK_STOPPED                  4
#define __TASK_TRACED                   8
/* Used in tsk->exit_state: */
#define EXIT_DEAD                       16
#define EXIT_ZOMBIE                     32
#define EXIT_TRACE                      (EXIT_ZOMBIE | EXIT_DEAD)
/* Used in tsk->state again: */
#define TASK_DEAD                       64
#define TASK_WAKEKILL                   128
#define TASK_WAKING                     256
#define TASK_PARKED                     512
#define TASK_NOLOAD                     1024
#define TASK_NEW                        2048
#define TASK_STATE_MAX                  4096
```

从定义的数值很容易看出来，state 是通过 bitset 的方式设置的，也就是说，当前是什么状态，哪一位就置一。

![](https://static001.geekbang.org/resource/image/e2/88/e2fa348c67ce41ef730048ff9ca4c988.jpeg)

TASK_RUNNING 并不是说进程正在运行，而是表示进程在时刻准备运行的状态。当处于这个状态的进程获得时间片的时候，就是在运行中；如果没有获得时间片，就说明它被其他进程抢占了，在等待再次分配时间片。

在运行中的进程，一旦要进行一些 I/O 操作，需要等待 I/O 完毕，这个时候会释放 CPU，进入睡眠状态。

在 Linux 中，有两种睡眠状态。

一种是 TASK_INTERRUPTIBLE，可中断的睡眠状态。这是一种浅睡眠的状态，也就是说，虽然在睡眠，等待 I/O 完成，但是这个时候一个信号来的时候，进程还是要被唤醒。只不过唤醒后，不是继续刚才的操作，而是进行信号处理。当然程序员可以根据自己的意愿，来写信号处理函数，例如收到某些信号，就放弃等待这个 I/O 操作完成，直接退出；或者收到某些信息，继续等待。

另一种睡眠是 TASK_UNINTERRUPTIBLE，不可中断的睡眠状态。这是一种深度睡眠状态，不可被信号唤醒，只能死等 I/O 操作完成。一旦 I/O 操作因为特殊原因不能完成，这个时候，谁也叫不醒这个进程了。你可能会说，我 kill 它呢？别忘了，kill 本身也是一个信号，既然这个状态不可被信号唤醒，kill 信号也被忽略了。除非重启电脑，没有其他办法。

因此，这其实是一个比较危险的事情，除非程序员极其有把握，不然还是不要设置成 TASK_UNINTERRUPTIBLE。

于是，我们就有了一种新的进程睡眠状态，TASK_KILLABLE，可以终止的新睡眠状态。进程处于这种状态中，它的运行原理类似 TASK_UNINTERRUPTIBLE，只不过可以响应致命信号。

从定义可以看出，TASK_WAKEKILL 用于在接收到致命信号时唤醒进程，而 TASK_KILLABLE 相当于这两位都设置了。

```cpp
#define TASK_KILLABLE           (TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
```

TASK_STOPPED 是在进程接收到 SIGSTOP、SIGTTIN、SIGTSTP 或者 SIGTTOU 信号之后进入该状态。

TASK_TRACED 表示进程被 debugger 等进程监视，进程执行被调试程序所停止。当一个进程被另外的进程所监视，每一个信号都会让进程进入该状态。

一旦一个进程要结束，先进入的是 EXIT_ZOMBIE 状态，但是这个时候它的父进程还没有使用 wait() 等系统调用来获知它的终止信息，此时进程就成了僵尸进程。

EXIT_DEAD 是进程的最终状态。

EXIT_ZOMBIE 和 EXIT_DEAD 也可以用于 exit_state。

上面的进程状态和进程的运行、调度有关系，还有其他的一些状态，我们称为标志。放在 flags 字段中，这些字段都被定义成为宏，以 PF 开头。我这里举几个例子。

```cpp
#define PF_EXITING    0x00000004
#define PF_VCPU      0x00000010
#define PF_FORKNOEXEC    0x00000040
```

PF_EXITING 表示正在退出。当有这个 flag 的时候，在函数 find_alive_thread 中，找活着的线程，遇到有这个 flag 的，就直接跳过。

PF_VCPU 表示进程运行在虚拟 CPU 上。在函数 account_system_time 中，统计进程的系统运行时间，如果有这个 flag，就调用 account_guest_time，按照客户机的时间进行统计。

PF_FORKNOEXEC 表示 fork 完了，还没有 exec。在 \_do_fork 函数里面调用 copy_process，这个时候把 flag 设置为 PF_FORKNOEXEC。当 exec 中调用了 load_elf_binary 的时候，又把这个 flag 去掉。

### 进程调度

进程的状态切换往往涉及调度，下面这些字段都是用于调度的。为了让你理解 task_struct 进程管理的全貌，我先在这里列一下，咱们后面会有单独的章节讲解，这里你只要大概看一下里面的注释就好了。

```cpp
//是否在运行队列上
int        on_rq;
//优先级
int        prio;
int        static_prio;
int        normal_prio;
unsigned int      rt_priority;
//调度器类
const struct sched_class  *sched_class;
//调度实体
struct sched_entity    se;
struct sched_rt_entity    rt;
struct sched_dl_entity    dl;
//调度策略
unsigned int      policy;
//可以使用哪些CPU
int        nr_cpus_allowed;
cpumask_t      cpus_allowed;
struct sched_info    sched_info;
```

### 总结时刻

这一节，我们讲述了进程管理复杂的数据结构，我还是画一个图总结一下。这个图是进程管理 task_struct 的结构图。其中红色的部分是今天讲的部分，你可以对着这张图说出它们的含义。

![](https://static001.geekbang.org/resource/image/01/e8/016ae7fb63f8b3fd0ca072cb9964e3e8.jpeg)

### 课堂练习

这一节我们讲了任务的状态，你可以试着在代码里面搜索一下这些状态改变的地方是哪个函数，是什么时机，从而进一步理解任务的概念。

欢迎留言和我分享你的疑惑和见解，也欢迎你收藏本节内容，反复研读。你也可以把今天的内容分享给你的朋友，和他一起学习、进步。
