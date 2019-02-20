# KVC

KVC(`Key Value Coding`)，相关函数在`NSKeyValueCoding.h`文件中，是一个非正式协议。它提供了一种间接访问其属性方法或成员变量的机制，可以通过字符串来访问对应的属性方法或成员变量。

### 一、目录
1. 初识KVC
2. KVC赋值取值过程
3. KVC异常处理及正确性相关
4. 简单自定义KVC
5. KVC进阶用法

### 二、内容缩略图
具体内容请查看KVC.xmind；
![KVC缩略图](https://upload-images.jianshu.io/upload_images/1893416-36ef949eb4d299eb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 三、其他
#### 3.1 KVC异常处理及正确性验证
```
#import "Human.h"

@implementation Human


// 对非对象类型，值不能为空
- (void)setNilValueForKey:(NSString *)key
{
    NSLog(@"%@ 值不能为空", key);
}

// 赋值key值不存在
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"key = %@值不存在 ", key);
}

// 取值key值不存在
- (id)valueForUndefinedKey:(NSString *)key
{
    NSLog(@"key=%@不存在", key);
    return nil;
}

//正确性验证
- (BOOL)validateAge:(inout id  _Nullable __autoreleasing *)ioValue  error:(out NSError * _Nullable __autoreleasing *)outError
{
    NSNumber *value = (NSNumber*)*ioValue;
    NSLog(@"%@", value);
    if (value.integerValue <= 0 || value.integerValue >= 100) {
        return NO;
    }
    return YES;
}

@end

```

#### 3.2 自定义KVC
从自定义KVC看取值赋值方法过程：
```
#import "NSObject+KVC.h"
#import <objc/runtime.h>

@implementation NSObject (KVC)


- (void)zb_setValue:(id)value forKey:(NSString *)key
{
    // 判断是否合法
    if (key == nil && key.length == 0) {
        return;
    }

    // Key
    NSString* Key = key.capitalizedString;

    /// 先找相关方法
    //set<Key>:, _set<Key>:, setIs<Key>:
    NSString* setKey = [NSString stringWithFormat:@"set%@:", Key];
    if ([self respondsToSelector:NSSelectorFromString(setKey)]) {
        [self performSelector:NSSelectorFromString(setKey) withObject:value];
        return;
    }

    NSString* _setKey = [NSString stringWithFormat:@"_set%@:", Key];
    if ([self respondsToSelector:NSSelectorFromString(_setKey)]) {
        [self performSelector:NSSelectorFromString(_setKey) withObject:value];
        return;
    }

    NSString* setIsKey = [NSString stringWithFormat:@"setIs%@:", Key];
    if ([self respondsToSelector:NSSelectorFromString(setIsKey)]) {
        [self performSelector:NSSelectorFromString(setIsKey) withObject:value];
        return;
    }

    if (![self.class accessInstanceVariablesDirectly]) {
        NSException* exception = [NSException exceptionWithName:@"NSUnkonwnKeyException" reason:@"setValue:forUndefineKey" userInfo:nil];
        @throw exception;
    }

    /// 再找相关变量
    /// 获取所以成员变量
    unsigned int count = 0;
    Ivar* ivars = class_copyIvarList([self class], &count);

    NSMutableArray* arr = [[NSMutableArray alloc] init];

    for (int i = 0; i < count; i++) {
        Ivar var = ivars[i];
        const char* varName = ivar_getName(var);
        NSString* name = [NSString stringWithUTF8String:varName];
        [arr addObject:name];
    }

    // _<key> _is<Key> <key> is<Key>
    for (int i = 0; i < count; i++) {
        NSString* keyName = arr[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"_%@", key]]) {
            object_setIvar(self, ivars[i], value);
            free(ivars);
            return;
        }
    }

    for (int i = 0; i < count; i++) {
        NSString* keyName = arr[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"_is%@", Key]]) {
            object_setIvar(self, ivars[i], value);
            free(ivars);
            return;
        }
    }

    for (int i = 0; i < count; i++) {
        NSString* keyName = arr[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"%@", key]]) {
            object_setIvar(self, ivars[i], value);
            free(ivars);
            return;
        }
    }

    for (int i = 0; i < count; i++) {
        NSString* keyName = arr[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"is%@", Key]]) {
            object_setIvar(self, ivars[i], value);
            free(ivars);
            return;
        }
    }

    [self setValue:value forUndefinedKey:key];
    free(ivars);
}

- (id)zb_valueForKey:(NSString *)key
{
    // 判断是否合法
    if (key == nil && key.length == 0) {
        return nil;
    }

    // Key
    NSString* Key = key.capitalizedString;

    /// 先找相关方法
    //get<Key>, key
    NSString* getKey = [NSString stringWithFormat:@"get%@", Key];
    if ([self respondsToSelector:NSSelectorFromString(getKey)]) {
        return [self performSelector:NSSelectorFromString(getKey) withObject:nil];
    }

    //需要注意这里是小写key
    NSString* aKey = [NSString stringWithFormat:@"%@", key];
    if ([self respondsToSelector:NSSelectorFromString(aKey)]) {
        return [self performSelector:NSSelectorFromString(aKey) withObject:nil];
    }

    if (![self.class accessInstanceVariablesDirectly]) {
        NSException* exception = [NSException exceptionWithName:@"NSUnkonwnKeyException" reason:@"valueForUndefinedKey:" userInfo:nil];
        @throw exception;
    }

    /// 再找相关变量
    /// 获取所以成员变量
    unsigned int count = 0;
    Ivar* ivars = class_copyIvarList([self class], &count);

    NSMutableArray* arr = [[NSMutableArray alloc] init];

    for (int i = 0; i < count; i++) {
        Ivar var = ivars[i];
        const char* varName = ivar_getName(var);
        NSString* name = [NSString stringWithUTF8String:varName];
        [arr addObject:name];
    }

    // _<key> _is<Key> <key> is<Key>
    for (int i = 0; i < count; i++) {
        NSString* keyName = arr[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"_%@", key]]) {
            object_getIvar(self, ivars[i]);
            free(ivars);
            break;
        }
    }

    for (int i = 0; i < count; i++) {
        NSString* keyName = arr[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"_is%@", Key]]) {
            object_getIvar(self, ivars[i]);
            free(ivars);
            break;
        }
    }

    for (int i = 0; i < count; i++) {
        NSString* keyName = arr[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"%@", key]]) {
            object_getIvar(self, ivars[i]);
            free(ivars);
            break;
        }
    }

    for (int i = 0; i < count; i++) {
        NSString* keyName = arr[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"is%@", Key]]) {
            object_getIvar(self, ivars[i]);
            free(ivars);
            break;
        }
    }
    [self valueForUndefinedKey:key];
    free(ivars);
    return nil;
}

@end
```

#### 3.3  KVC之集合运算符
简单集合操作符:
```
@count:返回一个值为集合中对象总数的NSNumber对象。
@sum:首先把集合中的每个对象都转换为double类型，然后计算其总，最后返回一个值为这个总和的NSNumber对象。
@avg:首先把集合中的每个对象都转换为double类型，然后计算其平均值，最后返回一个值为该平均值的NSNumber对象。
@max:使用compare:方法来确定最大值。所以为了让其正常工作，集合中所有的对象都必须支持和另一个对象的比较。
@min:和@max一样，但是返回的是集合中的最小值。
```

## 学习:
Apple
* [KVC官方文档](https://link.jianshu.com/?t=https%3A%2F%2Fdeveloper.apple.com%2Flibrary%2Fcontent%2Fdocumentation%2FCocoa%2FConceptual%2FKeyValueCoding%2FSearchImplementation.html%23%2F%2Fapple_ref%2Fdoc%2Fuid%2F20000955-CJBBBFFA)

blog
* [iOS开发技巧系列---详解KVC(我告诉你KVC的一切)](https://www.jianshu.com/p/45cbd324ea65)
* [KVC原理剖析](https://www.jianshu.com/p/1d39bc610a5b)
* [KVC之使用Collection Operators(集合运算符)](https://www.jianshu.com/p/8f702ff8ff66)
