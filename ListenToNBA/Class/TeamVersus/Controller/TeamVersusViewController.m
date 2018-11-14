//
//  TeamVersusViewController.m
//  ListenToNBA
//
//  Created by 罗德良 on 2018/11/14.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import "TeamVersusViewController.h"
#import "TeamVersusCollectionViewCell.h"
#import "TeamVersusGameListViewController.h"

@interface TeamVersusViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray * teamArray;

@end

@implementation TeamVersusViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"球队";
    [self initializeUI];
}

#pragma mark - UI
- (void)initializeUI {
    self.teamArray = @[@"湖人",@"火箭",@"勇士",@"快船",@"太阳",@"鹈鹕",@"马刺",@"雷霆",@"独行侠",@"掘金",@"国王",@"开拓者",@"爵士",@"森林狼",@"灰熊",@"凯尔特人",@"76人",@"猛龙",@"魔术",@"活塞",@"黄蜂",@"老鹰",@"篮网",@"公牛",@"步行者",@"雄鹿",@"热火",@"骑士",@"奇才",@"尼克斯"];
    [self configCollectionView];
}

#pragma mark -- initCollectionview
- (void)configCollectionView {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((kScreenWidth-26)/5, (kScreenWidth-26)/5);
    self.collectionView.backgroundColor = [UIColor colorWithHex:0xeeeeee];
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"TeamVersusCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
}


#pragma mark - Event


#pragma mark - Network


#pragma mark - Delegate
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TeamVersusCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell roundCornerRadius:cell.frame.size.height/2];
    cell.teamImageView.image = [UIImage imageNamed:self.teamArray[indexPath.row]];
    return cell;
}

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.teamArray.count;
}

//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10;
}
//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TeamVersusGameListViewController * gameListVC = [[TeamVersusGameListViewController alloc]init];
    gameListVC.teamName = _teamArray[indexPath.row];
    [self.navigationController pushViewController:gameListVC animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - 懒加载
- (NSArray *)teamArray {
    if (!_teamArray) {
        NSArray * array = [NSArray array];
        _teamArray = array;
    }
    return _teamArray;
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
