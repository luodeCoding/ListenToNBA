//
//  GameTableViewCell.m
//  ListenToNBA
//
//  Created by 罗德良 on 2018/10/19.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import "GameTableViewCell.h"

@interface GameTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *awayTeamImageView;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamPoint;

@property (weak, nonatomic) IBOutlet UIImageView *homeTeamImageView;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamPoint;

@property (weak, nonatomic) IBOutlet UIButton *gameTypeBtn;


@property (weak, nonatomic) IBOutlet UILabel *gameStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *cellBackView;

@end

@implementation GameTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.cellBackView roundCornerRadius:10];
    self.backgroundColor = [UIColor clearColor];
}

- (void)initData:(AVObject *)game {
    _awayTeamNameLabel.text = game[@"awayTeamName"];
    _homeTeamNameLabel.text = game[@"homeTeamName"];
    _awayTeamPoint.text = game[@"awayTeamPoint"];
    _homeTeamPoint.text = game[@"homeTeamPoint"];
    _awayTeamImageView.image = [UIImage imageNamed:game[@"awayTeamName"]];
    _homeTeamImageView.image = [UIImage imageNamed:game[@"homeTeamName"]];
    [_gameTypeBtn setTitle:game[@"type"] forState:UIControlStateNormal];
    _gameTimeLabel.text = game[@"time"];
    
    if ([game[@"awayTeamPoint"] integerValue] == [game[@"homeTeamPoint"] integerValue]) {
        _awayTeamPoint.textColor = [UIColor colorWithHex:0xA9A9A9];
        _homeTeamPoint.textColor = [UIColor colorWithHex:0xA9A9A9];
    }else if ([game[@"awayTeamPoint"] integerValue] > [game[@"homeTeamPoint"] integerValue]) {
        _awayTeamPoint.textColor = [UIColor colorWithHex:0xFF7E79];
        _homeTeamPoint.textColor = [UIColor colorWithHex:0xA9A9A9];
    }else {
        _awayTeamPoint.textColor = [UIColor colorWithHex:0xA9A9A9];
        _homeTeamPoint.textColor = [UIColor colorWithHex:0xFF7E79];
    }
    
    switch ([game[@"status"] integerValue]) {
        case 0:
            _gameStatusLabel.text = @"未开始";
            break;
        case 1:
            _gameStatusLabel.text = @"正在进行";
            break;
        case 2:
            _gameStatusLabel.text = @"比赛结束";
            break;
        default:
            break;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
