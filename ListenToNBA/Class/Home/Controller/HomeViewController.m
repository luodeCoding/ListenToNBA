//
//  HomeViewController.m
//  ListenToNBA
//
//  Created by 罗德良 on 2018/10/19.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import "HomeViewController.h"
#import "GameTableViewCell.h"
#import "LiveViewController.h"
#import "WebViewController.h"
#import "HW3DBannerView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "BaseNavgationViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (nonatomic,strong) HW3DBannerView *bannerView;
@property (nonatomic,strong) NSArray *gameList;
@property (nonatomic,strong) NSMutableArray *newsUrlList;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];    
    [self initializeUI];
    [self requestLiveTeamList];
    [self requestBannerList];
}

#pragma mark - UI

- (void)initializeUI {
    [self configTableview];
    [self initBannerView];
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
    weakSelf(weakSelf);
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestLiveTeamList];
        [weakSelf requestBannerList];
    }];
    header.stateLabel.textColor = kTintColor;
    header.lastUpdatedTimeLabel.textColor = kTintColor;
    [header setTitle:HeadTitleWithStateIdle forState:MJRefreshStateIdle];
    [header setTitle:HeadTitleWithStatePulling forState:MJRefreshStatePulling];
    [header setTitle:HeadTitleWithStateRefreshing forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
}

#pragma mark -- 初始化滚动图
- (void)initBannerView {
    self.bannerView = [HW3DBannerView initWithFrame:CGRectMake(0, 0, kScreenWidth, 260) imageSpacing:10 imageWidth:kScreenWidth];
    self.bannerView.initAlpha = 1;
    self.bannerView.imageRadius = 1;
    self.bannerView.imageHeightPoor = 0;
    self.bannerView.placeHolderImage = [UIImage imageNamed:@"bannerBackImg"];
    weakSelf(weakSelf);
    self.bannerView.clickImageBlock = ^(NSInteger currentIndex) {
        WebViewController * webVC = [[WebViewController alloc]init];
        webVC.webUrl = weakSelf.newsUrlList[currentIndex];
        BaseNavgationViewController * nav = [[BaseNavgationViewController alloc]initWithRootViewController:webVC];
        [weakSelf presentViewController:nav animated:YES completion:nil];
    };
    [self.topView addSubview:self.bannerView];
}


//停止更新
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}


#pragma mark - Event

#pragma mark - Network

- (void)requestLiveTeamList {
    AVQuery *query = [AVQuery queryWithClassName:@"Game"];
    self.gameList = nil;
    self.gameList = [query findObjects];
    [self endRefresh];
    [self.tableView reloadData];
}

- (void)requestBannerList {
    AVQuery *bannerQuery = [AVQuery queryWithClassName:@"Banner"];
    NSArray * array = [bannerQuery findObjects];
    NSMutableArray * imageUrlArray = [NSMutableArray array];
    [self.newsUrlList removeAllObjects];
    for (AVObject * model in array) {
        [imageUrlArray addObject:model[@"imgUrl"]];
        [self.newsUrlList addObject:model[@"newsUrl"]];
    }
    self.bannerView.data = [imageUrlArray mutableCopy];
    NSLog(@"%@",self.bannerView.data);
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
    
    GameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AVObject * model = self.gameList[indexPath.row];
    [cell initData: model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AVObject * model = self.gameList[indexPath.row];
    
    
    switch ([model[@"status"] integerValue]) {
        case 0:
        [MBProgressHUD alertHUDShowIn:self.view message:@"比赛暂未开始" hidenAfter:0.8 mode:MBProgressHUDModeText];
            break;
        case 1:{
            if (![model[@"liveUrl"] isEqualToString:@"no"]){
                LiveViewController * live = [[LiveViewController alloc]init];
                live.liveTitle = [NSString stringWithFormat:@"%@ VS %@",model[@"awayTeamName"],model[@"homeTeamName"]];
                live.liveUrl = model[@"liveUrl"];
                [self creatLockScreenFaceWithTeamName:live.liveTitle commentatorName:model[@"commentator"]];
                [self presentViewController:live animated:YES completion:nil];
            }else {
                 [MBProgressHUD alertHUDShowIn:self.view message:@"比赛暂未开始" hidenAfter:0.8 mode:MBProgressHUDModeText];
            }
           
        }
            break;
        case 2:
        [MBProgressHUD alertHUDShowIn:self.view message:@"比赛已经结束" hidenAfter:0.8 mode:MBProgressHUDModeText];
            break;
        default:
            break;
    }
}

- (void)creatLockScreenFaceWithTeamName:(NSString *)teamName commentatorName:(NSString *)commentatorName {
    
    Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
    //获取正在收听直播信息
    //    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    if (playingInfoCenter) {
        NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
        UIImage *image = [UIImage imageNamed:@"nabLogo"];
        
        MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:image];
        //球队名称
        [songInfo setObject:teamName forKey:MPMediaItemPropertyTitle];
        //解说员
        [songInfo setObject:commentatorName forKey:MPMediaItemPropertyArtist];
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


#pragma mark -- 懒加载

- (NSArray *)gameList {
    if (!_gameList) {
        NSArray * array = [NSArray array];
        _gameList = array;
    }
    return _gameList;
}

- (NSMutableArray *)newsUrlList {
    if (!_newsUrlList) {
        NSMutableArray * array = [NSMutableArray array];
        _newsUrlList = array;
    }
    return _newsUrlList;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
