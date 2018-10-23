//
//  WebViewController.m
//  ListenToNBA
//
//  Created by 罗德良 on 2018/10/22.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NBA新闻";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigator_btn_back" highIcon:@"" target:self action:@selector(backEvent)];    
    self.webView.mediaPlaybackRequiresUserAction = NO;
    self.webView.allowsInlineMediaPlayback = YES;
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]];
    [self.webView loadRequest:request];
}

- (void)backEvent {
    [self dismissViewControllerAnimated:YES completion:nil];
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
