//
//  HMDiscoverViewController.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMDiscoverViewController.h"


@interface HMDiscoverViewController ()

@end

@implementation HMDiscoverViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * lable = [UILabel new];
    lable.font = [UIFont systemFontOfSize:18];
    lable.textColor = [UIColor redColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"该页面点击后进行旋转 ,请点击 默认指定左旋转";
    lable.userInteractionEnabled = true;
    [lable addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lableClick)]];
    lable.numberOfLines = 0;
    [self.view addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.right.equalTo(self.view);
    }];
    AppDelegate * delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    delegate.rotateOrientation = UIInterfaceOrientationMaskAll ;
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AppDelegate * delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    delegate.rotateOrientation = UIInterfaceOrientationMaskAll ;
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

-(void)lableClick {

    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}





@end
