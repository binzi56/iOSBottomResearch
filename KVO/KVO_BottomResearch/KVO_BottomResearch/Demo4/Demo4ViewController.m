//
//  Demo4ViewController.m
//  KVO_BottomResearch
//
//  Created by 帅斌 on 2018/9/21.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Demo4ViewController.h"
#import "Panda.h"
#import "NSObject+AutoDeallocKVO.h"
#import <objc/runtime.h>

@interface Demo4ViewController ()

@property (nonatomic, strong) Panda *panda;

@end

@implementation Demo4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _panda = [Panda new];
    
    //添加观察者
    [_panda zb_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    [self printClasses:[Panda class]];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _panda.name = @"团团";
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"Demo3ViewController~observeValueForKeyPath:\nkeyPath:%@\nobject:%@\nchange:%@\ncontext:%@", keyPath, object, change, context);
    
}

//打印对应的类及子类
- (void)printClasses:(Class)class
{
    
    //注册类的总数
    int count = objc_getClassList(NULL, 0);
    
    //创建一个数组， 其中包含给定对象
    NSMutableArray *array = [NSMutableArray arrayWithObject:class];
    
    //获取所有已注册的类
    Class *classes = (Class*)malloc(sizeof(Class)*count);
    objc_getClassList(classes, count);
    
    //遍历s
    for (int i = 0; i < count; i++) {
        if (class == class_getSuperclass(classes[i])) {
            [array addObject:classes[i]];
        }
    }
    
    free(classes);
    
    NSLog(@"classes = %@", array);
}
@end
