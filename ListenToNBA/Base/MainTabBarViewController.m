//
//  MainTabBarViewController.m
//  ListenToNBA
//
//  Created by 罗德良 on 2018/11/14.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "HomeViewController.h"
#import "TeamVersusViewController.h"
#import "BaseNavgationViewController.h"
@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeViewController * home = [[HomeViewController alloc]init];
    TeamVersusViewController * teamVersus = [[TeamVersusViewController alloc]init];
    BaseNavgationViewController * nav = [[BaseNavgationViewController alloc]initWithRootViewController:teamVersus];
    
    
    self.tabBar.tintColor = kTintColor;
    self.tabBarItemsAttributes = [self creatTabBarItemsAttributes];
    self.viewControllers = @[home,nav];
}


- (NSArray *)creatTabBarItemsAttributes {
    NSDictionary * dic = @{
                           CYLTabBarItemTitle:@"赛事",
                           CYLTabBarItemImage:@"NBA",
                           CYLTabBarItemSelectedImage:@"NBA_sel"
                           };
    NSDictionary * dic2 = @{
                            CYLTabBarItemTitle:@"球队",
                            CYLTabBarItemImage:@"team",
                            CYLTabBarItemSelectedImage:@"team_sel"
                            };
    NSArray * tarBarItemsAttrbutes = @[dic, dic2];
    return tarBarItemsAttrbutes;
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
