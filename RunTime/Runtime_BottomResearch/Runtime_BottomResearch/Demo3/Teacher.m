//
//  Teacher.m
//  Runtime_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Teacher.h"
#import <objc/message.h>

@implementation Teacher

//+ (void)cook
//{
//    NSLog(@"%s", __func__);
//}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    NSLog(@"%s", __func__);
    if (sel == @selector(cook)) {
        
//        Method washMethod = class_getInstanceMethod(object_getClass(self), @selector(wash));
        Method washMethod = class_getClassMethod(self, @selector(wash));
        IMP washIMP = method_getImplementation(washMethod);
        const char *types = method_getTypeEncoding(washMethod);
        NSLog(@"types~~~%s", types);
        
        return class_addMethod(object_getClass(self), sel, washIMP, types);
    }
    return [super resolveInstanceMethod:sel];
}

+ (void)wash
{
    NSLog(@"%s", __func__);
}

@end
