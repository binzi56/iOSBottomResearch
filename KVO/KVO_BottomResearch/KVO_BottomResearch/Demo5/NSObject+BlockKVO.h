//
//  NSObject+BlockKVO.h
//  KVO_BottomResearch
//
//  Created by 帅斌 on 2018/9/21.
//  Copyright © 2018年 personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BlockKVO)


typedef void(^KVOBlock)(id observer, NSString* keyPath, id oldValue, id newValue);


- (void) pd_addObserverBlock:(NSObject*) observer forKeyPath:(NSString*) keyPath handle:(KVOBlock)handleBlock;


//// 添加观察者
//- (void)pd_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end
