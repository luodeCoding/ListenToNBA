//
//  GameModel.h
//  ListenToNBA
//
//  Created by 罗德良 on 2018/10/19.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import "BaseModel.h"
//response: {
//    results =     (
//                   {
//                       awayTeamName = "\U706b\U7bad";
//                       commentator = "\U738b\U731b-\U67ef\U51e1";
//                       createdAt = "2018-10-19T05:29:16.494Z";
//                       homeTeamName = "\U6e56\U4eba";
//                       liveUrl = "http://4784.liveplay.myqcloud.com/live/4784_2635875b0_14b343fd3084efcc649f.m3u8";
//                       objectId = 5bc96bac0b6160006a126d66;
//                       status = 0;
//                       time = "2018-10-21 10:30";
//                       type = "\U5e38\U89c4\U8d5b";
//                       updatedAt = "2018-10-19T05:33:53.035Z";
//                   },
//                   );
//}
@interface GameModel : BaseModel
@property (nonatomic,copy) NSString *awayTeamName;
@property (nonatomic,copy) NSString *homeTeamName;
@property (nonatomic,copy) NSString *commentator;
@property (nonatomic,copy) NSString *liveUrl;
@property (nonatomic,assign) NSInteger status;//0 未开始 1 正在进行 2 比赛结束
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *type;

@end
