//
//  Demo2ViewController.m
//  KVO_BottomResearch
//
//  Created by 帅斌 on 2018/9/21.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "Demo2ViewController.h"
#import "Dog.h"
#import <objc/runtime.h>

@interface Demo2ViewController ()

@property (nonatomic, strong) Dog *dog;

@end

@implementation Demo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加观察者前
    Class kvo_dog = NSClassFromString(@"NSKVONotifying_Dog");
    if (kvo_dog) {
        NSLog(@"kvo_dog存在");
    }else{
        NSLog(@"kvo_dog不存在");
    }
    
    
    
    
    self.dog = [Dog new];
    
    [self.dog addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    
    
    //添加观察者后
    Class kvo_dog_after = NSClassFromString(@"NSKVONotifying_Dog");
    if (kvo_dog_after) {
        NSLog(@"kvo_dog_after存在");
    }else{
        NSLog(@"kvo_dog_after不存在");
    }

    //打印观察者创建类相关方法及其子类
    [self printClasses:kvo_dog_after];
    
    //打印观察者创建类的方法
    [self printMethods:kvo_dog_after];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"observeValueForKeyPath:\nkeyPath:%@\nobject:%@\nchange:%@\ncontext:%@", keyPath, object, change, context);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _dog.age++;
    
    /*
     (lldb) p _dog->isa
     (Class) $0 = NSKVONotifying_Dog
     */
    

    //NSKVONotifying_Dog创建后一直存在
    [self printClasses:[Dog class]];
    
}

- (void)dealloc
{
    [self.dog removeObserver:self forKeyPath:@"age"];
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

/*
 2018-09-21 11:03:36.497142+0800 KVO_BottomResearch[10190:16588083] classes = (
 "NSKVONotifying_Dog"
 )
 */

//打印对应类的方法
- (void)printMethods:(Class)class
{
    //获取所有方法
    unsigned int count = 0;
    Method *methods = class_copyMethodList(class, &count);
    
    //创建一个数组
    NSMutableArray *array = [NSMutableArray array];
    
    //遍历获取方法名称
    for (NSInteger i = 0; i < count; i++) {
        Method method = methods[i];
        SEL sel = method_getName(method);
        NSString *methodName = NSStringFromSelector(sel);
        [array addObject:methodName];
    }
    
    free(methods);
    
    NSLog(@"methods = %@", array);
}

/*
 2018-09-21 11:03:36.497477+0800 KVO_BottomResearch[10190:16588083] methods = (
 "setAge:",
 class,
 dealloc,
 "_isKVOA"
 )
 
 */

#pragma mark - KVO执行过程
/*
 NSKeyValueWillChange
        |
        v
 [Dog setAge:]
        |
        v
 NSKeyValueDidChange
        |
        v
 NSKeyValueNotifyObserver
        |
        v
 - (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
 */

@end
