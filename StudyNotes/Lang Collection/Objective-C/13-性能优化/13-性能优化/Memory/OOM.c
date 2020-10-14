//
//  OOM.c
//  13-性能优化
//
//  Created by 朱双泉 on 2020/10/14.
//

#include <stdio.h>

//在这个结构体中，priority 表示的是进程的优先级，limit 就是我们想要的进程内存限制值。
typedef struct memorystatus_priority_entry {
  pid_t pid;
  int32_t priority;
  uint64_t user_data;
  int32_t limit;
  uint32_t state;
} memorystatus_priority_entry_t;

//通过 XNU 的宏获取内存限制，需要有 root 权限，而 App 内的权限是不够的，所以正常情况下，作为 App 开发者你是看不到这个信息的。
//那么，如果你不想越狱去获取这个权限的话，还可以利用 didReceiveMemoryWarning 这个内存压力代理事件来动态地获取内存限制值。
//iOS 系统在强杀掉 App 之前还有 6 秒钟的时间，足够你去获取记录内存信息了。
//那么，如何获取当前内存使用情况呢？iOS 系统提供了一个函数 task_info， 可以帮助我们获取到当前任务的信息。关键代码如下：
struct mach_task_basic_info info;
mach_msg_type_number_t size = sizeof(info);
kern_return_t kl = task_info(mach_task_self(), MACH_TASK_BASIC_INFO, (task_info_t)&info, &size);
//代码中，task_info_t 结构里包含了一个 resident_size 字段，用于表示使用了多少内存。这样，我们就可以获取到发生内存警告时，当前 App 占用了多少内存。代码如下：
float used_mem = info.resident_size;
NSLog(@"使用了 %f MB 内存", used_mem / 1024.0f / 1024.0f)


void *malloc_zone_malloc(malloc_zone_t *zone, size_t size)
{
  MALLOC_TRACE(TRACE_malloc | DBG_FUNC_START, (uintptr_t)zone, size, 0, 0);
  void *ptr;
  if (malloc_check_start && (malloc_check_counter++ >= malloc_check_start)) {
    internal_check();
  }
  if (size > MALLOC_ABSOLUTE_MAX_SIZE) {
    return NULL;
  }
  ptr = zone->malloc(zone, size);
  // 在 zone 分配完内存后就开始使用 malloc_logger 进行进行记录
  if (malloc_logger) {
    malloc_logger(MALLOC_LOG_TYPE_ALLOCATE | MALLOC_LOG_TYPE_HAS_ZONE, (uintptr_t)zone, (uintptr_t)size, 0, (uintptr_t)ptr, 0);
  }
  MALLOC_TRACE(TRACE_malloc | DBG_FUNC_END, (uintptr_t)zone, size, (uintptr_t)ptr, 0);
  return ptr;
}
