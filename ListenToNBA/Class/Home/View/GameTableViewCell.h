//
//  GameTableViewCell.h
//  ListenToNBA
//
//  Created by 罗德良 on 2018/10/19.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameModel.h"
@interface GameTableViewCell : UITableViewCell

- (void)initHomeDataWithGameModel:(GameModel *)game;
- (void)initDataWithGameModel:(GameModel *)game;
@end
