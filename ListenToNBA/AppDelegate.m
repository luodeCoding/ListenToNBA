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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSThread sleepForTimeInterval:1];    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self configLeanCloudKey];
    [self supportBackGroundPlayAudio];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    HomeViewController * home = [[HomeViewController alloc]init];
    self.window.rootViewController = home;
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

- (void)creatLockScreenFace {
    
    Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
    //获取正在收听直播信息
//    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    if (playingInfoCenter) {
        NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
        UIImage *image = [UIImage imageNamed:@"nabLogo"];
        
        MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:image];
        //球队名称
        [songInfo setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"teamName"] forKey:MPMediaItemPropertyTitle];
        //解说员
        [songInfo setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"commentatorName"] forKey:MPMediaItemPropertyArtist];
        //专辑名
        //        [songInfo setObject:@"苏群" forKey:MPMediaItemPropertyAlbumTitle];
        //专辑缩略图
        [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
        //        [songInfo setObject:[NSNumber numberWithDouble:[audioY getCurrentAudioTime]] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime]; //音乐当前已经播放时间
        //        [songInfo setObject:[NSNumber numberWithFloat:1.0] forKey:MPNowPlayingInfoPropertyPlaybackRate];//进度光标的速度 （这个随 自己的播放速率调整，我默认是原速播放）
        //        [songInfo setObject:[NSNumber numberWithDouble:[audioY getAudioDuration]] forKey:MPMediaItemPropertyPlaybackDuration];//歌曲总时间设置
        
        //        设置锁屏状态下屏幕显示音乐信息
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
    }
}

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
