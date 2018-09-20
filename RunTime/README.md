# Runtime

### 一、目录
1. 初识Runtime
2.了解OC相关类
3. OC底层调用
4. Runtime实际应用

### 二、内容缩略图


### 三、其他
#### 3.1 OC相关类的定义
类的定义：
```
typedef struct objc_class *Class;
struct objc_class {
 Class isa                                 OBJC_ISA_AVAILABILITY; // metaclass
#if !__OBJC2__
 Class super_class                         OBJC2_UNAVAILABLE; // 父类
 const char *name                          OBJC2_UNAVAILABLE; // 类名
 long version                              OBJC2_UNAVAILABLE; // 类的版本信息，默认为0，可以通过runtime函数class_setVersion或者class_getVersion进行修改、读取
 long info                                 OBJC2_UNAVAILABLE; // 类信息，供运行时期使用的一些位标识，如CLS_CLASS (0x1L) 表示该类为普通 class，其中包含实例方法和变量;CLS_META (0x2L) 表示该类为 metaclass，其中包含类方法;
 long instance_size                        OBJC2_UNAVAILABLE; // 该类的实例变量大小（包括从父类继承下来的实例变量）
 struct objc_ivar_list *ivars              OBJC2_UNAVAILABLE; // 该类的成员变量地址列表
 struct objc_method_list **methodLists     OBJC2_UNAVAILABLE; // 方法地址列表，与 info 的一些标志位有关，如CLS_CLASS (0x1L)，则存储实例方法，如CLS_META (0x2L)，则存储类方法;
 struct objc_cache *cache                  OBJC2_UNAVAILABLE; // 缓存最近使用的方法地址，用于提升效率；
 struct objc_protocol_list *protocols      OBJC2_UNAVAILABLE; // 存储该类声明遵守的协议的列表
#endif
}
/* Use `Class` instead of `struct objc_class *` */
```


## 学习:
[iOS 模块分解—「Runtime面试、工作」看我就 🐒 了 ^_^.](https://www.jianshu.com/p/19f280afcb24)
[Objective-C Runtime 1小时入门教程](https://www.ianisme.com/ios/2019.html)
