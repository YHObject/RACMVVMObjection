//
//  BaseViewController.m
//  YHRACMVVM
//
//  Created by yyh on 2018/5/7.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "YHBaseViewController.h"

@interface YHBaseViewController ()

@property (nonatomic, strong, readwrite) YHBaseViewModel *viewModel;

@end

@implementation YHBaseViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.viewModel.willDisappearSignal sendNext:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.viewModel.willAppearSignal sendNext:nil];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    YHBaseViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    [[viewController
      rac_signalForSelector:@selector(viewDidLoad)]
     subscribeNext:^(id x) {
         @strongify(viewController)
         [viewController bindViewModel];
     }];
    
    return viewController;
}

- (void)bindViewModel
{
    RAC(self, title) = RACObserve(self.viewModel, title);
    
    [[self.viewModel.errors takeUntil:self.rac_willDeallocSignal] subscribeNext:^(RACTuple *loadingTuple) {
        NSInteger status = [loadingTuple.first integerValue];
        switch (status) {
            case YHTipType_Error:
                [MBProgressHUD showFailureMessage:loadingTuple.second];
                break;
            case YHTipType_Finish:
                [MBProgressHUD showSuccessMessage:loadingTuple.second];
                break;
                
            default:
                [MBProgressHUD hideHUD];
                break;
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithViewModel:(id)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
