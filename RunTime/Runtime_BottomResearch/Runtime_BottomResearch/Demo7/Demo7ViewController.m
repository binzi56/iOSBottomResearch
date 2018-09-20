//
//  Demo7ViewController.m
//  Runtime_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Demo7ViewController.h"
#import "Bear.h"

@interface Demo7ViewController ()

@end

@implementation Demo7ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Bear *bear = [Bear new];
    bear.name = @"Same";
    bear.age = 4;
    bear.sex = @"male";
    
    NSString* path = [NSString stringWithFormat:@"%@/archiver.plist", NSHomeDirectory()];
    
    // 归档
    [NSKeyedArchiver archiveRootObject:bear toFile:path];
    
    // 解档
    Bear *tempBear = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"name = %@, age = %ld", tempBear.name, tempBear.age);
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
