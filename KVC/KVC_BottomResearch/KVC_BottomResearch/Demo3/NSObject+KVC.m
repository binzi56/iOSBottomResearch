//
//  NSObject+KVC.m
//  KVC_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "NSObject+KVC.h"
#import <objc/runtime.h>

@implementation NSObject (KVC)


- (void)zb_setValue:(id)value forKey:(NSString *)key
{
    // 判断是否合法
    if (key == nil && key.length == 0) {
        return;
    }
    
    // Key
    NSString* Key = key.capitalizedString;
    
    /// 先找相关方法
    //set<Key>:, _set<Key>:, setIs<Key>:
    NSString* setKey = [NSString stringWithFormat:@"set%@:", Key];
    if ([self respondsToSelector:NSSelectorFromString(setKey)]) {
        [self performSelector:NSSelectorFromString(setKey) withObject:value];
        return;
    }
    
    NSString* _setKey = [NSString stringWithFormat:@"_set%@:", Key];
    if ([self respondsToSelector:NSSelectorFromString(_setKey)]) {
        [self performSelector:NSSelectorFromString(_setKey) withObject:value];
        return;
    }
    
    NSString* setIsKey = [NSString stringWithFormat:@"setIs%@:", Key];
    if ([self respondsToSelector:NSSelectorFromString(setIsKey)]) {
        [self performSelector:NSSelectorFromString(setIsKey) withObject:value];
        return;
    }
    
    if (![self.class accessInstanceVariablesDirectly]) {
        NSException* exception = [NSException exceptionWithName:@"NSUnkonwnKeyException" reason:@"setValue:forUndefineKey" userInfo:nil];
        @throw exception;
    }
    
    /// 再找相关变量
    /// 获取所以成员变量
    unsigned int count = 0;
    Ivar* ivars = class_copyIvarList([self class], &count);
    
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++) {
        Ivar var = ivars[i];
        const char* varName = ivar_getName(var);
        NSString* name = [NSString stringWithUTF8String:varName];
        [arr addObject:name];
    }
    
    // _<key> _is<Key> <key> is<Key>
    for (int i = 0; i < count; i++) {
        NSString* keyName = arr[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"_%@", key]]) {
            object_setIvar(self, ivars[i], value);
            free(ivars);
            return;
        }
    }
    
    for (int i = 0; i < count; i++) {
        NSString* keyName = arr[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"_is%@", Key]]) {
            object_setIvar(self, ivars[i], value);
            free(ivars);
            return;
        }
    }
    
    for (int i = 0; i < count; i++) {
        NSString* keyName = arr[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"%@", key]]) {
            object_setIvar(self, ivars[i], value);
            free(ivars);
            return;
        }
    }
    
    for (int i = 0; i < count; i++) {
        NSString* keyName = arr[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"is%@", Key]]) {
            object_setIvar(self, ivars[i], value);
            free(ivars);
            return;
        }
    }
    
    [self setValue:value forUndefinedKey:key];
    free(ivars);
}

- (id)zb_valueForKey:(NSString *)key
{
    // 判断是否合法
    if (key == nil && key.length == 0) {
        return nil;
    }
    
    // Key
    NSString* Key = key.capitalizedString;
    
    /// 先找相关方法
    //get<Key>, key
    NSString* getKey = [NSString stringWithFormat:@"get%@", Key];
    if ([self respondsToSelector:NSSelectorFromString(getKey)]) {
        return [self performSelector:NSSelectorFromString(getKey) withObject:nil];
    }
    
    //需要注意这里是小写key
    NSString* aKey = [NSString stringWithFormat:@"%@", key];
    if ([self respondsToSelector:NSSelectorFromString(aKey)]) {
        return [self performSelector:NSSelectorFromString(aKey) withObject:nil];
    }
    
    if (![self.class accessInstanceVariablesDirectly]) {
        NSException* exception = [NSException exceptionWithName:@"NSUnkonwnKeyException" reason:@"valueForUndefinedKey:" userInfo:nil];
        @throw exception;
    }
    
    /// 再找相关变量
    /// 获取所以成员变量
    unsigned int count = 0;
    Ivar* ivars = class_copyIvarList([self class], &count);
    
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++) {
        Ivar var = ivars[i];
        const char* varName = ivar_getName(var);
        NSString* name = [NSString stringWithUTF8String:varName];
        [arr addObject:name];
    }
    
    // _<key> _is<Key> <key> is<Key>
    for (int i = 0; i < count; i++) {
        NSString* keyName = arr[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"_%@", key]]) {
            object_getIvar(self, ivars[i]);
            free(ivars);
            break;
        }
    }
    
    for (int i = 0; i < count; i++) {
        NSString* keyName = arr[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"_is%@", Key]]) {
            object_getIvar(self, ivars[i]);
            free(ivars);
            break;
        }
    }
    
    for (int i = 0; i < count; i++) {
        NSString* keyName = arr[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"%@", key]]) {
            object_getIvar(self, ivars[i]);
            free(ivars);
            break;
        }
    }
    
    for (int i = 0; i < count; i++) {
        NSString* keyName = arr[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"is%@", Key]]) {
            object_getIvar(self, ivars[i]);
            free(ivars);
            break;
        }
    }
    [self valueForUndefinedKey:key];
    free(ivars);
    return nil;
}


@end
