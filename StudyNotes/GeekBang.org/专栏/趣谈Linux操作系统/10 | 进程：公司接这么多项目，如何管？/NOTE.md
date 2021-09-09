有了系统调用，咱们公司就能开始批量接项目啦！对应到 Linux 操作系统，就是可以创建进程了。

在命令行那一节，我们讲了使用命令创建 Linux 进程的几种方式。现在学习了系统调用，你是不是想尝试一下，如何通过写代码使用系统调用创建一个进程呢？我们一起来看看。

### 写代码：用系统调用创建进程

在 Linux 上写程序和编译程序，也需要一系列的开发套件，就像 Visual Studio 一样。运行下面的命令，就可以在 centOS 7 操作系统上安装开发套件。在以后的章节里面，我们的实验都是基于 centOS 7 操作系统进行的。

```
yum -y groupinstall "Development Tools"
```

接下来，我们要开始写程序了。在 Windows 上写的程序，都会被保存成.h 或者.c 文件，容易让人感觉这是某种有特殊格式的文件，但其实这些文件只是普普通通的文本文件。因而在 Linux 上，我们用 Vim 来创建并编辑一个文件就行了。

我们先来创建一个文件，里面用一个函数封装通用的创建进程的逻辑，名字叫 process.c，代码如下：

```cpp
    #include <stdio.h>
    #include <stdlib.h>
    #include <sys/types.h>
    #include <unistd.h>


    extern int create_process (char* program, char** arg_list);


    int create_process (char* program, char** arg_list)
    {
        pid_t child_pid;
        child_pid = fork ();
        if (child_pid != 0)
            return child_pid;
        else {
            execvp (program, arg_list);
            abort ();
        }
   }
```

这里面用到了咱们学过的 fork 系统调用，通过这里面的 if-else，我们可以看到，根据 fork 的返回值不同，父进程和子进程就此分道扬镳了。在子进程里面，我们需要通过 execvp 运行一个新的程序。

接下来我们创建第二个文件，调用上面这个函数。

```cpp
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

extern int create_process (char* program, char** arg_list);

int main ()
{
    char* arg_list[] = {
        "ls",
        "-l",
        "/etc/yum.repos.d/",
        NULL
    };
    create_process ("ls", arg_list);
    return 0;
}
```

在这里，我们创建的子程序运行了一个最最简单的命令 ls。学过命令行的那一节之后，这里你应该很熟悉了。

### 进行编译：程序的二进制格式

现在咱们是正规的公司了，接项目要有章法，项目执行计划书也要有统一的格式，这样才能保证无论项目交到哪个项目组手里，都能以固定的流程执行。按照里面的指令来，项目也能达到预期的效果。

在 Linux 下面，二进制的程序也要有严格的格式，这个格式我们称为 ELF（Executeable and Linkable Format，可执行与可链接格式）。这个格式可以根据编译的结果不同，分为不同的格式。

接下来我们看一下，如何从文本文件编译成二进制格式。

![](https://static001.geekbang.org/resource/image/85/de/85320245cd80ce61e69c8391958240de.jpeg)

在上面两段代码中，上面 include 的部分是头文件，而我们写的这个.c 结尾的是源文件。

接下来我们编译这两个程序。

```
gcc -c -fPIC process.c
gcc -c -fPIC createprocess.c
```

在编译的时候，先做预处理工作，例如将头文件嵌入到正文中，将定义的宏展开，然后就是真正的编译过程，最终编译成为.o 文件，这就是 ELF 的第一种类型，可重定位文件（Relocatable File）。

这个文件的格式是这样的：

![](https://static001.geekbang.org/resource/image/e9/d6/e9c2b4c67f8784a8eec7392628ce6cd6.jpg)

ELF 文件的头是用于描述整个文件的。这个文件格式在内核中有定义，分别为 struct elf32_hdr 和 struct elf64_hdr。

接下来我们来看一个一个的 section，我们也叫节。这里面的名字有点晦涩，不过你可以猜一下它们是干什么的。

这个编译好的二进制文件里面，应该是代码，还有一些全局变量、静态变量等等。没错，我们依次来看。

- .text：放编译好的二进制可执行代码
- .data：已经初始化好的全局变量
- .rodata：只读数据，例如字符串常量、const 的变量
- .bss：未初始化全局变量，运行时会置 0
- .symtab：符号表，记录的则是函数和变量
- .strtab：字符串表、字符串常量和变量名

为啥这里只有全局变量呢？其实前面我们讲函数栈的时候说过，局部变量是放在栈里面的，是程序运行过程中随时分配空间，随时释放的，现在我们讨论的是二进制文件，还没启动呢，所以只需要讨论在哪里保存全局变量。

这些节的元数据信息也需要有一个地方保存，就是最后的节头部表（Section Header Table）。在这个表里面，每一个 section 都有一项，在代码里面也有定义 struct elf32_shdr 和 struct elf64_shdr。在 ELF 的头里面，有描述这个文件的节头部表的位置，有多少个表项等等信息。

我们刚才说了可重定位，为啥叫可重定位呢？我们可以想象一下，这个编译好的代码和变量，将来加载到内存里面的时候，都是要加载到一定位置的。比如说，调用一个函数，其实就是跳到这个函数所在的代码位置执行；再比如修改一个全局变量，也是要到变量的位置那里去修改。但是现在这个时候，还是.o 文件，不是一个可以直接运行的程序，这里面只是部分代码片段。

例如这里的 create_process 函数，将来被谁调用，在哪里调用都不清楚，就更别提确定位置了。所以，.o 里面的位置是不确定的，但是必须是可重新定位的，因为它将来是要做函数库的嘛，就是一块砖，哪里需要哪里搬，搬到哪里就重新定位这些代码、变量的位置。

有的 section，例如.rel.text, .rel.data 就与重定位有关。例如这里的 createprocess.o，里面调用了 create_process 函数，但是这个函数在另外一个.o 里面，因而 createprocess.o 里面根本不可能知道被调用函数的位置，所以只好在 rel.text 里面标注，这个函数是需要重定位的。

要想让 create_process 这个函数作为库文件被重用，不能以.o 的形式存在，而是要形成库文件，最简单的类型是静态链接库.a 文件（Archives），仅仅将一系列对象文件（.o）归档为一个文件，使用命令 ar 创建。

```
ar cr libstaticprocess.a process.o
```

虽然这里 libstaticprocess.a 里面只有一个.o，但是实际情况可以有多个.o。当有程序要使用这个静态连接库的时候，会将.o 文件提取出来，链接到程序中。

```
gcc -o staticcreateprocess createprocess.o -L. -lstaticprocess
```

在这个命令里，-L 表示在当前目录下找.a 文件，-lstaticprocess 会自动补全文件名，比如加前缀 lib，后缀.a，变成 libstaticprocess.a，找到这个.a 文件后，将里面的 process.o 取出来，和 createprocess.o 做一个链接，形成二进制执行文件 staticcreateprocess。

这个链接的过程，重定位就起作用了，原来 createprocess.o 里面调用了 create_process 函数，但是不能确定位置，现在将 process.o 合并了进来，就知道位置了。

形成的二进制文件叫可执行文件，是 ELF 的第二种格式，格式如下：

![](https://static001.geekbang.org/resource/image/1d/60/1d8de36a58a98a53352b40efa81e9660.jpg)

这个格式和.o 文件大致相似，还是分成一个个的 section，并且被节头表描述。只不过这些 section 是多个.o 文件合并过的。但是这个时候，这个文件已经是马上就可以加载到内存里面执行的文件了，因而这些 section 被分成了需要加载到内存里面的代码段、数据段和不需要加载到内存里面的部分，将小的 section 合成了大的段 segment，并且在最前面加一个段头表（Segment Header Table）。在代码里面的定义为 struct elf32_phdr 和 struct elf64_phdr，这里面除了有对于段的描述之外，最重要的是 p_vaddr，这个是这个段加载到内存的虚拟地址。

在 ELF 头里面，有一项 e_entry，也是个虚拟地址，是这个程序运行的入口。

当程序运行起来之后，就是下面这个样子：

```
# ./staticcreateprocess
# total 40
-rw-r--r--. 1 root root 1572 Oct 24 18:38 CentOS-Base.repo
......
```

静态链接库一旦链接进去，代码和变量的 section 都合并了，因而程序运行的时候，就不依赖于这个库是否存在。但是这样有一个缺点，就是相同的代码段，如果被多个程序使用的话，在内存里面就有多份，而且一旦静态链接库更新了，如果二进制执行文件不重新编译，也不随着更新。

因而就出现了另一种，动态链接库（Shared Libraries），不仅仅是一组对象文件的简单归档，而是多个对象文件的重新组合，可被多个程序共享。

```
gcc -shared -fPIC -o libdynamicprocess.so process.o
```

当一个动态链接库被链接到一个程序文件中的时候，最后的程序文件并不包括动态链接库中的代码，而仅仅包括对动态链接库的引用，并且不保存动态链接库的全路径，仅仅保存动态链接库的名称。

```
gcc -o dynamiccreateprocess createprocess.o -L. -ldynamicprocess
```

当运行这个程序的时候，首先寻找动态链接库，然后加载它。默认情况下，系统在 /lib 和 /usr/lib 文件夹下寻找动态链接库。如果找不到就会报错，我们可以设定 LD_LIBRARY_PATH 环境变量，程序运行时会在此环境变量指定的文件夹下寻找动态链接库。

```
# export LD_LIBRARY_PATH=.
# ./dynamiccreateprocess
# total 40
-rw-r--r--. 1 root root 1572 Oct 24 18:38 CentOS-Base.repo
......
```

动态链接库，就是 ELF 的第三种类型，共享对象文件（Shared Object）。

基于动态链接库创建出来的二进制文件格式还是 ELF，但是稍有不同。

首先，多了一个.interp 的 Segment，这里面是 ld-linux.so，这是动态链接器，也就是说，运行时的链接动作都是它做的。

另外，ELF 文件中还多了两个 section，一个是.plt，过程链接表（Procedure Linkage Table，PLT），一个是.got.plt，全局偏移量表（Global Offset Table，GOT）。

它们是怎么工作的，使得程序运行的时候，可以将 so 文件动态链接到进程空间的呢？

dynamiccreateprocess 这个程序要调用 libdynamicprocess.so 里的 create_process 函数。由于是运行时才去找，编译的时候，压根不知道这个函数在哪里，所以就在 PLT 里面建立一项 PLT[x]。这一项也是一些代码，有点像一个本地的代理，在二进制程序里面，不直接调用 create_process 函数，而是调用 PLT[x]里面的代理代码，这个代理代码会在运行的时候找真正的 create_process 函数。

去哪里找代理代码呢？这就用到了 GOT，这里面也会为 create_process 函数创建一项 GOT[y]。这一项是运行时 create_process 函数在内存中真正的地址。

如果这个地址在 dynamiccreateprocess 调用 PLT[x]里面的代理代码，代理代码调用 GOT 表中对应项 GOT[y]，调用的就是加载到内存中的 libdynamicprocess.so 里面的 create_process 函数了。

但是 GOT 怎么知道的呢？对于 create_process 函数，GOT 一开始就会创建一项 GOT[y]，但是这里面没有真正的地址，因为它也不知道，但是它有办法，它又回调 PLT，告诉它，你里面的代理代码来找我要 create_process 函数的真实地址，我不知道，你想想办法吧。

PLT 这个时候会转而调用 PLT[0]，也即第一项，PLT[0]转而调用 GOT[2]，这里面是 ld-linux.so 的入口函数，这个函数会找到加载到内存中的 libdynamicprocess.so 里面的 create_process 函数的地址，然后把这个地址放在 GOT[y]里面。下次，PLT[x]的代理函数就能够直接调用了。

这个过程有点绕，但是是不是也很巧妙？

### 运行程序为进程

知道了 ELF 这个格式，这个时候它还是个程序，那怎么把这个文件加载到内存里面呢？

在内核中，有这样一个数据结构，用来定义加载二进制文件的方法。

```cpp
struct linux_binfmt {
        struct list_head lh;
        struct module *module;
        int (*load_binary)(struct linux_binprm *);
        int (*load_shlib)(struct file *);
        int (*core_dump)(struct coredump_params *cprm);
        unsigned long min_coredump;     /* minimal dump size */
} __randomize_layout;
```

对于 ELF 文件格式，有对应的实现。

```cpp
static struct linux_binfmt elf_format = {
        .module         = THIS_MODULE,
        .load_binary    = load_elf_binary,
        .load_shlib     = load_elf_library,
        .core_dump      = elf_core_dump,
        .min_coredump   = ELF_EXEC_PAGESIZE,
};
```

load_elf_binary 是不是你很熟悉？没错，我们加载内核镜像的时候，用的也是这种格式。

还记得当时是谁调用的 load_elf_binary 函数吗？具体是这样的：do_execve->do_execveat_common->exec_binprm->search_binary_handler。

那 do_execve 又是被谁调用的呢？我们看下面的代码。

```cpp
SYSCALL_DEFINE3(execve,
    const char __user *, filename,
    const char __user *const __user *, argv,
    const char __user *const __user *, envp)
{
  return do_execve(getname(filename), argv, envp);
}
```

学过了系统调用一节，你会发现，原理是 exec 这个系统调用最终调用的 load_elf_binary。

exec 比较特殊，它是一组函数：

- 包含 p 的函数（execvp, execlp）会在 PATH 路径下面寻找程序；
- 不包含 p 的函数需要输入程序的全路径；
- 包含 v 的函数（execv, execvp, execve）以数组的形式接收参数；
- 包含 l 的函数（execl, execlp, execle）以列表的形式接收参数；
- 包含 e 的函数（execve, execle）以数组的形式接收环境变量。

![](https://static001.geekbang.org/resource/image/46/f6/465b740b86ccc6ad3f8e38de25336bf6.jpg)

在上面 process.c 的代码中，我们创建 ls 进程，也是通过 exec。

### 进程树

既然所有的进程都是从父进程 fork 过来的，那总归有一个祖宗进程，这就是咱们系统启动的 init 进程。

![](https://static001.geekbang.org/resource/image/4d/16/4de740c10670a92bbaa58348e66b7b16.jpeg)

在解析 Linux 的启动过程的时候，1 号进程是 /sbin/init。如果在 centOS 7 里面，我们 ls 一下，可以看到，这个进程是被软链接到 systemd 的。

```
/sbin/init -> ../lib/systemd/systemd
```

系统启动之后，init 进程会启动很多的 daemon 进程，为系统运行提供服务，然后就是启动 getty，让用户登录，登录后运行 shell，用户启动的进程都是通过 shell 运行的，从而形成了一棵进程树。

我们可以通过 ps -ef 命令查看当前系统启动的进程，我们会发现有三类进程。

```
[root@deployer ~]# ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0  2018 ?        00:00:29 /usr/lib/systemd/systemd --system --deserialize 21
root         2     0  0  2018 ?        00:00:00 [kthreadd]
root         3     2  0  2018 ?        00:00:00 [ksoftirqd/0]
root         5     2  0  2018 ?        00:00:00 [kworker/0:0H]
root         9     2  0  2018 ?        00:00:40 [rcu_sched]
......
root       337     2  0  2018 ?        00:00:01 [kworker/3:1H]
root       380     1  0  2018 ?        00:00:00 /usr/lib/systemd/systemd-udevd
root       415     1  0  2018 ?        00:00:01 /sbin/auditd
root       498     1  0  2018 ?        00:00:03 /usr/lib/systemd/systemd-logind
......
root       852     1  0  2018 ?        00:06:25 /usr/sbin/rsyslogd -n
root      2580     1  0  2018 ?        00:00:00 /usr/sbin/sshd -D
root     29058     2  0 Jan03 ?        00:00:01 [kworker/1:2]
root     29672     2  0 Jan04 ?        00:00:09 [kworker/2:1]
root     30467     1  0 Jan06 ?        00:00:00 /usr/sbin/crond -n
root     31574     2  0 Jan08 ?        00:00:01 [kworker/u128:2]
......
root     32792  2580  0 Jan10 ?        00:00:00 sshd: root@pts/0
root     32794 32792  0 Jan10 pts/0    00:00:00 -bash
root     32901 32794  0 00:01 pts/0    00:00:00 ps -ef
```

你会发现，PID 1 的进程就是我们的 init 进程 systemd，PID 2 的进程是内核线程 kthreadd，这两个我们在内核启动的时候都见过。其中用户态的不带中括号，内核态的带中括号。

接下来进程号依次增大，但是你会看所有带中括号的内核态的进程，祖先都是 2 号进程。而用户态的进程，祖先都是 1 号进程。tty 那一列，是问号的，说明不是前台启动的，一般都是后台的服务。

pts 的父进程是 sshd，bash 的父进程是 pts，ps -ef 这个命令的父进程是 bash。这样整个链条都比较清晰了。

### 总结时刻

这一节我们讲了一个进程从代码到二进制到运行时的一个过程，我们用一个图总结一下。

我们首先通过图右边的文件编译过程，生成 so 文件和可执行文件，放在硬盘上。下图左边的用户态的进程 A 执行 fork，创建进程 B，在进程 B 的处理逻辑中，执行 exec 系列系统调用。这个系统调用会通过 load_elf_binary 方法，将刚才生成的可执行文件，加载到进程 B 的内存中执行。

![](https://static001.geekbang.org/resource/image/db/a9/dbd8785da6c3ce3fe1abb7bb5934b7a9.jpeg)

### 课堂练习

对于 ELF，有几个工具能帮你看这些文件的格式。readelf 工具用于分析 ELF 的信息，objdump 工具用来显示二进制文件的信息，hexdump 工具用来查看文件的十六进制编码，nm 工具用来显示关于指定文件中符号的信息。你可以尝试用这几个工具，来解析这一节生成的.o, .so 和可执行文件。

欢迎留言和我分享你的疑惑和见解，也欢迎你收藏本节内容，反复研读。你也可以把今天的内容分享给你的朋友，和他一起学习、进步。
