# RACMVVMObjection
App框架 RAC+MVVM+Objection（路由）

1.项目初始化配置

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

2.路由配置

（1）注入类
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
（2）初始化及传值
- (id)provide:(JSObjectionInjector *)context arguments:(NSArray *)arguments
{
    SEL selector = NSSelectorFromString(@"initWithServices:params:");
    if ([_classObject instancesRespondToSelector:selector]) {
        id service = [context getObject:@protocol(YHViewModelServicesProtocol)];
        return ((id (*)(id,SEL,id,id))objc_msgSend)([_classObject alloc],selector,service,arguments.firstObject);
    }
    
    return nil;
}
（3）路由跳转
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
