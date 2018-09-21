//
//  Dog.m
//  KVO_BottomResearch
//
//  Created by 帅斌 on 2018/9/21.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Dog.h"

@implementation Dog

- (void)setAge:(NSInteger)age
{
    _age = age;
}

- (void)setName:(NSString *)name
{
    [self willChangeValueForKey:@"name"];       //在调用存取方法之前调用
    [super setValue:@"newName" forKey:@"name"]; //调用父类的存取方法
    [self didChangeValueForKey:@"name"];        //在调用存取方法之后调用
}


@end
