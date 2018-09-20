//
//  Demo5ViewController.m
//  KVC_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Demo5ViewController.h"
#import "Human.h"

@interface Demo5ViewController ()

@end

@implementation Demo5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Human *human = [Human new];
    
    NSDictionary *dic = @{@"name": @"Jack",
                          @"age": @23};
    
    [human setValuesForKeysWithDictionary:dic];
    
    NSLog(@"Demo5~human.name:\n%@", human.name);
    
    NSArray *keys = @[@"name", @"age"];
    
    NSDictionary *tempDic = [human dictionaryWithValuesForKeys:keys];
    
    NSLog(@"Demo5~human~tempDic:%@", tempDic);
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
