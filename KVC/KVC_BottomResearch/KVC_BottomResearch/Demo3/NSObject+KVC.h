//
//  NSObject+KVC.h
//  KVC_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVC)

- (void)zb_setValue:(id)value forKey:(NSString *)key;

- (id)zb_valueForKey:(NSString *)key;

@end
