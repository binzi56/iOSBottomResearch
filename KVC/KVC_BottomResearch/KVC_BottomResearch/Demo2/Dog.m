//
//  Dog.m
//  KVC_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Dog.h"

@implementation Pig

@end

@implementation Dog

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pig = [Pig new];
    }
    return self;
}


//- (void)setName:(NSString*) name {
//    NSLog(@"%s", __func__);
//}
//
//- (void)_setName:(NSString*) name {
//    NSLog(@"%s", __func__);
//}
//
//- (void)setIsName:(NSString*) name {
//    NSLog(@"%s", __func__);
//}
//
//- (NSString*)getName {
//    NSLog(@"%s", __func__);
//    return @"getName";
//}
//
//- (NSString*)name {
//    return @"name";
//}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%s", __func__);
}

@end
