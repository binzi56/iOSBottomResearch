# Runtime

### 一、目录
1. 初识Runtime
2. 了解OC相关类
3. OC底层调用
4. Runtime实际应用

### 二、内容缩略图
具体内容请查看Runtime.xmind；
![Runtime缩略图](https://upload-images.jianshu.io/upload_images/1893416-8a26ae3b61d58632.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


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
#### 3.2 Runtime执行过程相关函数
```
IMP lookUpImpOrForward(Class cls, SEL sel, id inst,
bool initialize, bool cache, bool resolver)
{
IMP imp = nil;
bool triedResolver = NO;

runtimeLock.assertUnlocked();

// Optimistic cache lookup
if (cache) {
imp = cache_getImp(cls, sel);
if (imp) return imp;
}

// runtimeLock is held during isRealized and isInitialized checking
// to prevent races against concurrent realization.

// runtimeLock is held during method search to make
// method-lookup + cache-fill atomic with respect to method addition.
// Otherwise, a category could be added but ignored indefinitely because
// the cache was re-filled with the old value after the cache flush on
// behalf of the category.

runtimeLock.read();

if (!cls->isRealized()) {
// Drop the read-lock and acquire the write-lock.
// realizeClass() checks isRealized() again to prevent
// a race while the lock is down.
runtimeLock.unlockRead();
runtimeLock.write();

realizeClass(cls);

runtimeLock.unlockWrite();
runtimeLock.read();
}

if (initialize  &&  !cls->isInitialized()) {
runtimeLock.unlockRead();
_class_initialize (_class_getNonMetaClass(cls, inst));
runtimeLock.read();
// If sel == initialize, _class_initialize will send +initialize and
// then the messenger will send +initialize again after this
// procedure finishes. Of course, if this is not being called
// from the messenger then it won't happen. 2778172
}


retry:    
runtimeLock.assertReading();

// Try this class's cache.

imp = cache_getImp(cls, sel);
if (imp) goto done;

// Try this class's method lists.
{
Method meth = getMethodNoSuper_nolock(cls, sel);
if (meth) {
log_and_fill_cache(cls, meth->imp, sel, inst, cls);
imp = meth->imp;
goto done;
}
}

// Try superclass caches and method lists.
{
unsigned attempts = unreasonableClassCount();
for (Class curClass = cls->superclass;
curClass != nil;
curClass = curClass->superclass)
{
// Halt if there is a cycle in the superclass chain.
if (--attempts == 0) {
_objc_fatal("Memory corruption in class list.");
}

// Superclass cache.
imp = cache_getImp(curClass, sel);
if (imp) {
if (imp != (IMP)_objc_msgForward_impcache) {
// Found the method in a superclass. Cache it in this class.
log_and_fill_cache(cls, imp, sel, inst, curClass);
goto done;
}
else {
// Found a forward:: entry in a superclass.
// Stop searching, but don't cache yet; call method
// resolver for this class first.
break;
}
}

// Superclass method list.
Method meth = getMethodNoSuper_nolock(curClass, sel);
if (meth) {
log_and_fill_cache(cls, meth->imp, sel, inst, curClass);
imp = meth->imp;
goto done;
}
}
}


// No implementation found. Try method resolver once.

if (resolver  &&  !triedResolver) {
runtimeLock.unlockRead();
_class_resolveMethod(cls, sel, inst);
runtimeLock.read();
// Don't cache the result; we don't hold the lock so it may have
// changed already. Re-do the search from scratch instead.
triedResolver = YES;
goto retry;
}

// No implementation found, and method resolver didn't help.
// Use forwarding.

imp = (IMP)_objc_msgForward_impcache;
cache_fill(cls, sel, imp, inst);

done:
runtimeLock.unlockRead();

return imp;
}

```


## 学习:
* [iOS 模块分解—「Runtime面试、工作」看我就 🐒 了 ^_^.](https://www.jianshu.com/p/19f280afcb24)
* [Objective-C Runtime 1小时入门教程](https://www.ianisme.com/ios/2019.html)
