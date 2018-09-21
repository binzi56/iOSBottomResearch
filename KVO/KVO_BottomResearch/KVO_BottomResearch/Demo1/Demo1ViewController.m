//
//  Demo1ViewController.m
//  KVO_BottomResearch
//
//  Created by 帅斌 on 2018/9/21.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Demo1ViewController.h"
#import "Person.h"

@interface Demo1ViewController ()

@property (nonatomic, strong) Person *per;

@end

@implementation Demo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.per = [Person new];
    
    //NSKeyValueObservingOptionPrior 值改变返回两次（修改前，修改后）
//    [self.per addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionPrior | NSKeyValueObservingOptionNew context:nil];
    
    [self.per addObserver:self forKeyPath:@"fullName" options:NSKeyValueObservingOptionPrior | NSKeyValueObservingOptionNew context:nil];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"observeValueForKeyPath:\nkeyPath:%@\nobject:%@\nchange:%@\ncontext:%@", keyPath, object, change, context);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _per.age++;
    _per.firstName = @"帅";
    _per.lastName = @"斌";
}

- (void)dealloc
{
//    [self.per removeObserver:self forKeyPath:@"age"];
    
    [self.per removeObserver:self forKeyPath:@"fullName"];

}

@end
