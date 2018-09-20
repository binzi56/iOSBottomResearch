//
//  Human.m
//  KVC_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Human.h"

@implementation Human


// 对非对象类型，值不能为空
//- (void)setNilValueForKey:(NSString *)key
//{
//    NSLog(@"%@ 值不能为空", key);
//}

// 赋值key值不存在
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"key = %@值不存在 ", key);
}

//// 取值key值不存在
//- (id)valueForUndefinedKey:(NSString *)key
//{
//    NSLog(@"key=%@不存在", key);
//    return nil;
//}
//
//- (BOOL)validateAge:(inout id  _Nullable __autoreleasing *)ioValue  error:(out NSError * _Nullable __autoreleasing *)outError
//{
//    NSNumber *value = (NSNumber*)*ioValue;
//    NSLog(@"%@", value);
//    if (value.integerValue <= 0 || value.integerValue >= 100) {
//        return NO;
//    }
//    return YES;
//}

@end
