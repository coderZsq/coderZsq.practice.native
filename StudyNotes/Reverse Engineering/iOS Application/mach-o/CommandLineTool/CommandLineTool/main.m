//
//  main.m
//  CommandLineTool
//
//  Created by 朱双泉 on 2019/6/13.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <mach-o/fat.h>
#import <mach-o/loader.h>

// argc: 参数的个数
// argv: 存放参数的数组
// argv[0]: 是当前可执行文件的路径
int main(int argc, char * argv[]) {
    @autoreleasepool {
        if (argc == 1) {
            printf("-l 查看Mach-O信息\n");
            return 0;
        }
        
        if (strcmp(argv[1], "-l") != 0) {
            printf("-l 查看Mach-O信息\n");
            return 0;
        }
        
        NSString *appPath = @"/private/var/mobile/Containers/Bundle/Application/34AED515-50AA-42AF-8040-A2C0B2DD1834/Shadowrocket.app/Shadowrocket";
        NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:appPath];
        int length = sizeof(uint32_t);
        // 读取最前面的4个字节 (magic number, 魔数, 用来标识文件类型)
        NSData *magicData = [handle readDataOfLength:length];
        // 魔数, 用来标识文件类型
        uint32_t magicNumber;
        [magicData getBytes:&magicNumber length:length];
        // 大小端
        if (magicNumber == FAT_CIGAM || magicNumber == FAT_MAGIC) {
            printf("FAT文件\n");
        } else if (magicNumber == MH_MAGIC || magicNumber == MH_CIGAM) {
            printf("非64bit架构文件\n");
        } else if (magicNumber == MH_MAGIC_64 || magicNumber == MH_CIGAM_64) {
            printf("64bit架构文件\n");
        } else {
            printf("读取失败\n");
        }
        printf("读取magicNumber - 0x%x\n", magicNumber);

        [handle closeFile];
        return 0;
    }
}
