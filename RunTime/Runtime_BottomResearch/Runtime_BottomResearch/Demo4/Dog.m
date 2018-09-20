//
//  Dog.m
//  Runtime_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Dog.h"
#import "Cat.h"

@implementation Dog

//- (void)run
//{
//    NSLog(@"%s", __func__);
//}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
//    //1.转发给其他对象
//    if (aSelector  == @selector(run)) {
//        return [Cat new];
//    }
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if (aSelector  == @selector(run)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"%s", __func__);
    
    //2.转发给Cat
//    [anInvocation invokeWithTarget:[Cat new]];
    
    //3.转发给自己
    anInvocation.selector = @selector(run);
    anInvocation.target = self;
    [anInvocation invoke];
}


////C函数
//void testC () {
//    NSLog(@"%s", __func__);
//}

@end
