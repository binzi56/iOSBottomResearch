//
//  Demo6ViewController.m
//  KVC_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Demo6ViewController.h"

@interface Demo6ViewController ()

@end

@implementation Demo6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *arr = @[@"Monday", @"Tuesday", @"Wednesday"];
    NSArray *lengthArr = [arr valueForKey:@"length"];
    NSLog(@"Demo6~%@", lengthArr);
    
    
    NSArray* lowercaseArr = [arr valueForKey:@"lowercaseString"];
    NSLog(@"Demo6~%@", lowercaseArr);
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
