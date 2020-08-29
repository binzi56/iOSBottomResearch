//
//  Demo3ViewController.m
//  KVO_BottomResearch
//
//  Created by 帅斌 on 2018/9/21.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Demo3ViewController.h"
#import "Cat.h"
#import <objc/message.h>
#import "NSObject+KVO.h"

@interface Demo3ViewController ()

@property (nonatomic, strong) Cat *cat;

@end

@implementation Demo3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _cat = [Cat new];
    
    Class beforeClass = NSClassFromString(@"NSKVONotifying_Cat");
    id beforeObject = [[beforeClass alloc] init];
    NSLog(@"beforeObject-class:%@", [beforeObject class]);

    
    //添加观察者
    [_cat gv_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    Class afterClass = NSClassFromString(@"NSKVONotifying_Cat");
    id afterObject = [[afterClass alloc] init];
    
    NSLog(@"afterClass-class:%@", [afterObject class]);
    
    [self printClasses:[Cat class]];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _cat.name = @"小花";
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
            Class temp = classes[i];
            if ([NSStringFromClass(temp) isEqualToString:@"NSKVONotifying_Cat"]) {
                NSLog(@"temp=====%@", temp);
            }
            
            [array addObject:classes[i]];
        }
    }
    
    free(classes);
    
    NSLog(@"classes = %@", array);
}

- (void)dealloc
{
    [_cat gv_removeObserver:self forKeyPath:@"name"];
}


@end
