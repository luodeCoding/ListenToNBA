//
//  AppDelegate.m
//  ListenToNBA
//
//  Created by 罗德良 on 2018/10/17.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <AVOSCloud/AVOSCloud.h>
#import <MediaPlayer/MediaPlayer.h>
#import "HomeViewController.h"
#import "BaseNavgationViewController.h"
#import "MainTabBarViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSThread sleepForTimeInterval:1];    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self configLeanCloudKey];
    [self supportBackGroundPlayAudio];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    MainTabBarViewController * main = [[MainTabBarViewController alloc]init];
    
//    HomeViewController * home = [[HomeViewController alloc]init];
    self.window.rootViewController = main;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)configLeanCloudKey {
    [AVOSCloud setApplicationId:@"O2M4llAi704p31zgSWsXsFgy-gzGzoHsz" clientKey:@"si504m4WEH1C7dxYxhXwtU7b"];
}

-(void)supportBackGroundPlayAudio {
    // 告诉app支持后台播放
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

//APPSchemes 交互
// iOS 9+
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
//    // [url.absoluteString hasPrefix:@"iMyApp://"]
//    if ([url.host isEqualToString:@"iMyApp"]) {
//        // 操作
//        return YES;
//    }
//    return YES;
//}
//// iOS 7、iOS 8
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    // [url.absoluteString hasPrefix:@"iMyApp://"]
//    if ([url.host isEqualToString:@"iMyApp"]) {
//        // 操作
//        return YES;
//    }
//    return YES;
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
