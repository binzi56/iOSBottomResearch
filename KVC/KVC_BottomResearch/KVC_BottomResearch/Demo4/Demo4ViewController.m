//
//  Demo4ViewController.m
//  KVC_BottomResearch
//
//  Created by 帅斌 on 2018/9/20.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Demo4ViewController.h"
#import "Human.h"
#import "Container.h"

@interface Demo4ViewController ()

@end

@implementation Demo4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.系统异常处理调试
    Human *human = [Human new];
    
    [human setValue:nil forKey:@"name"];
    
    [human setValue:@"male" forKey:@"sex"];
    
    NSLog(@"human ~ %@", [human valueForKey:@"sex"]);
    
    //2.正确性验证
    NSNumber *value = @111;
    if ([human validateValue:&value forKey:@"age" error:NULL]) {
        [human setValue:value forKey:@"age"];
    }
    
    
    
    
    //3.万能容器测试
    Container *container = [Container new];
    [container setValue:@"Jack" forKey:@"name"];
    NSLog(@"container ~ %@", [container valueForKey:@"name"]);

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
