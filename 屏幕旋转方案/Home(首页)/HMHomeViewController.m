//
//  HMHomeViewController.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMHomeViewController.h"




@interface HMHomeViewController ()

@end

@implementation HMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * lable = [UILabel new];
    lable.font = [UIFont systemFontOfSize:18];
    lable.textColor = [UIColor redColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"跟随系统旋转 嗒嗒嗒嗒开启  请用真机测试";
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
    delegate.rotateOrientation = UIInterfaceOrientationMaskAll ;
}


@end
