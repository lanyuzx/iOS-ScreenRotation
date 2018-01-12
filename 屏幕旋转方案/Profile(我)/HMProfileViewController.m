//
//  HMProfileViewController.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMProfileViewController.h"

@interface HMProfileViewController ()

@end

@implementation HMProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * lable = [UILabel new];
    lable.font = [UIFont systemFontOfSize:18];
    lable.textColor = [UIColor redColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"该页面我强制右横屏 进入就会横屏";
    lable.numberOfLines = 0;
    [self.view addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.right.equalTo(self.view);
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AppDelegate * delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    delegate.rotateOrientation = UIInterfaceOrientationMaskLandscapeRight ;
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIDeviceOrientationLandscapeRight];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    AppDelegate * delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    delegate.rotateOrientation = UIInterfaceOrientationMaskPortrait ;
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationMaskPortrait];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

//-(BOOL)shouldAutorotate{
//    return false;
//}
////支持的方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskLandscapeRight;
//}

@end
