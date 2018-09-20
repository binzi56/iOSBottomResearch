//
//  Cat.m
//  Runtime_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Cat.h"
#import "Dog.h"

@implementation Cat

//+ (void)jump
//{
//    NSLog(@"%s", __func__);
//}

+ (id) forwardingTargetForSelector:(SEL)aSelector {
    
    //1.转发给其他对象
//        if (aSelector == @selector(jump)) {
//            return [Dog new];
//        }
//    
    return [super forwardingTargetForSelector:aSelector];
}

/// 方法名注册
+ (NSMethodSignature* ) methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(jump)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

+ (void) forwardInvocation:(NSInvocation *)anInvocation {
    
    //NSLog(@"%s", __func__);
    
    //2.转发给Dog
    // [anInvocation invokeWithTarget:[Dog new]];
    
    //3.转发给自己
    anInvocation.selector = @selector(run);
    anInvocation.target = self;
    [anInvocation invoke];
}

+ (void) run {
    NSLog(@"%s", __func__);
}


@end
