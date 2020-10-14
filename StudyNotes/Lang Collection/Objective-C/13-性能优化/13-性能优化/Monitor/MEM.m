//
//  MEM.m
//  13-性能优化
//
//  Created by 朱双泉 on 2020/10/14.
//

#import "MEM.h"
#import <mach/mach.h>

@implementation MEM

# if 0
struct task_vm_info {
  mach_vm_size_t  virtual_size;       // 虚拟内存大小
  integer_t region_count;             // 内存区域的数量
  integer_t page_size;
  mach_vm_size_t  resident_size;      // 驻留内存大小
  mach_vm_size_t  resident_size_peak; // 驻留内存峰值

  ...

  /* added for rev1 */
  mach_vm_size_t  phys_footprint;     // 物理内存

  ...
#endif
    

uint64_t memoryUsage() {
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t result = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if (result != KERN_SUCCESS)
        return 0;
    return vmInfo.phys_footprint;
}
    
@end
