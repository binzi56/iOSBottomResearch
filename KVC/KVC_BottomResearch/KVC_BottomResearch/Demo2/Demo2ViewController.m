//
//  Demo2ViewController.m
//  KVC_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Demo2ViewController.h"
#import "Dog.h"

@interface Demo2ViewController ()

@end

@implementation Demo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Dog *dog = [Dog new];
//    [dog setValue:@"小花" forKey:@"name"];
    
    [dog setValue:@"小黑" forKeyPath:@"pig.name"];
    
    NSLog(@"pig name = %@", [dog valueForKeyPath:@"pig.name"]);
    NSLog(@"name = %@", dog->name);
//    NSLog(@"_name = %@", dog->_name);
    NSLog(@"isName = %@", dog->isName);
    NSLog(@"_isName = %@", dog->_isName);
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
