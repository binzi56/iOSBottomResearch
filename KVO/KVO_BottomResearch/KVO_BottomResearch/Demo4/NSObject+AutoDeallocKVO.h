//
//  NSObject+AutoDeallocKVO.h
//  KVO_BottomResearch
//
//  Created by 帅斌 on 2018/9/21.
//  Copyright © 2018年 personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AutoDeallocKVO)

// 添加观察者
- (void)zb_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

//// 删除观察者
//- (void)zb_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end
