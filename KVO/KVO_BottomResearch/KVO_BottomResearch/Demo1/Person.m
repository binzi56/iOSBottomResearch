//
//  Person.m
//  KVO_BottomResearch
//
//  Created by 帅斌 on 2018/9/21.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString*)fullName
{
    return [NSString stringWithFormat:@"%@ %@", _firstName, _lastName];
}


+ (NSSet*)keyPathsForValuesAffectingFullName
{
    return [NSSet setWithObjects:@"lastName", @"firstName", nil];
}



//是否收到通知
//+ (BOOL) automaticallyNotifiesObserversOfSteps {
//    return NO;
//}

@end
