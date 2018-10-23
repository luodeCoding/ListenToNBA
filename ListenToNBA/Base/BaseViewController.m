//
//  BaseViewController.m
//  Meet
//
//  Created by 罗德良 on 2018/10/15.
//  Copyright © 2018年 luode. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
///右滑返回功能，默认开启（YES）
- (BOOL)gestureRecognizerShouldBegin{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }else{
        if([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
        {
            self.automaticallyAdjustsScrollViewInsets=NO;
        }
    }
}


- (void)showHUDToViewMessage:(NSString *)msg{
    if (!self.hud) {
        self.hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.dimBackground = YES;
        if (msg==nil||[msg isEqualToString:@""]) {
            
        }else{
            self.hud.labelText= msg;
        }
    }
}
- (void)showHUDToWindowMessage:(NSString *)msg{
    if (!self.hud) {
        self.hud=[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        self.hud.dimBackground = YES;
        if (msg==nil||[msg isEqualToString:@""]) {
            
        }else{
            self.hud.labelText= msg;
        }
    }
}

- (void)removeHUD{
    if (self.hud) {
        [self.hud removeFromSuperview];
        self.hud=nil;
    }
}
-(NSString *)backItemImageName{
    return @"navigator_btn_back";
}
//- (BOOL)shouldAutorotate{
//    //是否允许转屏
//    BOOL result = [super shouldAutorotate];
//    return result;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    UIInterfaceOrientationMask result = [super supportedInterfaceOrientations];
//    //viewController所支持的全部旋转方向
//    return result;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    UIInterfaceOrientation result = [super preferredInterfaceOrientationForPresentation];
//    //viewController初始显示的方向
//    return result;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
@end
