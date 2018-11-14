//
//  TeamVersusGameListViewController.m
//  ListenToNBA
//
//  Created by 罗德良 on 2018/11/14.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import "TeamVersusGameListViewController.h"
#import "GameTableViewCell.h"
#import "GameModel.h"
@interface TeamVersusGameListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *juheGameList;
@end

@implementation TeamVersusGameListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeUI];
    [self requestTeamGameList];
}

#pragma mark - UI

- (void)initializeUI {
    self.title = self.teamName;
    [self configTableview];
}

- (void)configTableview {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"GameTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

}

#pragma mark - Event




#pragma mark - Network
- (void)requestTeamGameList {
    weakSelf(weakSelf);
    [self showHUDToViewMessage:nil];
    [PPNetworkHelper GET:@"http://op.juhe.cn/onebox/basketball/team?key=537f7b3121a797c8d18f4c0523f3c124" parameters:@{@"team":self.teamName} success:^(id responseObject) {
        [weakSelf removeHUD];
        if (responseObject[@"error_code"] == 0) {
            weakSelf.juheGameList = [GameModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
            [weakSelf.tableView reloadData];
        }else {
            [MBProgressHUD alertHUDShowIn:self.view message:responseObject[@"reason"] hidenAfter:1 mode:MBProgressHUDModeText];
        }
    } failure:^(NSError *error) {
        NSLog(@"fff");
    }];
    
}

#pragma mark - Delegate

//tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.juheGameList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GameModel * model = _juheGameList[indexPath.row];
    [cell initDataWithGameModel:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}


#pragma mark -- 懒加载

- (NSArray *)juheGameList {
    if (!_juheGameList) {
        NSArray * array = [NSArray array];
        _juheGameList = array;
    }
    return _juheGameList;
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
