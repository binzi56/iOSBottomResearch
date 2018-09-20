//
//  Student.m
//  Runtime_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Student.h"
#import <objc/message.h>

@implementation Student


//- (void)run
//{
//    NSLog(@"学生~~~~~run run run~~~~~~~");
//}

/*************************  C方法  ***************************/
void run ()
{
    NSLog(@"c函数~~~%s", __func__);
}

//实例对象(交换方法实现)
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    NSLog(@"%s", __func__);
//    if (sel == @selector(run)) {
//        return class_addMethod(self, sel, (IMP)run, "v@:");
//    }
//    return [super resolveInstanceMethod:sel];
//}

/*************************  C方法  ***************************/
/*************************  OC方法  ***************************/
- (void)smile
{
    NSLog(@"%s", __func__);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"%s", __func__);
    if (sel == @selector(run)) {
        
        Method smileMethod = class_getInstanceMethod(self, @selector(smile));
        IMP smileIMP = method_getImplementation(smileMethod);
        const char *types = method_getTypeEncoding(smileMethod);
        NSLog(@"types~~~%s", types);
        
        return class_addMethod(self, sel, smileIMP, types);
    }
    return [super resolveInstanceMethod:sel];
}

/*************************  OC方法  ***************************/



@end
