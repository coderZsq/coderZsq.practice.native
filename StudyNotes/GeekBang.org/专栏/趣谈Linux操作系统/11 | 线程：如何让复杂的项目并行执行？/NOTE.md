上一节我们讲了如何创建进程，这一节我们来看如何创建线程。

### 为什么要有线程？

其实，对于任何一个进程来讲，即便我们没有主动去创建线程，进程也是默认有一个主线程的。线程是负责执行二进制指令的，它会根据项目执行计划书，一行一行执行下去。进程要比线程管的宽多了，除了执行指令之外，内存、文件系统等等都要它来管。

所以，进程相当于一个项目，而线程就是为了完成项目需求，而建立的一个个开发任务。默认情况下，你可以建一个大的任务，就是完成某某功能，然后交给一个人让它从头做到尾，这就是主线程。但是有时候，你发现任务是可以拆解的，如果相关性没有非常大前后关联关系，就可以并行执行。

例如，你接到了一个开发任务，要开发 200 个页面，最后组成一个网站。这时候你就可以拆分成 20 个任务，每个任务 10 个页面，并行开发。都开发完了，再做一次整合，这肯定比依次开发 200 个页面快多了。

![](https://static001.geekbang.org/resource/image/48/9e/485ce8195d241c2a6930803286302e9e.jpg)

那我们能不能成立多个项目组实现并行开发呢？当然可以了，只不过这样做有两个比较麻烦的地方。

第一个麻烦是，立项。涉及的部门比较多，总是劳师动众。你本来想的是，只要能并行执行任务就可以，不需要把会议室都搞成独立的。另一个麻烦是，项目组是独立的，会议室是独立的，很多事情就不受你控制了，例如一旦有了两个项目组，就会有沟通问题。

所以，使用进程实现并行执行的问题也有两个。第一，创建进程占用资源太多；第二，进程之间的通信需要数据在不同的内存空间传来传去，无法共享。

除了希望任务能够并行执行，有的时候，你作为项目管理人员，肯定要管控风险，因此还会预留一部分人作为应急小分队，来处理紧急的事情。

例如，主线程正在一行一行执行二进制命令，突然收到一个通知，要做一点小事情，应该停下主线程来做么？太耽误事情了，应该创建一个单独的线程，单独处理这些事件。

另外，咱们希望自己的公司越来越有竞争力。要想实现远大的目标，我们不能把所有人力都用在接项目上，应该预留一些人力来做技术积累，比如开发一些各个项目都能用到的共享库、框架等等。

在 Linux 中，有时候我们希望将前台的任务和后台的任务分开。因为有些任务是需要马上返回结果的，例如你输入了一个字符，不可能五分钟再显示出来；而有些任务是可以默默执行的，例如将本机的数据同步到服务器上去，这个就没刚才那么着急。因此这样两个任务就应该在不同的线程处理，以保证互不耽误。

### 如何创建线程？

看来多线程还是有很多好处的。接下来我们来看一下，如何使用线程来干一件大事。

假如说，现在我们有 N 个非常大的视频需要下载，一个个下载需要的时间太长了。按照刚才的思路，我们可以拆分成 N 个任务，分给 N 个线程各自去下载。

我们知道，进程的执行是需要项目执行计划书的，那线程是一个项目小组，这个小组也应该有自己的项目执行计划书，也就是一个函数。我们将要执行的子任务放在这个函数里面，比如上面的下载任务。

这个函数参数是 void 类型的指针，用于接收任何类型的参数。我们就可以将要下载的文件的文件名通过这个指针传给它。

为了方便，我将代码整段都贴在这里，这样你把下面的代码放在一个文件里面就能成功编译。

当然，这里我们不是真的下载这个文件，而仅仅打印日志，并生成一个一百以内的随机数，作为下载时间返回。这样，每个子任务干活的同时在喊：“我正在下载，终于下载完了，用了多少时间。”

```cpp
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define NUM_OF_TASKS 5

void *downloadfile(void *filename)
{
   printf("I am downloading the file %s!\n", (char *)filename);
   sleep(10);
   long downloadtime = rand()%100;
   printf("I finish downloading the file within %d minutes!\n", downloadtime);
   pthread_exit((void *)downloadtime);
}

int main(int argc, char *argv[])
{
   char files[NUM_OF_TASKS][20]={"file1.avi","file2.rmvb","file3.mp4","file4.wmv","file5.flv"};
   pthread_t threads[NUM_OF_TASKS];
   int rc;
   int t;
   int downloadtime;

   pthread_attr_t thread_attr;
   pthread_attr_init(&thread_attr);
   pthread_attr_setdetachstate(&thread_attr,PTHREAD_CREATE_JOINABLE);

   for(t=0;t<NUM_OF_TASKS;t++){
     printf("creating thread %d, please help me to download %s\n", t, files[t]);
     rc = pthread_create(&threads[t], &thread_attr, downloadfile, (void *)files[t]);
     if (rc){
       printf("ERROR; return code from pthread_create() is %d\n", rc);
       exit(-1);
     }
   }

   pthread_attr_destroy(&thread_attr);

   for(t=0;t<NUM_OF_TASKS;t++){
     pthread_join(threads[t],(void**)&downloadtime);
     printf("Thread %d downloads the file %s in %d minutes.\n",t,files[t],downloadtime);
   }

   pthread_exit(NULL);
}
```

一个运行中的线程可以调用 pthread_exit 退出线程。这个函数可以传入一个参数转换为 (void \*) 类型。这是线程退出的返回值。

接下来，我们来看主线程。在这里面，我列了五个文件名。接下来声明了一个数组，里面有五个 pthread_t 类型的线程对象。

接下来，声明一个线程属性 pthread_attr_t。我们通过 pthread_attr_init 初始化这个属性，并且设置属性 PTHREAD_CREATE_JOINABLE。这表示将来主线程程等待这个线程的结束，并获取退出时的状态。

接下来是一个循环。对于每一个文件和每一个线程，可以调用 pthread_create 创建线程。一共有四个参数，第一个参数是线程对象，第二个参数是线程的属性，第三个参数是线程运行函数，第四个参数是线程运行函数的参数。主线程就是通过第四个参数，将自己的任务派给子线程。

任务分配完毕，每个线程下载一个文件，接下来主线程要做的事情就是等待这些子任务完成。当一个线程退出的时候，就会发送信号给其他所有同进程的线程。有一个线程使用 pthread_join 获取这个线程退出的返回值。线程的返回值通过 pthread_join 传给主线程，这样子线程就将自己下载文件所耗费的时间，告诉给主线程。

好了，程序写完了，开始编译。多线程程序要依赖于 libpthread.so。

```
gcc download.c -lpthread
```

编译好了，执行一下，就能得到下面的结果。

```
# ./a.out
creating thread 0, please help me to download file1.avi
creating thread 1, please help me to download file2.rmvb
I am downloading the file file1.avi!
creating thread 2, please help me to download file3.mp4
I am downloading the file file2.rmvb!
creating thread 3, please help me to download file4.wmv
I am downloading the file file3.mp4!
creating thread 4, please help me to download file5.flv
I am downloading the file file4.wmv!
I am downloading the file file5.flv!
I finish downloading the file within 83 minutes!
I finish downloading the file within 77 minutes!
I finish downloading the file within 86 minutes!
I finish downloading the file within 15 minutes!
I finish downloading the file within 93 minutes!
Thread 0 downloads the file file1.avi in 83 minutes.
Thread 1 downloads the file file2.rmvb in 86 minutes.
Thread 2 downloads the file file3.mp4 in 77 minutes.
Thread 3 downloads the file file4.wmv in 93 minutes.
Thread 4 downloads the file file5.flv in 15 minutes.
```

这里我们画一张图总结一下，一个普通线程的创建和运行过程。

![](https://static001.geekbang.org/resource/image/e3/bd/e38c28b0972581d009ef16f1ebdee2bd.jpg)

### 线程的数据

线程可以将项目并行起来，加快进度，但是也带来的负面影响，过程并行起来了，那数据呢？

我们把线程访问的数据细分成三类。下面我们一一来看。

![](https://static001.geekbang.org/resource/image/e7/3f/e7b06dcf431f388170ab0a79677ee43f.jpg)

第一类是线程栈上的本地数据，比如函数执行过程中的局部变量。前面我们说过，函数的调用会使用栈的模型，这在线程里面是一样的。只不过每个线程都有自己的栈空间。

栈的大小可以通过命令 ulimit -a 查看，默认情况下线程栈大小为 8192（8MB）。我们可以使用命令 ulimit -s 修改。

对于线程栈，可以通过下面这个函数 pthread_attr_t，修改线程栈的大小。

```cpp
int pthread_attr_setstacksize(pthread_attr_t *attr, size_t stacksize);
```

主线程在内存中有一个栈空间，其他线程栈也拥有独立的栈空间。为了避免线程之间的栈空间踩踏，线程栈之间还会有小块区域，用来隔离保护各自的栈空间。一旦另一个线程踏入到这个隔离区，就会引发段错误。

第二类数据就是在整个进程里共享的全局数据。例如全局变量，虽然在不同进程中是隔离的，但是在一个进程中是共享的。如果同一个全局变量，两个线程一起修改，那肯定会有问题，有可能把数据改的面目全非。这就需要有一种机制来保护他们，比如你先用我再用。这一节的最后，我们专门来谈这个问题。

那线程能不能像进程一样，也有自己的私有数据呢？如果想声明一个线程级别，而非进程级别的全局变量，有没有什么办法呢？虽然咱们都是一个大组，分成小组，也应该有点隐私。

这就是第三类数据，线程私有数据（Thread Specific Data），可以通过以下函数创建：

```cpp
int pthread_key_create(pthread_key_t *key, void (*destructor)(void*))
```

可以看到，创建一个 key，伴随着一个析构函数。

key 一旦被创建，所有线程都可以访问它，但各线程可根据自己的需要往 key 中填入不同的值，这就相当于提供了一个同名而不同值的全局变量。

我们可以通过下面的函数设置 key 对应的 value。

```cpp
int pthread_setspecific(pthread_key_t key, const void *value)
```

我们还可以通过下面的函数获取 key 对应的 value。

```cpp
void *pthread_getspecific(pthread_key_t key)
```

而等到线程退出的时候，就会调用析构函数释放 value。

### 数据的保护

接下来，我们来看共享的数据保护问题。

我们先来看一种方式，Mutex，全称 Mutual Exclusion，中文叫互斥。顾名思义，有你没我，有我没你。它的模式就是在共享数据访问的时候，去申请加把锁，谁先拿到锁，谁就拿到了访问权限，其他人就只好在门外等着，等这个人访问结束，把锁打开，其他人再去争夺，还是遵循谁先拿到谁访问。

我这里构建了一个“转账”的场景。相关的代码我放到这里，你可以看看。

```cpp
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define NUM_OF_TASKS 5

int money_of_tom = 100;
int money_of_jerry = 100;
//第一次运行去掉下面这行
pthread_mutex_t g_money_lock;

void *transfer(void *notused)
{
  pthread_t tid = pthread_self();
  printf("Thread %u is transfering money!\n", (unsigned int)tid);
  //第一次运行去掉下面这行
  pthread_mutex_lock(&g_money_lock);
  sleep(rand()%10);
  money_of_tom+=10;
  sleep(rand()%10);
  money_of_jerry-=10;
  //第一次运行去掉下面这行
  pthread_mutex_unlock(&g_money_lock);
  printf("Thread %u finish transfering money!\n", (unsigned int)tid);
  pthread_exit((void *)0);
}

int main(int argc, char *argv[])
{
  pthread_t threads[NUM_OF_TASKS];
  int rc;
  int t;
  //第一次运行去掉下面这行
  pthread_mutex_init(&g_money_lock, NULL);

  for(t=0;t<NUM_OF_TASKS;t++){
    rc = pthread_create(&threads[t], NULL, transfer, NULL);
    if (rc){
      printf("ERROR; return code from pthread_create() is %d\n", rc);
      exit(-1);
    }
  }

  for(t=0;t<100;t++){
    //第一次运行去掉下面这行
    pthread_mutex_lock(&g_money_lock);
    printf("money_of_tom + money_of_jerry = %d\n", money_of_tom + money_of_jerry);
    //第一次运行去掉下面这行
    pthread_mutex_unlock(&g_money_lock);
  }
  //第一次运行去掉下面这行
  pthread_mutex_destroy(&g_money_lock);
  pthread_exit(NULL);
}
```

这里说，有两个员工 Tom 和 Jerry，公司食堂的饭卡里面各自有 100 元，并行启动 5 个线程，都是 Jerry 转 10 元给 Tom，主线程不断打印 Tom 和 Jerry 的资金之和。按说，这样的话，总和应该永远是 200 元。

在上面的程序中，我们先去掉 mutex 相关的行，就像注释里面写的那样。在没有锁的保护下，在 Tom 的账户里面加上 10 元，在 Jerry 的账户里面减去 10 元，这不是一个原子操作。

我们来编译一下。

```
gcc mutex.c -lpthread
```

然后运行一下，就看到了下面这样的结果。

```
[root@deployer createthread]# ./a.out
Thread 508479232 is transfering money!
Thread 491693824 is transfering money!
Thread 500086528 is transfering money!
Thread 483301120 is transfering money!
Thread 516871936 is transfering money!
money_of_tom + money_of_jerry = 200
money_of_tom + money_of_jerry = 200
money_of_tom + money_of_jerry = 220
money_of_tom + money_of_jerry = 220
money_of_tom + money_of_jerry = 230
money_of_tom + money_of_jerry = 240
Thread 483301120 finish transfering money!
money_of_tom + money_of_jerry = 240
Thread 508479232 finish transfering money!
Thread 500086528 finish transfering money!
money_of_tom + money_of_jerry = 220
Thread 516871936 finish transfering money!
money_of_tom + money_of_jerry = 210
money_of_tom + money_of_jerry = 210
Thread 491693824 finish transfering money!
money_of_tom + money_of_jerry = 200
money_of_tom + money_of_jerry = 200
```

可以看到，中间有很多状态不正确，比如两个人的账户之和出现了超过 200 的情况，也就是 Tom 转入了，Jerry 还没转出。

接下来我们在上面的代码里面，加上 mutex，然后编译、运行，就得到了下面的结果。

```
[root@deployer createthread]# ./a.out
Thread 568162048 is transfering money!
Thread 576554752 is transfering money!
Thread 551376640 is transfering money!
Thread 542983936 is transfering money!
Thread 559769344 is transfering money!
Thread 568162048 finish transfering money!
Thread 576554752 finish transfering money!
money_of_tom + money_of_jerry = 200
money_of_tom + money_of_jerry = 200
money_of_tom + money_of_jerry = 200
Thread 542983936 finish transfering money!
Thread 559769344 finish transfering money!
money_of_tom + money_of_jerry = 200
money_of_tom + money_of_jerry = 200
Thread 551376640 finish transfering money!
money_of_tom + money_of_jerry = 200
money_of_tom + money_of_jerry = 200
money_of_tom + money_of_jerry = 200
money_of_tom + money_of_jerry = 200
```

这个结果就正常了。两个账号之和永远是 200。这下你看到锁的作用了吧？

使用 Mutex，首先要使用 pthread_mutex_init 函数初始化这个 mutex，初始化后，就可以用它来保护共享变量了。

pthread_mutex_lock() 就是去抢那把锁的函数，如果抢到了，就可以执行下一行程序，对共享变量进行访问；如果没抢到，就被阻塞在那里等待。

如果不想被阻塞，可以使用 pthread_mutex_trylock 去抢那把锁，如果抢到了，就可以执行下一行程序，对共享变量进行访问；如果没抢到，不会被阻塞，而是返回一个错误码。

当共享数据访问结束了，别忘了使用 pthread_mutex_unlock 释放锁，让给其他人使用，最终调用 pthread_mutex_destroy 销毁掉这把锁。

这里我画个图，总结一下 Mutex 的使用流程。

![](https://static001.geekbang.org/resource/image/0c/be/0ccf37aafa2b287363399e130b2726be.jpg)

在使用 Mutex 的时候，有个问题是如果使用 pthread_mutex_lock()，那就需要一直在那里等着。如果是 pthread_mutex_trylock()，就可以不用等着，去干点儿别的，但是我怎么知道什么时候回来再试一下，是不是轮到我了呢？能不能在轮到我的时候，通知我一下呢？

这其实就是条件变量，也就是说如果没事儿，就让大家歇着，有事儿了就去通知，别让人家没事儿就来问问，浪费大家的时间。

但是当它接到了通知，来操作共享资源的时候，还是需要抢互斥锁，因为可能很多人都受到了通知，都来访问了，所以条件变量和互斥锁是配合使用的。

我这里还是用一个场景给你解释。

你这个老板，招聘了三个员工，但是你不是有了活才去招聘员工，而是先把员工招来，没有活的时候员工需要在那里等着，一旦有了活，你要去通知他们，他们要去抢活干（为啥要抢活？因为有绩效呀！），干完了再等待，你再有活，再通知他们。

具体的样例代码我也放在这里。你可以直接编译运行。

```cpp
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define NUM_OF_TASKS 3
#define MAX_TASK_QUEUE 11

char tasklist[MAX_TASK_QUEUE]="ABCDEFGHIJ";
int head = 0;
int tail = 0;

int quit = 0;

pthread_mutex_t g_task_lock;
pthread_cond_t g_task_cv;

void *coder(void *notused)
{
  pthread_t tid = pthread_self();

  while(!quit){

    pthread_mutex_lock(&g_task_lock);
    while(tail == head){
      if(quit){
        pthread_mutex_unlock(&g_task_lock);
        pthread_exit((void *)0);
      }
      printf("No task now! Thread %u is waiting!\n", (unsigned int)tid);
      pthread_cond_wait(&g_task_cv, &g_task_lock);
      printf("Have task now! Thread %u is grabing the task !\n", (unsigned int)tid);
    }
    char task = tasklist[head++];
    pthread_mutex_unlock(&g_task_lock);
    printf("Thread %u has a task %c now!\n", (unsigned int)tid, task);
    sleep(5);
    printf("Thread %u finish the task %c!\n", (unsigned int)tid, task);
  }

  pthread_exit((void *)0);
}

int main(int argc, char *argv[])
{
  pthread_t threads[NUM_OF_TASKS];
  int rc;
  int t;

  pthread_mutex_init(&g_task_lock, NULL);
  pthread_cond_init(&g_task_cv, NULL);

  for(t=0;t<NUM_OF_TASKS;t++){
    rc = pthread_create(&threads[t], NULL, coder, NULL);
    if (rc){
      printf("ERROR; return code from pthread_create() is %d\n", rc);
      exit(-1);
    }
  }

  sleep(5);

  for(t=1;t<=4;t++){
    pthread_mutex_lock(&g_task_lock);
    tail+=t;
    printf("I am Boss, I assigned %d tasks, I notify all coders!\n", t);
    pthread_cond_broadcast(&g_task_cv);
    pthread_mutex_unlock(&g_task_lock);
    sleep(20);
  }

  pthread_mutex_lock(&g_task_lock);
  quit = 1;
  pthread_cond_broadcast(&g_task_cv);
  pthread_mutex_unlock(&g_task_lock);

  pthread_mutex_destroy(&g_task_lock);
  pthread_cond_destroy(&g_task_cv);
  pthread_exit(NULL);
}
```

首先，我们创建了 10 个任务，每个任务一个字符，放在一个数组里面，另外有两个变量 head 和 tail，表示当前分配的工作从哪里开始，到哪里结束。如果 head 等于 tail，则当前的工作分配完毕；如果 tail 加 N，就是新分配了 N 个工作。

接下来声明的 pthread_mutex_t g_task_lock 和 pthread_cond_t g_task_cv，是用于通知和抢任务的，工作模式如下图所示：

![](https://static001.geekbang.org/resource/image/1d/f7/1d4e17fdb1860f7ca7f23bbe682d93f7.jpeg)

图中左边的就是员工的工作模式，对于每一个员工 coder，先要获取锁 pthread_mutex_lock，这样才能保证一个任务只分配给一个员工。

然后，我们要判断有没有任务，也就是说，head 和 tail 是否相等。如果不相等的话，就是有任务，则取出 head 位置代表的任务 task，然后将 head 加一，这样整个任务就给了这个员工，下个员工来抢活的时候，也需要获取锁，获取之后抢到的就是下一个任务了。当这个员工抢到任务后，pthread_mutex_unlock 解锁，让其他员工可以进来抢任务。抢到任务后就开始干活了，这里没有真正开始干活，而是 sleep，也就是摸鱼了 5 秒。

如果发现 head 和 tail 相当，也就是没有任务，则需要调用 pthread_cond_wait 进行等待，这个函数会把锁也作为变量传进去。这是因为等待的过程中需要解锁，要不然，你不干活，等待睡大觉，还把门给锁了，别人也干不了活，而且老板也没办法获取锁来分配任务。

一开始三个员工都是在等待的状态，因为初始化的时候，head 和 tail 相等都为零。

现在我们把目光聚焦到老板这里，也就是主线程上。它初始化了条件变量和锁，然后创建三个线程，也就是我们说的招聘了三个员工。

接下来要开始分配任务了，总共 10 个任务。老板分四批分配，第一批一个任务三个人抢，第二批两个任务，第三批三个任务，正好每人抢到一个，第四批四个任务，可能有一个员工抢到两个任务。这样三个员工，四批工作，经典的场景差不多都覆盖到了。

老板分配工作的时候，也是要先获取锁 pthread_mutex_lock，然后通过 tail 加一来分配任务，这个时候 head 和 tail 已经不一样了，但是这个时候三个员工还在 pthread_cond_wait 那里睡着呢，接下来老板要调用 pthread_cond_broadcast 通知所有的员工，“来活了，醒醒，起来干活”。

这个时候三个员工醒来后，先抢锁，生怕老板只分配了一个任务，让别人抢去。当然抢锁这个动作是 pthread_cond_wait 在收到通知的时候，自动做的，不需要我们另外写代码。

抢到锁的员工就通过 while 再次判断 head 和 tail 是否相同。这次因为有了任务，不相同了，所以就抢到了任务。而没有抢到任务的员工，由于抢锁失败，只好等待抢到任务的员工释放锁，抢到任务的员工在 tasklist 里面拿到任务后，将 head 加一，然后就释放锁。这个时候，另外两个员工才能从 pthread_cond_wait 中返回，然后也会再次通过 while 判断 head 和 tail 是否相同。不过已经晚了，任务都让人家抢走了，head 和 tail 又一样了，所以只好再次进入 pthread_cond_wait，接着等任务。

这里，我们只解析了第一批一个任务的工作的过程。如果运行上面的程序，可以得到下面的结果。我将整个过程在里面写了注释，你看起来就比较容易理解了。

```
[root@deployer createthread]# ./a.out
//招聘三个员工，一开始没有任务，大家睡大觉
No task now! Thread 3491833600 is waiting!
No task now! Thread 3483440896 is waiting!
No task now! Thread 3475048192 is waiting!
//老板开始分配任务了，第一批任务就一个，告诉三个员工醒来抢任务
I am Boss, I assigned 1 tasks, I notify all coders!
//员工一先发现有任务了，开始抢任务
Have task now! Thread 3491833600 is grabing the task !
//员工一抢到了任务A，开始干活
Thread 3491833600 has a task A now!
//员工二也发现有任务了，开始抢任务，不好意思，就一个任务，让人家抢走了，接着等吧
Have task now! Thread 3483440896 is grabing the task !
No task now! Thread 3483440896 is waiting!
//员工三也发现有任务了，开始抢任务，你比员工二还慢，接着等吧
Have task now! Thread 3475048192 is grabing the task !
No task now! Thread 3475048192 is waiting!
//员工一把任务做完了，又没有任务了，接着等待
Thread 3491833600 finish the task A !
No task now! Thread 3491833600 is waiting!
//老板又有新任务了，这次是两个任务，叫醒他们
I am Boss, I assigned 2 tasks, I notify all coders!
//这次员工二比较积极，先开始抢，并且抢到了任务B
Have task now! Thread 3483440896 is grabing the task !
Thread 3483440896 has a task B now!
//这次员工三也聪明了，赶紧抢，要不然没有年终奖了，终于抢到了任务C
Have task now! Thread 3475048192 is grabing the task !
Thread 3475048192 has a task C now!
//员工一上次抢到了，这次抢的慢了，没有抢到，是不是飘了
Have task now! Thread 3491833600 is grabing the task !
No task now! Thread 3491833600 is waiting!
//员工二做完了任务B，没有任务了，接着等待
Thread 3483440896 finish the task B !
No task now! Thread 3483440896 is waiting!
//员工三做完了任务C，没有任务了，接着等待
Thread 3475048192 finish the task C !
No task now! Thread 3475048192 is waiting!
//又来任务了，这次是三个任务，人人有份
I am Boss, I assigned 3 tasks, I notify all coders!
//员工一抢到了任务D，员工二抢到了任务E，员工三抢到了任务F
Have task now! Thread 3491833600 is grabing the task !
Thread 3491833600 has a task D now!
Have task now! Thread 3483440896 is grabing the task !
Thread 3483440896 has a task E now!
Have task now! Thread 3475048192 is grabing the task !
Thread 3475048192 has a task F now!
//三个员工都完成了，然后都又开始等待
Thread 3491833600 finish the task D !
Thread 3483440896 finish the task E !
Thread 3475048192 finish the task F !
No task now! Thread 3491833600 is waiting!
No task now! Thread 3483440896 is waiting!
No task now! Thread 3475048192 is waiting!
//公司活越来越多了，来了四个任务，赶紧干呀
I am Boss, I assigned 4 tasks, I notify all coders!
//员工一抢到了任务G，员工二抢到了任务H，员工三抢到了任务I
Have task now! Thread 3491833600 is grabing the task !
Thread 3491833600 has a task G now!
Have task now! Thread 3483440896 is grabing the task !
Thread 3483440896 has a task H now!
Have task now! Thread 3475048192 is grabing the task !
Thread 3475048192 has a task I now!
//员工一和员工三先做完了，发现还有一个任务开始抢
Thread 3491833600 finish the task G !
Thread 3475048192 finish the task I !
//员工三没抢到，接着等
No task now! Thread 3475048192 is waiting!
//员工一抢到了任务J，多做了一个任务
Thread 3491833600 has a task J now!
//员工二这才把任务H做完，黄花菜都凉了，接着等待吧
Thread 3483440896 finish the task H !
No task now! Thread 3483440896 is waiting!
//员工一做完了任务J，接着等待
Thread 3491833600 finish the task J !
No task now! Thread 3491833600 is waiting!
```

### 总结时刻

这一节，我们讲了如何创建线程，线程都有哪些数据，如何对线程数据进行保护。

写多线程的程序是有套路的，我这里用一张图进行总结。你需要记住的是，创建线程的套路、mutex 使用的套路、条件变量使用的套路。

![](https://static001.geekbang.org/resource/image/02/58/02a774d7c0f83bb69fec4662622d6d58.png)

### 课堂练习

这一节讲了多线程编程的套路，但是我没有对于每一个函数进行详细的讲解，相关的还有很多其他的函数可以调用，这需要你自己去学习。这里我给你推荐一本书 $Programming with POSIX

Threads$，你可以系统地学习一下。另外，上面的代码，建议你一定要上手编译运行一下。

欢迎留言和我分享你的疑惑和见解，也欢迎你收藏本节内容，反复研读。你也可以把今天的内容分享给你的朋友，和他一起学习、进步。
