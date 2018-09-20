//
//  Demo2ViewController.m
//  Runtime_BottomResearch
//
//  Created by 帅斌 on 2018/9/19.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Demo2ViewController.h"
#import <objc/message.h>

@interface Demo2ViewController ()

@end

@implementation Demo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //不导入类名执行方法（反射机制）
    Class humanClass = NSClassFromString(@"Human");
    SEL sleepSEL = NSSelectorFromString(@"sleep");
    id human = [humanClass new];
    objc_msgSend(human, sleepSEL);    
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
