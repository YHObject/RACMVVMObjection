# RACMVVMObjection
App框架 RAC+MVVM+Objection（路由）

**1.项目初始化配置**
```Objective-C
+(void)load{
    [JSObjection setDefaultInjector:[JSObjection createInjector:[[AppModule alloc]init]]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.services = [self yh_getObjection:@protocol(YHViewModelServicesProtocol)];
    self.navigationControllerStack = [[YHNavigationControllerStack alloc] initWithServices:self.services];
    [self.services resetRootTo:Router_Weather];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}
```

**2.路由配置**

>（1）注入类
```Objective-C
- (void)configure
{
    [self bindBlock:^id(JSObjectionInjector *context) {
        return [[YHViewModelServicesImpl alloc] init];
    } toProtocol:@protocol(YHViewModelServicesProtocol) inScope:JSObjectionScopeSingleton];
    
    
    [self bindProvider:[[YHViewModelProvider alloc] initWithClass:YHWeatherViewModel.self] toClass:[YHWeatherViewModel class] inScope:JSObjectionScopeNormal];
    [self bindClass:[YHWeatherViewController class] toClass:[YHWeatherViewModel class] named:Router_Weather];
    
    [self bindProvider:[[YHViewModelProvider alloc] initWithClass:YHWeatherDetailViewModel.self] toClass:[YHWeatherDetailViewModel class]];
    [self bindClass:[YHWeatherDetailViewController class] toClass:[YHWeatherDetailViewModel class] named:Router_WeatherDetail];
}
```
>（2）viewModel初始化及传值，需要遵守JSObjectionProvider协议
```Objective-C
- (id)provide:(JSObjectionInjector *)context arguments:(NSArray *)arguments
{
    SEL selector = NSSelectorFromString(@"initWithServices:params:");
    if ([_classObject instancesRespondToSelector:selector]) {
        id service = [context getObject:@protocol(YHViewModelServicesProtocol)];
        return ((id (*)(id,SEL,id,id))objc_msgSend)([_classObject alloc],selector,service,arguments.firstObject);
    }
    
    return nil;
}
```

>（3）vc初始化，取出之前注入的viewModel把它赋值到vc中，方便监听拿值
```Objective-C
- (YHBaseViewController *)viewControllerForViewModel:(NSString *)route params:(NSDictionary *)params{
    
    if (!params) {
        params = @{};
    }
    
    YHBaseViewModel *baseViewModel = [self yh_getObjection:[NSClassFromString(route) class] argumentList:@[params]];
    //从路由中取出VC
    YHBaseViewController *viewController = (YHBaseViewController *)[self yh_getObjection:[baseViewModel class] name:route];
    
    SEL selector = NSSelectorFromString(@"initWithViewModel:");
    if ([[viewController class] instancesRespondToSelector:selector]) {
        
        Class VC = [viewController class];
        NSParameterAssert([VC isSubclassOfClass:[YHBaseViewController class]]);
        NSParameterAssert([VC instancesRespondToSelector:@selector(initWithViewModel:)]);
        viewController = ((id (*)(id,SEL,id))objc_msgSend)([VC  alloc],selector,baseViewModel);
        return viewController;
    }
    
    return nil;
}
```

**3.路由跳转**

```Objective-C
typedef void (^VoidBlock)(void);

@protocol YHNavigationProtocol <NSObject>

/**
 *  push 到新的页面VC
 *
 *  @param route
 *  @param params
 *  @param animated
 */
- (void)pushViewTo:(NSString *)route params:(NSDictionary *)params animated:(BOOL)animated;

/**
 *  返回到上层VC
 *
 *  @param animated
 */
- (void)popViewTo:(BOOL)animated;

/**
 *  返回到根控制器VC
 *
 *  @param animated
 */
- (void)popToRootViewTo:(BOOL)animated;

/**
 *  展示从下到上pop一个视图（模态）VC
 *
 *  @param route
 *  @param params
 *  @param animated
 *  @param completion
 */
- (void)presentViewTo:(NSString *)route params:(NSDictionary *)params animated:(BOOL)animated completion:(VoidBlock)completion;

/**
 *  关闭一个模态视图VC
 *
 *  @param animated
 *  @param completion
 */
- (void)dismissViewTo:(BOOL)animated completion:(VoidBlock)completion;

/**
 *  keywindow的根控制器VC
 *
 *  @param route
 *  @param animated
 */
- (void)resetRootTo:(NSString *)route;
```
> 跳转实例：
```Objective-C
- (RACCommand *)didSelectCommand
{
    @weakify(self);
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPatht) {
        
        @strongify(self);
        [self.services pushViewTo:Router_WeatherDetail params:@{@"detailModel":self.dataSource[indexPatht.section][indexPatht.row]} animated:YES];
        return [RACSignal empty];
    }];
}
```

**4.网络层**
```Objective-C
+ (RACSignal *)excuteWithParams:(id)params formModelClass:(Class)modelClass
{
    YHBasicServices *basicServices = [[YHBasicServices alloc] init];
    
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[YHWorkingManager shareManager] sendGETDataWithPath:@"http://mobile.weather.com.cn/data/news/khdjson.htm?_=1381891660018" withParamters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [MBProgressHUD hideHUD];
            NSError *error;
            basicServices.model = [[modelClass alloc] initWithDictionary:responseObject error:&error];
            
            [subscriber sendNext:basicServices.model];
            [subscriber sendCompleted];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }] setNameWithFormat:@"API - Signal - %@",NSStringFromClass(modelClass)] ;
}
```
