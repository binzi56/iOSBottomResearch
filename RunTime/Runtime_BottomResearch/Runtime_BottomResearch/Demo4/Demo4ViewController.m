//
//  Demo4ViewController.m
//  Runtime_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Demo4ViewController.h"
#import "Dog.h"
#import "Cat.h"
#import <objc/message.h>

//extern void testC();

extern void instrumentObjcMessageSends(BOOL);

@interface Demo4ViewController ()

@end

@implementation Demo4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //函数声明用法
//    testC();
    
    //打印路径：      /private/tmp/msgSends-xxxxxx
    instrumentObjcMessageSends(YES);
    //实例方法
    [[Dog new] run];
    
    
    //类方法
    [Cat jump];
    
    instrumentObjcMessageSends(NO);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
