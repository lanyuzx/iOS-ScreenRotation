//
//  HMMessageViewController.m
//  Weibo11
//
//  Created by 刘凡 on 15/12/5.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "HMMessageViewController.h"


@interface HMMessageViewController ()

@end

@implementation HMMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * lable = [UILabel new];
    lable.font = [UIFont systemFontOfSize:18];
    lable.textColor = [UIColor redColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"该页面我不让跟着旋转 哒哒哒  你想怎么转都不听话 不信你试试";
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
    delegate.rotateOrientation = UIInterfaceOrientationMaskPortrait ;
    
}


@end
