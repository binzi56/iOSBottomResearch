//
//  Demo5ViewController.m
//  Runtime_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Demo5ViewController.h"
#import <objc/message.h>

@interface Demo5ViewController ()

@end

@implementation Demo5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /// 创建一类对
    Class snake = objc_allocateClassPair([NSObject class], "snake", 0);
    
    /// 添加实例变量
    // const char* types= "v@:"
    NSString *name = @"name";
    
    class_addIvar(snake, name.UTF8String, sizeof(id), log2(sizeof(id)), @encode(id));
    
    // 添加方法
    class_addMethod(snake, @selector(climb), (IMP)climb, "v@:");
    
    /// 注册类
    objc_registerClassPair(snake);
    
    
    
    // 创建实例对象
    id cat = [[snake alloc] init];
    [cat setValue:@"Jack" forKey:@"name"];
    NSLog(@"name = %@", [cat valueForKey:name]);
    
    /// 方法调用
    [cat performSelector:@selector(climb)];
    
    
}

void climb() {
    NSLog(@"%s", __func__);
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
