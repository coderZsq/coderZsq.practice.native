上一节，我们讲了主动调度，就是进程运行到一半，因为等待 I/O 等操作而主动让出 CPU，然后就进入了我们的“进程调度第一定律”。所有进程的调用最终都会走 \_\_schedule 函数。那这个定律在这一节还是要继续起作用。

### 抢占式调度

上一节我们讲的主动调度是第一种方式，第二种方式，就是抢占式调度。什么情况下会发生抢占呢？

最常见的现象就是一个进程执行时间太长了，是时候切换到另一个进程了。那怎么衡量一个进程的运行时间呢？在计算机里面有一个时钟，会过一段时间触发一次时钟中断，通知操作系统，时间又过去一个时钟周期，这是个很好的方式，可以查看是否是需要抢占的时间点。

时钟中断处理函数会调用 scheduler_tick()，它的代码如下：

```cpp
void scheduler_tick(void)
{
  int cpu = smp_processor_id();
  struct rq *rq = cpu_rq(cpu);
  struct task_struct *curr = rq->curr;
......
  curr->sched_class->task_tick(rq, curr, 0);
  cpu_load_update_active(rq);
  calc_global_load_tick(rq);
......
}
```

这个函数先取出当前 CPU 的运行队列，然后得到这个队列上当前正在运行中的进程的 task_struct，然后调用这个 task_struct 的调度类的 task_tick 函数，顾名思义这个函数就是来处理时钟事件的。

如果当前运行的进程是普通进程，调度类为 fair_sched_class，调用的处理时钟的函数为 task_tick_fair。我们来看一下它的实现。

```cpp
static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
{
  struct cfs_rq *cfs_rq;
  struct sched_entity *se = &curr->se;


  for_each_sched_entity(se) {
    cfs_rq = cfs_rq_of(se);
    entity_tick(cfs_rq, se, queued);
  }
......
}
```

根据当前进程的 task_struct，找到对应的调度实体 sched_entity 和 cfs_rq 队列，调用 entity_tick。

```cpp
static void
entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
{
  update_curr(cfs_rq);
  update_load_avg(curr, UPDATE_TG);
  update_cfs_shares(curr);
.....
  if (cfs_rq->nr_running > 1)
    check_preempt_tick(cfs_rq, curr);
}
```

在 entity_tick 里面，我们又见到了熟悉的 update_curr。它会更新当前进程的 vruntime，然后调用 check_preempt_tick。顾名思义就是，检查是否是时候被抢占了。

```cpp
static void
check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
{
  unsigned long ideal_runtime, delta_exec;
  struct sched_entity *se;
  s64 delta;


  ideal_runtime = sched_slice(cfs_rq, curr);
  delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
  if (delta_exec > ideal_runtime) {
    resched_curr(rq_of(cfs_rq));
    return;
  }
......
  se = __pick_first_entity(cfs_rq);
  delta = curr->vruntime - se->vruntime;
  if (delta < 0)
    return;
  if (delta > ideal_runtime)
    resched_curr(rq_of(cfs_rq));
}
```

check_preempt_tick 先是调用 sched_slice 函数计算出的 ideal_runtime。ideal_runtime 是一个调度周期中，该进程运行的实际时间。

sum_exec_runtime 指进程总共执行的实际时间，prev_sum_exec_runtime 指上次该进程被调度时已经占用的实际时间。每次在调度一个新的进程时都会把它的 se->prev_sum_exec_runtime = se->sum_exec_runtime，所以 sum_exec_runtime-prev_sum_exec_runtime 就是这次调度占用实际时间。如果这个时间大于 ideal_runtime，则应该被抢占了。

除了这个条件之外，还会通过 \_\_pick_first_entity 取出红黑树中最小的进程。如果当前进程的 vruntime 大于红黑树中最小的进程的 vruntime，且差值大于 ideal_runtime，也应该被抢占了。

当发现当前进程应该被抢占，不能直接把它踢下来，而是把它标记为应该被抢占。为什么呢？因为进程调度第一定律呀，一定要等待正在运行的进程调用 \_\_schedule 才行啊，所以这里只能先标记一下。

标记一个进程应该被抢占，都是调用 resched_curr，它会调用 set_tsk_need_resched，标记进程应该被抢占，但是此时此刻，并不真的抢占，而是打上一个标签 TIF_NEED_RESCHED。

```cpp
static inline void set_tsk_need_resched(struct task_struct *tsk)
{
  set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
}
```

另外一个可能抢占的场景是当一个进程被唤醒的时候。

我们前面说过，当一个进程在等待一个 I/O 的时候，会主动放弃 CPU。但是当 I/O 到来的时候，进程往往会被唤醒。这个时候是一个时机。当被唤醒的进程优先级高于 CPU 上的当前进程，就会触发抢占。try_to_wake_up() 调用 ttwu_queue 将这个唤醒的任务添加到队列当中。ttwu_queue 再调用 ttwu_do_activate 激活这个任务。ttwu_do_activate 调用 ttwu_do_wakeup。这里面调用了 check_preempt_curr 检查是否应该发生抢占。如果应该发生抢占，也不是直接踢走当前进程，而是将当前进程标记为应该被抢占。

```cpp
static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
         struct rq_flags *rf)
{
  check_preempt_curr(rq, p, wake_flags);
  p->state = TASK_RUNNING;
  trace_sched_wakeup(p);
```

到这里，你会发现，抢占问题只做完了一半。就是标识当前运行中的进程应该被抢占了，但是真正的抢占动作并没有发生。

### 抢占的时机

真正的抢占还需要时机，也就是需要那么一个时刻，让正在运行中的进程有机会调用一下 \_\_schedule。

你可以想象，不可能某个进程代码运行着，突然要去调用 \_\_schedule，代码里面不可能这么写，所以一定要规划几个时机，这个时机分为用户态和内核态。

### 用户态的抢占时机

对于用户态的进程来讲，从系统调用中返回的那个时刻，是一个被抢占的时机。

前面讲系统调用的时候，64 位的系统调用的链路位 do_syscall_64->syscall_return_slowpath->prepare_exit_to_usermode->exit_to_usermode_loop，当时我们还没关注 exit_to_usermode_loop 这个函数，现在我们来看一下。

```cpp
static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
{
  while (true) {
    /* We have work to do. */
    local_irq_enable();


    if (cached_flags & _TIF_NEED_RESCHED)
      schedule();
......
  }
}
```

现在我们看到在 exit_to_usermode_loop 函数中，上面打的标记起了作用，如果被打了 \_TIF_NEED_RESCHED，调用 schedule 进行调度，调用的过程和上一节解析的一样，会选择一个进程让出 CPU，做上下文切换。

对于用户态的进程来讲，从中断中返回的那个时刻，也是一个被抢占的时机。

在 arch/x86/entry/entry_64.S 中有中断的处理过程。又是一段汇编语言代码，你重点领会它的意思就行，不要纠结每一行都看懂。

```s
common_interrupt:
        ASM_CLAC
        addq    $-0x80, (%rsp)
        interrupt do_IRQ
ret_from_intr:
        popq    %rsp
        testb   $3, CS(%rsp)
        jz      retint_kernel
/* Interrupt came from user space */
GLOBAL(retint_user)
        mov     %rsp,%rdi
        call    prepare_exit_to_usermode
        TRACE_IRQS_IRETQ
        SWAPGS
        jmp     restore_regs_and_iret
/* Returning to kernel space */
retint_kernel:
#ifdef CONFIG_PREEMPT
        bt      $9, EFLAGS(%rsp)
        jnc     1f
0:      cmpl    $0, PER_CPU_VAR(__preempt_count)
        jnz     1f
        call    preempt_schedule_irq
        jmp     0b
```

中断处理调用的是 do_IRQ 函数，中断完毕后分为两种情况，一个是返回用户态，一个是返回内核态。这个通过注释也能看出来。

咱们先来看返回用户态这一部分，先不管返回内核态的那部分代码，retint_user 会调用 prepare_exit_to_usermode，最终调用 exit_to_usermode_loop，和上面的逻辑一样，发现有标记则调用 schedule()。

### 内核态的抢占时机

用户态的抢占时机讲完了，接下来我们看内核态的抢占时机。

对内核态的执行中，被抢占的时机一般发生在 preempt_enable() 中。

在内核态的执行中，有的操作是不能被中断的，所以在进行这些操作之前，总是先调用 preempt_disable() 关闭抢占，当再次打开的时候，就是一次内核态代码被抢占的机会。

就像下面代码中展示的一样，preempt_enable() 会调用 preempt_count_dec_and_test()，判断 preempt_count 和 TIF_NEED_RESCHED 是否可以被抢占。如果可以，就调用 preempt_schedule->preempt_schedule_common->\_\_schedule 进行调度。还是满足进程调度第一定律的。

```cpp
#define preempt_enable() \
do { \
  if (unlikely(preempt_count_dec_and_test())) \
    __preempt_schedule(); \
} while (0)


#define preempt_count_dec_and_test() \
  ({ preempt_count_sub(1); should_resched(0); })


static __always_inline bool should_resched(int preempt_offset)
{
  return unlikely(preempt_count() == preempt_offset &&
      tif_need_resched());
}


#define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)


static void __sched notrace preempt_schedule_common(void)
{
  do {
......
    __schedule(true);
......
  } while (need_resched())
```

在内核态也会遇到中断的情况，当中断返回的时候，返回的仍然是内核态。这个时候也是一个执行抢占的时机，现在我们再来上面中断返回的代码中返回内核的那部分代码，调用的是 preempt_schedule_irq。

```cpp
asmlinkage __visible void __sched preempt_schedule_irq(void)
{
......
  do {
    preempt_disable();
    local_irq_enable();
    __schedule(true);
    local_irq_disable();
    sched_preempt_enable_no_resched();
  } while (need_resched());
......
}
```

### 总结时刻

好了，抢占式调度就讲到这里了。我这里画了一张脑图，将整个进程的调度体系都放在里面。

这个脑图里面第一条就是总结了进程调度第一定律的核心函数 \_\_schedule 的执行过程，这是上一节讲的，因为要切换的东西比较多，需要你详细了解每一部分是如何切换的。

第二条总结了标记为可抢占的场景，第三条是所有的抢占发生的时机，这里是真正验证了进程调度第一定律的。

![](https://static001.geekbang.org/resource/image/93/7f/93588d71abd7f007397979f0ba7def7f.png)

### 课堂练习

通过对于内核中进程调度的分析，我们知道，时间对于调度是很重要的，你知道 Linux 内核是如何管理和度量时间的吗？

欢迎留言和我分享你的疑惑和见解，也欢迎你收藏本节内容，反复研读。你也可以把今天的内容分享给你的朋友，和他一起学习、进步。
