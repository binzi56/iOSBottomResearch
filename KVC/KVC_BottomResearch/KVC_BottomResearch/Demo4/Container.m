//
//  Container.m
//  KVC_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Container.h"

@interface Container()

@property (nonatomic, strong) NSMutableDictionary *dic;

@end
@implementation Container

- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
    if (!key || [key isEqualToString:@""]) {
        return;
    }
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    [_dic setValue:value forKey:key];
}

- (id) valueForUndefinedKey:(NSString *)key {
    if (!key || [key isEqualToString:@""]) {
        return nil;
    }
    return [_dic valueForKey:key];
}

@end
