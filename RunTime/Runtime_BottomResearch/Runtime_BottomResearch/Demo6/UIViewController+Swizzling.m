//
//  UIViewController+Swizzling.m
//  Runtime_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import <objc/runtime.h>

@implementation UIViewController (Swizzling)

+ (void) load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method m1 = class_getInstanceMethod(self, @selector(viewWillAppear:));
        Method m2 = class_getInstanceMethod(self, @selector(test_viewWillAppear:));
        
        
        method_exchangeImplementations(m1, m2);
        
        
    });
    
}

- (void) test_viewWillAppear:(BOOL) animated {
    NSLog(@"页面统计~~~~~~%s", __func__);
}

@end
