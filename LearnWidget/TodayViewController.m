//
//  TodayViewController.m
//  LearnWidget
//
//  Created by 罗德良 on 2018/11/12.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import "TodayViewController.h"
#import "WidgetGameTableViewCell.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *notifacationLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *gameList;
@end

@implementation TodayViewController

//是否需要折叠
- (void)viewWillAppear:(BOOL)animated { [super viewWillAppear:animated]; self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.preferredContentSize = CGSizeMake(kScreenWidth, 100);
    [self configTableview];
    _notifacationLabel.text = @"跳转至APP";
    _notifacationLabel.text = [NSString stringWithFormat:@"%ld",[self readDataFromNSUserDefaults].count];
    self.gameList = [self readDataFromNSUserDefaults];
}


#pragma mark - tableview

- (void)configTableview {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"WidgetGameTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

#pragma mark - Delegate

//tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.gameList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WidgetGameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary * dic = self.gameList[indexPath.row];
    cell.awayTeamNameLabel.text = dic[@"player1"];
    cell.homeTeamNameLabel.text = dic[@"player2"];
    cell.awayTeamImageView.image = [UIImage imageNamed:dic[@"player1"]];
    cell.homeTeamImageView.image = [UIImage imageNamed:dic[@"player2"]];
    cell.timeLabel.text = dic[@"time"];
    cell.scoreLabel.text = dic[@"score"];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}




#pragma mark - Event
- (IBAction)joinAppBtn:(UIButton *)sender {
    
    NSString *schemeString = @"listenNBA://";
    
    [self.extensionContext openURL:[NSURL URLWithString:schemeString] completionHandler:^(BOOL success) {
        
    }];
}

#pragma mark - 数据共享

//保存数据
//- (void)saveDataByNSUserDefaults{
//
//    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.c om.xxx"]; [shared setObject:@"asdfasdf" forKey:@"widget"]; [shared synchronize];
//}
//读取数据
//- (NSString *)readDataFromNSUserDefaults{
//
//    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.c om.xxx"]; NSString *value = [shared valueForKey:@"widget"]; return value;
//}


- (NSArray *)readDataFromNSUserDefaults{
    NSUserDefaults *myDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.listennba.appGroup"];
    return [myDefaults valueForKey:@"GameList"];
}

#pragma mark - NCWidgetProvidingDelegate
//折叠代理
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {

    if (activeDisplayMode == NCWidgetDisplayModeCompact) { self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 120); } else { self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 60 * self.gameList.count + 20); }
}

//缩进
//- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets: (UIEdgeInsets)defaultMarginInsets {
//    return UIEdgeInsetsZero;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
//    NSArray * array = [self readDataFromNSUserDefaults];
//    NSLog(@"得到了比赛数据%@",array);
    completionHandler(NCUpdateResultNewData);
}

@end
