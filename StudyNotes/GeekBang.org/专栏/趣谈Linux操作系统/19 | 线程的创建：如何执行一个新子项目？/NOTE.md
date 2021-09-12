上一节，我们了解了进程创建的整个过程，今天我们来看线程创建的过程。

我们前面已经写过多线程编程的程序了，你应该都知道创建一个线程调用的是 pthread_create，可你知道它背后的机制吗？

### 用户态创建线程

你可能会问，咱们之前不是讲过了吗？无论是进程还是线程，在内核里面都是任务，管起来不是都一样吗？但是问题来了，如果两个完全一样，那为什么咱们前两节写的程序差别那么大？如果不一样，那怎么在内核里面加以区分呢？

其实，线程不是一个完全由内核实现的机制，它是由内核态和用户态合作完成的。pthread_create 不是一个系统调用，是 Glibc 库的一个函数，所以我们还要去 Glibc 里面去找线索。

果然，我们在 nptl/pthread_create.c 里面找到了这个函数。这里的参数我们应该比较熟悉了。

```cpp
int __pthread_create_2_1 (pthread_t *newthread, const pthread_attr_t *attr, void *(*start_routine) (void *), void *arg)
{
......
}
versioned_symbol (libpthread, __pthread_create_2_1, pthread_create, GLIBC_2_1);
```

下面我们依次来看这个函数做了些啥。

首先处理的是线程的属性参数。例如前面写程序的时候，我们设置的线程栈大小。如果没有传入线程属性，就取默认值。

```cpp
const struct pthread_attr *iattr = (struct pthread_attr *) attr;
struct pthread_attr default_attr;
if (iattr == NULL)
{
  ......
  iattr = &default_attr;
}
```

接下来，就像在内核里一样，每一个进程或者线程都有一个 task_struct 结构，在用户态也有一个用于维护线程的结构，就是这个 pthread 结构。

```cpp
struct pthread *pd = NULL;
```

凡是涉及函数的调用，都要使用到栈。每个线程也有自己的栈。那接下来就是创建线程栈了。

```cpp
int err = ALLOCATE_STACK (iattr, &pd);
```

ALLOCATE_STACK 是一个宏，我们找到它的定义之后，发现它其实就是一个函数。只是，这个函数有些复杂，所以我这里把主要的代码列一下。

```cpp
# define ALLOCATE_STACK(attr, pd) allocate_stack (attr, pd, &stackaddr)


static int
allocate_stack (const struct pthread_attr *attr, struct pthread **pdp,
                ALLOCATE_STACK_PARMS)
{
  struct pthread *pd;
  size_t size;
  size_t pagesize_m1 = __getpagesize () - 1;
......
  size = attr->stacksize;
......
  /* Allocate some anonymous memory.  If possible use the cache.  */
  size_t guardsize;
  void *mem;
  const int prot = (PROT_READ | PROT_WRITE
                   | ((GL(dl_stack_flags) & PF_X) ? PROT_EXEC : 0));
  /* Adjust the stack size for alignment.  */
  size &= ~__static_tls_align_m1;
  /* Make sure the size of the stack is enough for the guard and
  eventually the thread descriptor.  */
  guardsize = (attr->guardsize + pagesize_m1) & ~pagesize_m1;
  size += guardsize;
  pd = get_cached_stack (&size, &mem);
  if (pd == NULL)
  {
    /* If a guard page is required, avoid committing memory by first
    allocate with PROT_NONE and then reserve with required permission
    excluding the guard page.  */
  mem = __mmap (NULL, size, (guardsize == 0) ? prot : PROT_NONE,
      MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
    /* Place the thread descriptor at the end of the stack.  */
#if TLS_TCB_AT_TP
    pd = (struct pthread *) ((char *) mem + size) - 1;
#elif TLS_DTV_AT_TP
    pd = (struct pthread *) ((((uintptr_t) mem + size - __static_tls_size) & ~__static_tls_align_m1) - TLS_PRE_TCB_SIZE);
#endif
    /* Now mprotect the required region excluding the guard area. */
    char *guard = guard_position (mem, size, guardsize, pd, pagesize_m1);
    setup_stack_prot (mem, size, guard, guardsize, prot);
    pd->stackblock = mem;
    pd->stackblock_size = size;
    pd->guardsize = guardsize;
    pd->specific[0] = pd->specific_1stblock;
    /* And add to the list of stacks in use.  */
    stack_list_add (&pd->list, &stack_used);
  }

  *pdp = pd;
  void *stacktop;
# if TLS_TCB_AT_TP
  /* The stack begins before the TCB and the static TLS block.  */
  stacktop = ((char *) (pd + 1) - __static_tls_size);
# elif TLS_DTV_AT_TP
  stacktop = (char *) (pd - 1);
# endif
  *stack = stacktop;
......
}
```

我们来看一下，allocate_stack 主要做了以下这些事情：

- 如果你在线程属性里面设置过栈的大小，需要你把设置的值拿出来；
- 为了防止栈的访问越界，在栈的末尾会有一块空间 guardsize，一旦访问到这里就错误了；
- 其实线程栈是在进程的堆里面创建的。如果一个进程不断地创建和删除线程，我们不可能不断地去申请和清除线程栈使用的内存块，这样就需要有一个缓存。get_cached_stack 就是根据计算出来的 size 大小，看一看已经有的缓存中，有没有已经能够满足条件的；
- 如果缓存里面没有，就需要调用 \_\_mmap 创建一块新的，系统调用那一节我们讲过，如果要在堆里面 malloc 一块内存，比较大的话，用 \_\_mmap；
- 线程栈也是自顶向下生长的，还记得每个线程要有一个 pthread 结构，这个结构也是放在栈的空间里面的。在栈底的位置，其实是地址最高位；
- 计算出 guard 内存的位置，调用 setup_stack_prot 设置这块内存的是受保护的；
- 接下来，开始填充 pthread 这个结构里面的成员变量 stackblock、stackblock_size、guardsize、specific。这里的 specific 是用于存放 Thread Specific Data 的，也即属于线程的全局变量；
- 将这个线程栈放到 stack_used 链表中，其实管理线程栈总共有两个链表，一个是 stack_used，也就是这个栈正被使用；另一个是 stack_cache，就是上面说的，一旦线程结束，先缓存起来，不释放，等有其他的线程创建的时候，给其他的线程用。

搞定了用户态栈的问题，其实用户态的事情基本搞定了一半。

### 内核态创建任务

接下来，我们接着 pthread_create 看。其实有了用户态的栈，接着需要解决的就是用户态的程序从哪里开始运行的问题。

```cpp
pd->start_routine = start_routine;
pd->arg = arg;
pd->schedpolicy = self->schedpolicy;
pd->schedparam = self->schedparam;
/* Pass the descriptor to the caller.  */
*newthread = (pthread_t) pd;
atomic_increment (&__nptl_nthreads);
retval = create_thread (pd, iattr, &stopped_start, STACK_VARIABLES_ARGS, &thread_ran);
```

start_routine 就是咱们给线程的函数，start_routine，start_routine 的参数 arg，以及调度策略都要赋值给 pthread。

接下来 \_\_nptl_nthreads 加一，说明又多了一个线程。

真正创建线程的是调用 create_thread 函数，这个函数定义如下：

```cpp
static int
create_thread (struct pthread *pd, const struct pthread_attr *attr,
bool *stopped_start, STACK_VARIABLES_PARMS, bool *thread_ran)
{
  const int clone_flags = (CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SYSVSEM | CLONE_SIGHAND | CLONE_THREAD | CLONE_SETTLS | CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID | 0);
  ARCH_CLONE (&start_thread, STACK_VARIABLES_ARGS, clone_flags, pd, &pd->tid, tp, &pd->tid)；
  /* It's started now, so if we fail below, we'll have to cancel it
and let it clean itself up.  */
  *thread_ran = true;
}
```

这里面有很长的 clone_flags，这些咱们原来一直没注意，不过接下来的过程，我们要特别的关注一下这些标志位。

然后就是 ARCH_CLONE，其实调用的是 \_\_clone。看到这里，你应该就有感觉了，马上就要到系统调用了。

```cpp
# define ARCH_CLONE __clone


/* The userland implementation is:
   int clone (int (*fn)(void *arg), void *child_stack, int flags, void *arg),
   the kernel entry is:
   int clone (long flags, void *child_stack).


   The parameters are passed in register and on the stack from userland:
   rdi: fn
   rsi: child_stack
   rdx: flags
   rcx: arg
   r8d: TID field in parent
   r9d: thread pointer
%esp+8: TID field in child


   The kernel expects:
   rax: system call number
   rdi: flags
   rsi: child_stack
   rdx: TID field in parent
   r10: TID field in child
   r8:  thread pointer  */

        .text
ENTRY (__clone)
        movq    $-EINVAL,%rax
......
        /* Insert the argument onto the new stack.  */
        subq    $16,%rsi
        movq    %rcx,8(%rsi)


        /* Save the function pointer.  It will be popped off in the
           child in the ebx frobbing below.  */
        movq    %rdi,0(%rsi)


        /* Do the system call.  */
        movq    %rdx, %rdi
        movq    %r8, %rdx
        movq    %r9, %r8
        mov     8(%rsp), %R10_LP
        movl    $SYS_ify(clone),%eax
......
        syscall
......
PSEUDO_END (__clone)
```

如果对于汇编不太熟悉也没关系，你可以重点看上面的注释。

我们能看到最后调用了 syscall，这一点 clone 和我们原来熟悉的其他系统调用几乎是一致的。但是，也有少许不一样的地方。

如果在进程的主线程里面调用其他系统调用，当前用户态的栈是指向整个进程的栈，栈顶指针也是指向进程的栈，指令指针也是指向进程的主线程的代码。此时此刻执行到这里，调用 clone 的时候，用户态的栈、栈顶指针、指令指针和其他系统调用一样，都是指向主线程的。

但是对于线程来说，这些都要变。因为我们希望当 clone 这个系统调用成功的时候，除了内核里面有这个线程对应的 task_struct，当系统调用返回到用户态的时候，用户态的栈应该是线程的栈，栈顶指针应该指向线程的栈，指令指针应该指向线程将要执行的那个函数。

所以这些都需要我们自己做，将线程要执行的函数的参数和指令的位置都压到栈里面，当从内核返回，从栈里弹出来的时候，就从这个函数开始，带着这些参数执行下去。

接下来我们就要进入内核了。内核里面对于 clone 系统调用的定义是这样的：

```cpp
SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
     int __user *, parent_tidptr,
     int __user *, child_tidptr,
     unsigned long, tls)
{
  return _do_fork(clone_flags, newsp, 0, parent_tidptr, child_tidptr, tls);
}
```

看到这里，发现了熟悉的面孔 \_do_fork，是不是轻松了一些？上一节我们已经沿着它的逻辑过了一遍了。这里我们重点关注几个区别。

第一个是上面复杂的标志位设定，我们来看都影响了什么。

对于 copy_files，原来是调用 dup_fd 复制一个 files_struct 的，现在因为 CLONE_FILES 标识位变成将原来的 files_struct 引用计数加一。

```cpp
static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
{
  struct files_struct *oldf, *newf;
  oldf = current->files;
  if (clone_flags & CLONE_FILES) {
    atomic_inc(&oldf->count);
    goto out;
  }
  newf = dup_fd(oldf, &error);
  tsk->files = newf;
out:
  return error;
}
```

对于 copy_fs，原来是调用 copy_fs_struct 复制一个 fs_struct，现在因为 CLONE_FS 标识位变成将原来的 fs_struct 的用户数加一。

```cpp
static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
{
  struct fs_struct *fs = current->fs;
  if (clone_flags & CLONE_FS) {
    fs->users++;
    return 0;
  }
  tsk->fs = copy_fs_struct(fs);
  return 0;
}
```

对于 copy_sighand，原来是创建一个新的 sighand_struct，现在因为 CLONE_SIGHAND 标识位变成将原来的 sighand_struct 引用计数加一。

```cpp
static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
{
  struct sighand_struct *sig;


  if (clone_flags & CLONE_SIGHAND) {
    atomic_inc(&current->sighand->count);
    return 0;
  }
  sig = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
  atomic_set(&sig->count, 1);
  memcpy(sig->action, current->sighand->action, sizeof(sig->action));
  return 0;
}
```

对于 copy_signal，原来是创建一个新的 signal_struct，现在因为 CLONE_THREAD 直接返回了。

```cpp
static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
{
  struct signal_struct *sig;
  if (clone_flags & CLONE_THREAD)
    return 0;
  sig = kmem_cache_zalloc(signal_cachep, GFP_KERNEL);
  tsk->signal = sig;
    init_sigpending(&sig->shared_pending);
......
}
```

对于 copy_mm，原来是调用 dup_mm 复制一个 mm_struct，现在因为 CLONE_VM 标识位而直接指向了原来的 mm_struct。

```cpp
static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
{
  struct mm_struct *mm, *oldmm;
  oldmm = current->mm;
  if (clone_flags & CLONE_VM) {
    mmget(oldmm);
    mm = oldmm;
    goto good_mm;
  }
  mm = dup_mm(tsk);
good_mm:
  tsk->mm = mm;
  tsk->active_mm = mm;
  return 0;
}
```

第二个就是对于亲缘关系的影响，毕竟我们要识别多个线程是不是属于一个进程。

```cpp
p->pid = pid_nr(pid);
if (clone_flags & CLONE_THREAD) {
  p->exit_signal = -1;
  p->group_leader = current->group_leader;
  p->tgid = current->tgid;
} else {
  if (clone_flags & CLONE_PARENT)
    p->exit_signal = current->group_leader->exit_signal;
  else
    p->exit_signal = (clone_flags & CSIGNAL);
  p->group_leader = p;
  p->tgid = p->pid;
}
  /* CLONE_PARENT re-uses the old parent */
if (clone_flags & (CLONE_PARENT|CLONE_THREAD)) {
  p->real_parent = current->real_parent;
  p->parent_exec_id = current->parent_exec_id;
} else {
  p->real_parent = current;
  p->parent_exec_id = current->self_exec_id;
}
```

从上面的代码可以看出，使用了 CLONE_THREAD 标识位之后，使得亲缘关系有了一定的变化。

- 如果是新进程，那这个进程的 group_leader 就是它自己，tgid 是它自己的 pid，这就完全重打锣鼓另开张了，自己是线程组的头。如果是新线程，group_leader 是当前进程的，group_leader，tgid 是当前进程的 tgid，也就是当前进程的 pid，这个时候还是拜原来进程为老大。
- 如果是新进程，新进程的 real_parent 是当前的进程，在进程树里面又见一辈人；如果是新线程，线程的 real_parent 是当前的进程的 real_parent，其实是平辈的。

第三，对于信号的处理，如何保证发给进程的信号虽然可以被一个线程处理，但是影响范围应该是整个进程的。例如，kill 一个进程，则所有线程都要被干掉。如果一个信号是发给一个线程的 pthread_kill，则应该只有线程能够收到。

在 copy_process 的主流程里面，无论是创建进程还是线程，都会初始化 struct sigpending pending，也就是每个 task_struct，都会有这样一个成员变量。这就是一个信号列表。如果这个 task_struct 是一个线程，这里面的信号就是发给这个线程的；如果这个 task_struct 是一个进程，这里面的信号是发给主线程的。

```cpp
init_sigpending(&p->pending);
```

另外，上面 copy_signal 的时候，我们可以看到，在创建进程的过程中，会初始化 signal_struct 里面的 struct sigpending shared_pending。但是，在创建线程的过程中，连 signal_struct 都共享了。也就是说，整个进程里的所有线程共享一个 shared_pending，这也是一个信号列表，是发给整个进程的，哪个线程处理都一样。

```cpp
init_sigpending(&sig->shared_pending);
```

至此，clone 在内核的调用完毕，要返回系统调用，回到用户态。

### 用户态执行线程

根据 \_\_clone 的第一个参数，回到用户态也不是直接运行我们指定的那个函数，而是一个通用的 start_thread，这是所有线程在用户态的统一入口。

```cpp
#define START_THREAD_DEFN \
  static int __attribute__ ((noreturn)) start_thread (void *arg)


START_THREAD_DEFN
{
    struct pthread *pd = START_THREAD_SELF;
    /* Run the code the user provided.  */
    THREAD_SETMEM (pd, result, pd->start_routine (pd->arg));
    /* Call destructors for the thread_local TLS variables.  */
    /* Run the destructor for the thread-local data.  */
    __nptl_deallocate_tsd ();
    if (__glibc_unlikely (atomic_decrement_and_test (&__nptl_nthreads)))
        /* This was the last thread.  */
        exit (0);
    __free_tcb (pd);
    __exit_thread ();
}
```

在 start_thread 入口函数中，才真正的调用用户提供的函数，在用户的函数执行完毕之后，会释放这个线程相关的数据。例如，线程本地数据 thread_local variables，线程数目也减一。如果这是最后一个线程了，就直接退出进程，另外 \_\_free_tcb 用于释放 pthread。

```cpp
void
internal_function
__free_tcb (struct pthread *pd)
{
  ......
  __deallocate_stack (pd);
}


void
internal_function
__deallocate_stack (struct pthread *pd)
{
  /* Remove the thread from the list of threads with user defined
     stacks.  */
  stack_list_del (&pd->list);
  /* Not much to do.  Just free the mmap()ed memory.  Note that we do
     not reset the 'used' flag in the 'tid' field.  This is done by
     the kernel.  If no thread has been created yet this field is
     still zero.  */
  if (__glibc_likely (! pd->user_stack))
    (void) queue_stack (pd);
}
```

**free_tcb 会调用 **deallocate_stack 来释放整个线程栈，这个线程栈要从当前使用线程栈的列表 stack_used 中拿下来，放到缓存的线程栈列表 stack_cache 中。

好了，整个线程的生命周期到这里就结束了。

### 总结时刻

线程的调用过程解析完毕了，我画了一个图总结一下。这个图对比了创建进程和创建线程在用户态和内核态的不同。

创建进程的话，调用的系统调用是 fork，在 copy_process 函数里面，会将五大结构 files_struct、fs_struct、sighand_struct、signal_struct、mm_struct 都复制一遍，从此父进程和子进程各用各的数据结构。而创建线程的话，调用的是系统调用 clone，在 copy_process 函数里面， 五大结构仅仅是引用计数加一，也即线程共享进程的数据结构。

![](https://static001.geekbang.org/resource/image/14/4b/14635b1613d04df9f217c3508ae8524b.jpeg)

### 课堂练习

你知道如果查看一个进程的线程以及线程栈的使用情况吗？请找一下相关的命令和 API，尝试一下。

欢迎留言和我分享你的疑惑和见解，也欢迎你收藏本节内容，反复研读。你也可以把今天的内容分享给你的朋友，和他一起学习、进步。
