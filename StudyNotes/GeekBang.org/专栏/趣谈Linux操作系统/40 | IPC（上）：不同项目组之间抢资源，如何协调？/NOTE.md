我们前面讲了，如果项目组之间需要紧密合作，那就需要共享内存，这样就像把两个项目组放在一个会议室一起沟通，会非常高效。这一节，我们就来详细讲讲这个进程之间共享内存的机制。

有了这个机制，两个进程可以像访问自己内存中的变量一样，访问共享内存的变量。但是同时问题也来了，当两个进程共享内存了，就会存在同时读写的问题，就需要对于共享的内存进行保护，就需要信号量这样的同步协调机制。这些也都是我们这节需要探讨的问题。下面我们就一一来看。

共享内存和信号量也是 System V 系列的进程间通信机制，所以很多地方和我们讲过的消息队列有点儿像。为了将共享内存和信号量结合起来使用，我这里定义了一个 share.h 头文件，里面放了一些共享内存和信号量在每个进程都需要的函数。

```cpp
#include <stdio.h>
#include <stdlib.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/types.h>
#include <sys/sem.h>
#include <string.h>

#define MAX_NUM 128

struct shm_data {
  int data[MAX_NUM];
  int datalength;
};

union semun {
  int val;
  struct semid_ds *buf;
  unsigned short int *array;
  struct seminfo *__buf;
};

int get_shmid(){
  int shmid;
  key_t key;

  if((key = ftok("/root/sharememory/sharememorykey", 1024)) < 0){
      perror("ftok error");
          return -1;
  }

  shmid = shmget(key, sizeof(struct shm_data), IPC_CREAT|0777);
  return shmid;
}

int get_semaphoreid(){
  int semid;
  key_t key;

  if((key = ftok("/root/sharememory/semaphorekey", 1024)) < 0){
      perror("ftok error");
          return -1;
  }

  semid = semget(key, 1, IPC_CREAT|0777);
  return semid;
}

int semaphore_init (int semid) {
  union semun argument;
  unsigned short values[1];
  values[0] = 1;
  argument.array = values;
  return semctl (semid, 0, SETALL, argument);
}

int semaphore_p (int semid) {
  struct sembuf operations[1];
  operations[0].sem_num = 0;
  operations[0].sem_op = -1;
  operations[0].sem_flg = SEM_UNDO;
  return semop (semid, operations, 1);
}

int semaphore_v (int semid) {
  struct sembuf operations[1];
  operations[0].sem_num = 0;
  operations[0].sem_op = 1;
  operations[0].sem_flg = SEM_UNDO;
  return semop (semid, operations, 1);
}
```

### 共享内存

我们先来看里面对于共享内存的操作。

首先，创建之前，我们要有一个 key 来唯一标识这个共享内存。这个 key 可以根据文件系统上的一个文件的 inode 随机生成。

然后，我们需要创建一个共享内存，就像创建一个消息队列差不多，都是使用 xxxget 来创建。其中，创建共享内存使用的是下面这个函数：

```cpp
int shmget(key_t key, size_t size, int shmflag);
```

其中，key 就是前面生成的那个 key，shmflag 如果为 IPC_CREAT，就表示新创建，还可以指定读写权限 0777。

对于共享内存，需要指定一个大小 size，这个一般要申请多大呢？一个最佳实践是，我们将多个进程需要共享的数据放在一个 struct 里面，然后这里的 size 就应该是这个 struct 的大小。这样每一个进程得到这块内存后，只要强制将类型转换为这个 struct 类型，就能够访问里面的共享数据了。

在这里，我们定义了一个 struct shm_data 结构。这里面有两个成员，一个是一个整型的数组，一个是数组中元素的个数。

生成了共享内存以后，接下来就是将这个共享内存映射到进程的虚拟地址空间中。我们使用下面这个函数来进行操作。

```cpp
void *shmat(int  shm_id, const  void *addr, int shmflg);
```

这里面的 shm_id，就是上面创建的共享内存的 id，addr 就是指定映射在某个地方。如果不指定，则内核会自动选择一个地址，作为返回值返回。得到了返回地址以后，我们需要将指针强制类型转换为 struct shm_data 结构，就可以使用这个指针设置 data 和 datalength 了。

当共享内存使用完毕，我们可以通过 shmdt 解除它到虚拟内存的映射。

```cpp
int shmdt(const  void *shmaddr)；
```

### 信号量

看完了共享内存，接下来我们再来看信号量。信号量以集合的形式存在的。

首先，创建之前，我们同样需要有一个 key，来唯一标识这个信号量集合。这个 key 同样可以根据文件系统上的一个文件的 inode 随机生成。

然后，我们需要创建一个信号量集合，同样也是使用 xxxget 来创建，其中创建信号量集合使用的是下面这个函数。

```cpp
int semget(key_t key, int nsems, int semflg);
```

这里面的 key，就是前面生成的那个 key，shmflag 如果为 IPC_CREAT，就表示新创建，还可以指定读写权限 0777。

这里，nsems 表示这个信号量集合里面有几个信号量，最简单的情况下，我们设置为 1。

信号量往往代表某种资源的数量，如果用信号量做互斥，那往往将信号量设置为 1。这就是上面代码中 semaphore_init 函数的作用，这里面调用 semctl 函数，将这个信号量集合的中的第 0 个信号量，也即唯一的这个信号量设置为 1。

对于信号量，往往要定义两种操作，P 操作和 V 操作。对应上面代码中 semaphore_p 函数和 semaphore_v 函数，semaphore_p 会调用 semop 函数将信号量的值减一，表示申请占用一个资源，当发现当前没有资源的时候，进入等待。semaphore_v 会调用 semop 函数将信号量的值加一，表示释放一个资源，释放之后，就允许等待中的其他进程占用这个资源。

我们可以用这个信号量，来保护共享内存中的 struct shm_data，使得同时只有一个进程可以操作这个结构。

你是否记得咱们讲线程同步机制的时候，构建了一个老板分配活的场景。这里我们同样构建一个场景，分为 producer.c 和 consumer.c，其中 producer 也即生产者，负责往 struct shm_data 塞入数据，而 consumer.c 负责处理 struct shm_data 中的数据。

下面我们来看 producer.c 的代码。

```cpp
#include "share.h"

int main() {
  void *shm = NULL;
  struct shm_data *shared = NULL;
  int shmid = get_shmid();
  int semid = get_semaphoreid();
  int i;

  shm = shmat(shmid, (void*)0, 0);
  if(shm == (void*)-1){
    exit(0);
  }
  shared = (struct shm_data*)shm;
  memset(shared, 0, sizeof(struct shm_data));
  semaphore_init(semid);
  while(1){
    semaphore_p(semid);
    if(shared->datalength > 0){
      semaphore_v(semid);
      sleep(1);
    } else {
      printf("how many integers to caculate : ");
      scanf("%d",&shared->datalength);
      if(shared->datalength > MAX_NUM){
        perror("too many integers.");
        shared->datalength = 0;
        semaphore_v(semid);
        exit(1);
      }
      for(i=0;i<shared->datalength;i++){
        printf("Input the %d integer : ", i);
        scanf("%d",&shared->data[i]);
      }
      semaphore_v(semid);
    }
  }
}
```

在这里面，get_shmid 创建了共享内存，get_semaphoreid 创建了信号量集合，然后 shmat 将共享内存映射到了虚拟地址空间的 shm 指针指向的位置，然后通过强制类型转换，shared 的指针指向放在共享内存里面的 struct shm_data 结构，然后初始化为 0。semaphore_init 将信号量进行了初始化。

接着，producer 进入了一个无限循环。在这个循环里面，我们先通过 semaphore_p 申请访问共享内存的权利，如果发现 datalength 大于零，说明共享内存里面的数据没有被处理过，于是 semaphore_v 释放权利，先睡一会儿，睡醒了再看。如果发现 datalength 等于 0，说明共享内存里面的数据被处理完了，于是开始往里面放数据。让用户输入多少个数，然后每个数是什么，都放在 struct shm_data 结构中，然后 semaphore_v 释放权利，等待其他的进程将这些数拿去处理。

我们再来看 consumer 的代码。

```cpp
#include "share.h"

int main() {
  void *shm = NULL;
  struct shm_data *shared = NULL;
  int shmid = get_shmid();
  int semid = get_semaphoreid();
  int i;

  shm = shmat(shmid, (void*)0, 0);
  if(shm == (void*)-1){
    exit(0);
  }
  shared = (struct shm_data*)shm;
  while(1){
    semaphore_p(semid);
    if(shared->datalength > 0){
      int sum = 0;
      for(i=0;i<shared->datalength-1;i++){
        printf("%d+",shared->data[i]);
        sum += shared->data[i];
      }
      printf("%d",shared->data[shared->datalength-1]);
      sum += shared->data[shared->datalength-1];
      printf("=%d\n",sum);
      memset(shared, 0, sizeof(struct shm_data));
      semaphore_v(semid);
    } else {
      semaphore_v(semid);
      printf("no tasks, waiting.\n");
      sleep(1);
    }
  }
}
```

在这里面，get_shmid 获得 producer 创建的共享内存，get_semaphoreid 获得 producer 创建的信号量集合，然后 shmat 将共享内存映射到了虚拟地址空间的 shm 指针指向的位置，然后通过强制类型转换，shared 的指针指向放在共享内存里面的 struct shm_data 结构。

接着，consumer 进入了一个无限循环，在这个循环里面，我们先通过 semaphore_p 申请访问共享内存的权利，如果发现 datalength 等于 0，就说明没什么活干，需要等待。如果发现 datalength 大于 0，就说明有活干，于是将 datalength 个整型数字从 data 数组中取出来求和。最后将 struct shm_data 清空为 0，表示任务处理完毕，通过 semaphore_v 释放权利。

通过程序创建的共享内存和信号量集合，我们可以通过命令 ipcs 查看。当然，我们也可以通过 ipcrm 进行删除。

```
# ipcs
------ Message Queues --------
key        msqid      owner      perms      used-bytes   messages
------ Shared Memory Segments --------
key        shmid      owner      perms      bytes      nattch     status
0x00016988 32768      root       777        516        0
------ Semaphore Arrays --------
key        semid      owner      perms      nsems
0x00016989 32768      root       777        1
```

下面我们来运行一下 producer 和 consumer，可以得到下面的结果：

```cpp
# ./producer
how many integers to caculate : 2
Input the 0 integer : 3
Input the 1 integer : 4
how many integers to caculate : 4
Input the 0 integer : 3
Input the 1 integer : 4
Input the 2 integer : 5
Input the 3 integer : 6
how many integers to caculate : 7
Input the 0 integer : 9
Input the 1 integer : 8
Input the 2 integer : 7
Input the 3 integer : 6
Input the 4 integer : 5
Input the 5 integer : 4
Input the 6 integer : 3

# ./consumer
3+4=7
3+4+5+6=18
9+8+7+6+5+4+3=42
```

### 总结时刻

这一节的内容差不多了，我们来总结一下。共享内存和信号量的配合机制，如下图所示：

- 无论是共享内存还是信号量，创建与初始化都遵循同样流程，通过 ftok 得到 key，通过 xxxget 创建对象并生成 id；
- 生产者和消费者都通过 shmat 将共享内存映射到各自的内存空间，在不同的进程里面映射的位置不同；
- 为了访问共享内存，需要信号量进行保护，信号量需要通过 semctl 初始化为某个值；
- 接下来生产者和消费者要通过 semop(-1) 来竞争信号量，如果生产者抢到信号量则写入，然后通过 semop(+1) 释放信号量，如果消费者抢到信号量则读出，然后通过 semop(+1) 释放信号量；
- 共享内存使用完毕，可以通过 shmdt 来解除映射。

![](https://static001.geekbang.org/resource/image/46/0b/469552bffe601d594c432d4fad97490b.png)

### 课堂练习

信号量大于 1 的情况下，应该如何使用？你可以试着构建一个场景。

欢迎留言和我分享你的疑惑和见解 ，也欢迎可以收藏本节内容，反复研读。你也可以把今天的内容分享给你的朋友，和他一起学习和进步。
