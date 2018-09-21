//
//  Demo6ViewController.m
//  KVO_BottomResearch
//
//  Created by 帅斌 on 2018/9/21.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Demo5ViewController.h"
#import "Panda.h"
#import "NSObject+BlockKVO.h"
#import <objc/runtime.h>

@interface Demo5ViewController ()

@property (nonatomic, strong) Panda *panda;

@end

@implementation Demo5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _panda = [Panda new];


    //添加观察者
//    [_panda pd_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    [_panda pd_addObserverBlock:self forKeyPath:@"name" handle:^(id observer, NSString *keyPath, id oldValue, id newValue) {
        NSLog(@"oldValue = %@, newValue = %@", oldValue, newValue);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _panda.name = @"圆圆";
}


//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//{
//    NSLog(@"Demo5ViewController~observeValueForKeyPath:\nkeyPath:%@\nobject:%@\nchange:%@\ncontext:%@", keyPath, object, change, context);
//
//}


@end
