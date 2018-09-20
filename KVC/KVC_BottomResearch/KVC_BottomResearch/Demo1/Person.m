//
//  Person.m
//  KVC_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Person.h"

@implementation Person

//- (void)setName:(NSString *)name
//{
//    _name = name;
//}
//
//- (NSString *)name
//{
//    return _name;
//}

//设置NO可禁用KVC
+(BOOL)accessInstanceVariablesDirectly
{
    return YES;
}

-(id)valueForUndefinedKey:(NSString *)key
{
    NSLog(@"error~key:%@~不存在\n%s",key, __func__);
    return nil;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"error~key:%@~不存在\n%s",key, __func__);
}

@end
