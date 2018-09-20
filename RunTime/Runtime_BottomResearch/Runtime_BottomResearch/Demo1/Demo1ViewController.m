//
//  Demo1ViewController.m
//  Runtime_BottomResearch
//
//  Created by 帅斌 on 2018/9/19.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Demo1ViewController.h"
#import <objc/message.h>
#import "Human.h"
#import "Animal.h"

@interface Demo1ViewController ()

@end

@implementation Demo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.正常代码
    Human *human = [[Human alloc] init];
    [human sleep];
    
    //2.完整系统实现
    Human *p = ((Human *(*)(id, SEL))(void *)objc_msgSend)((id)((Human *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("Human"), sel_registerName("alloc")), sel_registerName("init"));
    ((void (*)(id, SEL))(void *)objc_msgSend)((id)p, sel_registerName("sleep"));
    
    //3.消息发送机制
    objc_msgSend(human, @selector(sleep));
    
    objc_msgSend([Human class], @selector(eat));
    
    
    //4.交换目标对象
    Animal *animal = [Animal new];
    object_setClass(human, [animal class]);
    
    [human sleep];
    
    
    //5.使用C方法
    Method test = class_getInstanceMethod([human class], @selector(sleep));
    method_setImplementation(test, (IMP)testC);
}


void testC () {
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
