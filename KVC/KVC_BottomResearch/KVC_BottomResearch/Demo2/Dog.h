//
//  Dog.h
//  KVC_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pig : NSObject

@property (nonatomic, strong) NSString *name;

@end

@interface Dog : NSObject
{
    @public
    NSString* _name;
    NSString* _isName;
    NSString* name;
    NSString* isName;
}

@property (nonatomic, strong) Pig *pig;

@end
