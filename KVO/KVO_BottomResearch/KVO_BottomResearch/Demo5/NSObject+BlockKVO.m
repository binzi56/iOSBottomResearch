//
//  NSObject+BlockKVO.m
//  KVO_BottomResearch
//
//  Created by 帅斌 on 2018/9/21.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "NSObject+BlockKVO.h"
#import <objc/message.h>

static const char* PDKVOAssiociateKey = "PDKVOAssiociateKey";

@interface Info : NSObject

@property (nonatomic, weak) NSObject* observer;
@property (nonatomic, strong) NSString* keyPath;
@property (nonatomic, copy) KVOBlock hanleBlock;

@end


@implementation Info

- (instancetype) initWithObserver:(NSObject*)observer forKeyPath:(NSString*) keyPath handleBlock:(KVOBlock) block {
    if (self == [super init]) {
        _observer = observer;
        _keyPath = keyPath;
        _hanleBlock = block;
    }
    return self;
}

@end

@implementation NSObject (BlockKVO)


- (void) pd_addObserverBlock:(NSObject*) observer forKeyPath:(NSString*) keyPath handle:(KVOBlock) handleBlock {
    
    // 动态创建一个子类
    Class newClass = [self createClass:keyPath];
    
    // 修改了isa的指向
    object_setClass(self, newClass);
    
    // 信息保存
    Info* info = [[Info alloc] initWithObserver:observer forKeyPath:keyPath handleBlock:handleBlock];
    NSMutableArray* array = objc_getAssociatedObject(self, PDKVOAssiociateKey);
    if (!array) {
        array = [NSMutableArray array];
        objc_setAssociatedObject(self, PDKVOAssiociateKey, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [array addObject:info];
}

//添加观察者
- (void)pd_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {

    // 动态创建一个子类
    Class newClass = [self createClass:keyPath];

    // 修改了isa的指向
    object_setClass(self, newClass);

    // 关联方法
    objc_setAssociatedObject(self, (__bridge void *)@"objc", observer, OBJC_ASSOCIATION_ASSIGN);
}

// NSKVONotifying_XX
- (Class) createClass:(NSString*) keyPath {

    // 1. 拼接子类名
    NSString* oldName = NSStringFromClass([self class]);
    NSString* newName = [NSString stringWithFormat:@"NSKVONotifying_%@", oldName];

    // 2. 创建并注册类
    Class newClass = NSClassFromString(newName);
    if (!newClass) {

        // 创建并注册类
        newClass = objc_allocateClassPair([self class], newName.UTF8String, 0);
        objc_registerClassPair(newClass);

        // 添加一些方法
        // class
        Method classMethod = class_getInstanceMethod([self class], @selector(class));
        const char* classTypes = method_getTypeEncoding(classMethod);
        class_addMethod(newClass, @selector(class), (IMP)pd_class, classTypes);

        // setter
        NSString* setterMethodName = setterForGetter(keyPath);
        SEL setterSEL = NSSelectorFromString(setterMethodName);
        Method setterMethod = class_getInstanceMethod([self class], setterSEL);
        const char* setterTypes = method_getTypeEncoding(setterMethod);

        class_addMethod(newClass, setterSEL, (IMP)pd_setter, setterTypes);


        //添加析构方法
        SEL deallocSEL = NSSelectorFromString(@"dealloc");
        Method deallocMethod = class_getInstanceMethod([self class], deallocSEL);
        const char* deallocTypes = method_getTypeEncoding(deallocMethod);
        class_addMethod(newClass, deallocSEL, (IMP)pdMyDealloc, deallocTypes);

    }
    return newClass;
}


void pdMyDealloc(id self, SEL _cmd) {
    // 父类
    Class superClass = [self class];//class_getSuperclass(object_getClass(self));

    object_setClass(self, superClass);

    NSLog(@"");
}

#pragma mark - c 函数
static void pd_setter(id self, SEL _cmd, id newValue) {
    NSLog(@"%s", __func__);

    struct objc_super superStruct = {
        self,
        class_getSuperclass(object_getClass(self))
    };
    
    // keypath
    NSString* keyPath = getterForSetter(NSStringFromSelector(_cmd));
    
    // 获取旧值
    // kVC
    id oldValue = objc_msgSendSuper(&superStruct, NSSelectorFromString(keyPath));
    
    // 改变父类的值
    objc_msgSendSuper(&superStruct, _cmd, newValue);
    
    NSMutableArray* array = objc_getAssociatedObject(self, PDKVOAssiociateKey);
    if (array) {
        for (Info* info in array) {
            if ([info.keyPath isEqualToString:keyPath]) {
                info.hanleBlock(info.observer, keyPath, oldValue, newValue);
                return;
            }
        }
    }
    
    //    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:), key, self, @{key:newValue}, nil);
}


Class pd_class(id self, SEL _cmd) {
    return class_getSuperclass(object_getClass(self));
}


// 移除观察者
- (void)pd_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {

    // 父类
    Class superClass = [self class];
    //class_getSuperclass(object_getClass(self));
    
    object_setClass(self, superClass);

}


#pragma mark - 从get方法获取set方法的名称 key ===>>> setKey:
static NSString  * setterForGetter(NSString *getter){
    
    if (getter.length <= 0) { return nil; }
    
    NSString *firstString = [[getter substringToIndex:1] uppercaseString];
    NSString *leaveString = [getter substringFromIndex:1];
    
    return [NSString stringWithFormat:@"set%@%@:",firstString,leaveString];
}

#pragma mark - 从set方法获取getter方法的名称 set<Key>:===> Key
static NSString * getterForSetter(NSString *setter){
    
    if (setter.length <= 0 || ![setter hasPrefix:@"set"] || ![setter hasSuffix:@":"]) { return nil;}
    
    NSRange range = NSMakeRange(3, setter.length-4);
    NSString *getter = [setter substringWithRange:range];
    NSString *firstString = [[getter substringToIndex:1] lowercaseString];
    getter = [getter stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstString];
    
    return getter;
}

@end
