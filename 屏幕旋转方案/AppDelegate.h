//
//  AppDelegate.h
//  屏幕旋转方案
//
//  Created by 周尊贤 on 2017/12/28.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 屏幕旋转方向
 */
@property (nonatomic,assign) UIInterfaceOrientationMask  rotateOrientation;
@end

