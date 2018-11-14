//
//  GameModel.h
//  ListenToNBA
//
//  Created by 罗德良 on 2018/10/19.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import "BaseModel.h"
//leancloud
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


//聚合数据
//"reason":"查询成功",
//"result":{
//    "title":"NBA赛事",
//    "statuslist":Object{...},
//    "list":[
//            {
//                "title":"11-09 周五",
//                "tr":[
//                      {
//                          "time":"11-09 09:00",
//                          "player1":"火箭",
//                          "player2":"雷霆",
//                          "player1logo":"https://mat1.gtimg.com/sports/nba/logo/1602/10.png",
//                          "player2logo":"https://mat1.gtimg.com/sports/nba/logo/1602/25.png",
//                          "player1logobig":"https://mat1.gtimg.com/sports/nba/logo/1602/10.png",
//                          "player2logobig":"https://mat1.gtimg.com/sports/nba/logo/1602/25.png",
//                          "player1url":"",
//                          "player2url":"",
//                          "link1url":"",
//                          "link2url":"",
//                          "m_link1url":"http://v.qq.com/cover/w/waobu7iciui2r8f.html",
//                          "link2text":"技术统计",
//                          "m_link2url":"http://v.qq.com/cover/w/waobu7iciui2r8f.html",
//                          "status":"2",
//                          "score":"80:98",
//                          "link1text":"视频集锦"
//                      },

@interface GameModel : BaseModel
//@property (nonatomic,copy) NSString *awayTeamName;
//@property (nonatomic,copy) NSString *homeTeamName;
//@property (nonatomic,copy) NSString *commentator;
//@property (nonatomic,copy) NSString *liveUrl;
//@property (nonatomic,assign) NSInteger status;//0 未开始 1 正在进行 2 比赛结束
//@property (nonatomic,copy) NSString *time;
//@property (nonatomic,copy) NSString *type;


@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *player1;
@property (nonatomic,copy) NSString *player2;
@property (nonatomic,copy) NSString *score;
@property (nonatomic,copy) NSString *status;

@end
