//
//  Demo9ViewController.m
//  KVC_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Demo9ViewController.h"
#import "Human.h"

@interface Demo9ViewController ()

@end

@implementation Demo9ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableSet *arr = [NSMutableSet set];
    for (int i = 0; i < 10; i++) {
        Human *human = [Human new];
        
        NSDictionary *dic = @{@"name": @"Jack",
                              @"age": @(23 + 3*arc4random_uniform(6))};
        [human setValuesForKeysWithDictionary:dic];
        [arr addObject:human];
    }
    
    NSLog(@"%@", [arr valueForKey:@"age"]);
    
    
    NSMutableSet *arr1 = [NSMutableSet set];
    for (int i = 0; i < 10; i++) {
        Human *human = [Human new];
        
        NSDictionary *dic = @{@"name": @"Jack",
                              @"age": @(23 + 3*arc4random_uniform(6))};
        [human setValuesForKeysWithDictionary:dic];
        [arr1 addObject:human];
    }
    
    
    NSSet *set = [NSSet setWithObjects:arr,arr1, nil];
    
    NSArray *resultArr = [set valueForKeyPath:@"@distinctUnionOfSets.age"];
    NSLog(@"resultArr = %@", resultArr);
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
