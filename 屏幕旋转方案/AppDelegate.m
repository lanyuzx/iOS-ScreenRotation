//
//  AppDelegate.m
//  屏幕旋转方案
//
//  Created by 周尊贤 on 2017/12/28.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "AppDelegate.h"
#import "HMMainViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [HMMainViewController new];
    [self.window makeKeyAndVisible];
    return YES;
}

-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    switch (self.rotateOrientation) {
        case UIInterfaceOrientationMaskPortrait:
            return UIInterfaceOrientationMaskPortrait;
            break;
        case UIInterfaceOrientationMaskLandscapeLeft:
            return UIInterfaceOrientationMaskLandscapeLeft;
            break;
        case UIInterfaceOrientationMaskLandscapeRight:
            return UIInterfaceOrientationMaskLandscapeRight;
            break;
        case UIInterfaceOrientationMaskAllButUpsideDown:
            return UIInterfaceOrientationMaskAllButUpsideDown;
            break;
        case UIInterfaceOrientationMaskAll:
            return UIInterfaceOrientationMaskAll;
            break;
         default:
              return UIInterfaceOrientationMaskPortrait;
            break;
    }

}



@end
