//
//  GameModel.m
//  ListenToNBA
//
//  Created by 罗德良 on 2018/10/19.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import "GameModel.h"




@implementation GameModel
MJExtensionCodingImplementation

- (NSString *)commentator {
    if (_commentator) {
        return _commentator;
    }
    return @"未知";
}

- (NSString *)liveUrl {
    if (_liveUrl) {
        return _liveUrl;
    }
    return @"no";
}

@end
