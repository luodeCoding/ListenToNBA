//
//  WidgetGameTableViewCell.h
//  LearnWidget
//
//  Created by 罗德良 on 2018/11/13.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WidgetGameTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *awayTeamImageView;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;


@property (weak, nonatomic) IBOutlet UIImageView *homeTeamImageView;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamNameLabel;
@end
