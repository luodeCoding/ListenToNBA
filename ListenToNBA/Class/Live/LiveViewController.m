//
//  LiveViewController.m
//  ListenToNBA
//
//  Created by 罗德良 on 2018/10/19.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import "LiveViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface LiveViewController (){
    PanDirection panDirection;
    CGFloat sumTime; // 用来保存快进的总时长
    BOOL isVolume; // 判断是否正在滑动音量
}
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, assign) CGPoint startPoint;

@property (nonatomic, strong) UISlider *slider;     //进度条
@property (nonatomic, strong) UILabel *currentTimeLab;      //当前播放时间
@property (nonatomic, strong) UILabel *systemTimeLab;       //系统时间
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIActivityIndicatorView *activity;    //菊花
@property (nonatomic, strong) UIProgressView *pro;  //缓冲条
@property (nonatomic, strong) UIProgressView *voicePro; //声音条
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UILabel *horizontalLabel; // 水平滑动时显示进度
@property (nonatomic, assign) NSTimeInterval *times;
@end

@implementation LiveViewController
#pragma mark - 横屏代码
- (BOOL)shouldAutorotate{
    return NO;
}
#pragma mark 旋转屏幕
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskLandscape;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}
- (BOOL)prefersStatusBarHidden
{
    return NO; // 返回NO表示要显示，返回YES将hiden
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    //1.创建Item，添加url
    _playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.liveUrl]];
    
    //2.创建player，添加Item
    _player = [AVPlayer playerWithPlayerItem:_playerItem];
    
    //3.创建player的layer
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = CGRectMake(0, 0, kScreenHeight, kScreenWidth);//self.view.bounds;//全屏
    
    //设置视频以什么方式显示在layer上
    _playerLayer.videoGravity = AVLayerVideoGravityResize;//拉伸填充为主
    [self.view.layer addSublayer:_playerLayer];
    
    //4.添加到视图的layer上后，开始播放
    [_player play];
    
    //5.添加kvo，监听视频状态已经播放完成
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
    
    //6.视频上的视图
    [self makeUpMovieView];
    
    //7.监听loadedTime属性
    //如果有改变就更新值
    [_playerItem addObserver:self forKeyPath:@"loadedTime" options:NSKeyValueObservingOptionNew context:nil];
    
    //8.缓存条
    [self proView];
    
    //9.滑块-控制进度
    [self markSliderView];
    
    //10.创建播放时间   直播无
    [self makeTimeLab];
    
    //11.播放按钮  和下个(直播无)
    [self createBtn];
    
    //12.返回
    [self backBtn];
    
    //刷新
    [self refreshBtn];
    
    //13.标题
    [self createTitle];
    
    //14.创建手势控制音量
    [self createGesture];
    
    //15.声音slider
    [self customVideoSlider];
    
    //16.创建控制音量的btn
    [self makeBtn];
    
    // 水平滑动显示的进度label
    self.horizontalLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,_backView.frame.size.height/1.4, _backView.frame.size.width, 40)];
    self.horizontalLabel.textColor = [UIColor redColor];
    self.horizontalLabel.textAlignment = NSTextAlignmentCenter;
    self.horizontalLabel.text = @"00:00 / --:--";
    // 一上来先隐藏
    self.horizontalLabel.hidden = YES;
    [_backView addSubview:_horizontalLabel];
    
    //17.菊花
    _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activity.center = _backView.center;
    [self.view addSubview:_activity];
    [_activity startAnimating];
    
    
    //视图隐藏
    [self hideView];
    
    //计时器
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(Stack) userInfo:nil repeats:YES];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(removePlayerOnPlayerLayer)
                   name:UIApplicationDidEnterBackgroundNotification
                 object:nil];
    
    [center addObserver:self
               selector:@selector(resetPlayerToPlayerLayer)
                   name:UIApplicationWillEnterForegroundNotification
                 object:nil];
}

- (void)removePlayerOnPlayerLayer {
    
    _playerLayer.player = nil;
}

- (void)resetPlayerToPlayerLayer {
    
    _playerLayer.player = _player;
}


-(void)hideView{
    //延迟线程
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.5 animations:^{
            _backView.alpha = 0;
        }];
    });
}
#pragma mark 视图
-(void)makeUpMovieView{
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_backView];
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15)];
    _topView.alpha = 0.5;
    [_backView addSubview:_topView];
}
- (void)moviePlayDidEnd:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma pro 缓存条
-(void)proView{
    _pro = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _pro.frame = CGRectMake(0,_backView.frame.size.height-20, kScreenWidth, 10);
    //进度条走过的颜色
    _pro.progressTintColor = [UIColor whiteColor];
    //未走的颜色
    _pro.trackTintColor = [UIColor grayColor];
    [_backView addSubview:_pro];
}
#pragma mark 滑块
-(void)markSliderView{
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, _backView.frame.size.height-27, kScreenWidth, 15)];
    [_slider setThumbImage:[UIImage imageNamed:@"iconfont-yuan.png"] forState:UIControlStateNormal];
    [_slider addTarget:self action:@selector(progressSlider:) forControlEvents:UIControlEventValueChanged];
    //左端颜色      max为右端
    _slider.minimumTrackTintColor = [UIColor redColor];
    //如果要改变滑动过的显示大小，需要自定义图片就行了
    [_backView addSubview:_slider];
}
#pragma mark 时间
-(void)makeTimeLab{
    _currentTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth *0.86, _backView.frame.size.height-90, 100, 20)];
    _currentTimeLab.textColor = [UIColor whiteColor];
    _currentTimeLab.font = [UIFont systemFontOfSize:12];
    _currentTimeLab.text = @"00:00/00:00";
    [_backView addSubview:_currentTimeLab];
}
#pragma mark 播放按钮
-(void)createBtn{
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(25, _backView.frame.size.height-90, 40, 40);
    [self.backView addSubview:startBtn];
    
    //播放速率，1.0为播放状态
    if (_player.rate == 1.0) {
        [startBtn setBackgroundImage:[UIImage imageNamed:@"pauseBtn"] forState:UIControlStateNormal];
    }else {
        [startBtn setBackgroundImage:[UIImage imageNamed:@"playBtn"] forState:UIControlStateNormal];
    }
    
    [startBtn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    nextBtn.frame = CGRectMake(startBtn.frame.origin.x+40, startBtn.frame.origin.y+5, 25, 25);
    //    [nextBtn setBackgroundImage:[UIImage imageNamed:@"nextPlayer"] forState:UIControlStateNormal];
    //    [_backView addSubview:nextBtn];
    
}
#pragma mark - 返回按钮方法
- (void)backBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, 20, 35, 35);
    [btn setBackgroundImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:btn];
}

#pragma mark - 刷新按钮方法
- (void)refreshBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, kScreenWidth - 80, 35, 35);
    [btn setBackgroundImage:[UIImage imageNamed:@"refreshImg"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(refreshBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:btn];
}

#pragma mark - 创建标题
- (void)createTitle
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, _backView.frame.size.width, 30)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.liveTitle;
    label.font = [UIFont boldSystemFontOfSize:20];
    [_backView addSubview:label];
}
#pragma mark 音量btn
-(void)makeBtn{
    
    UIButton *volumeUpBtn= [[UIButton alloc] init];
    volumeUpBtn.frame = CGRectMake(25, 90, 15, 15);
    [volumeUpBtn setImage:[UIImage imageNamed:@"voiceMax"] forState:UIControlStateNormal];
    [volumeUpBtn addTarget:self action:@selector(volume:) forControlEvents:UIControlEventTouchUpInside];
    volumeUpBtn.tag = 100;
    [_backView addSubview:volumeUpBtn];
    
    _voicePro = [[UIProgressView alloc]initWithProgressViewStyle: UIProgressViewStyleBar];
    _voicePro.backgroundColor = [UIColor grayColor];
    _voicePro.progressTintColor = [UIColor whiteColor];
    _voicePro.progress = 0.5;
    _voicePro.frame = CGRectMake(-10, volumeUpBtn.frame.origin.y+60, 80, 15);
    //旋转
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI/2 * 3);
    _voicePro.transform = trans;
    [_backView addSubview:_voicePro];
    
    UIButton *volumeDownBtn = [[UIButton alloc] init];
    volumeDownBtn.frame = CGRectMake(25, _voicePro.frame.origin.y+_voicePro.frame.size.height+5, 15, 15);
    [volumeDownBtn setImage:[UIImage imageNamed:@"voiceMin"] forState:UIControlStateNormal];
    [volumeDownBtn addTarget:self action:@selector(volume:) forControlEvents:UIControlEventTouchUpInside];
    volumeDownBtn.tag = 101;
    [_backView addSubview:volumeDownBtn];
}
#pragma mark - 创建手势-控制音量
- (void)createGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    
    // 添加平移手势，用来控制音量和快进快退
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panDirection:)];
    [self.view addGestureRecognizer:pan];
}
#pragma mark slider
-(void)customVideoSlider{
    //关联上下文图形
    UIGraphicsBeginImageContextWithOptions((CGSize){1,1}, NO, 0.0f);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [self.slider setMaximumTrackImage:img forState:UIControlStateNormal];
}
#pragma mark - slider滑动事件
- (void)progressSlider:(UISlider *)slider{
    
    //拖动改变  视频进度
    //直播没有此功能
    if (_slider.state == AVPlayerStatusReadyToPlay) {
        [self playerTime:0];
    }
}
#pragma mark 计算视频滑动时间
-(void)playerTime:(CGFloat)second{
    //1.计算拖动出的，当前秒数
    //值/时间刻度=秒。固定公式
    CGFloat total = (CGFloat)_playerItem.duration.value / _playerItem.duration.timescale;
    
    //2.拖动的时间
    //floorf 类型 float
    //函数  floor() / floorf() / floorl() ----向下取整
    CGFloat dragTime = floorf(total * _slider.value);
    
    //3.转成CMTime 才能给player控制进度
    CMTime time = CMTimeMake(dragTime+second, 1);
    
    //4.拖动时，先暂停播放
    [_player pause];
    
    //5.找到拖动的时间，播放
    [_player seekToTime:time completionHandler:^(BOOL finished) {
        [_player play];
    }];
}
#pragma mark - 播放暂停按钮方法
- (void)startAction:(UIButton *)button
{
    if (button.selected) {
        [_player play];
        [button setBackgroundImage:[UIImage imageNamed:@"pauseBtn"] forState:UIControlStateNormal];
        
    } else {
        [_player pause];
        [button setBackgroundImage:[UIImage imageNamed:@"playBtn"] forState:UIControlStateNormal];
    }
    button.selected =!button.selected;
}
#pragma mark - 点击方法
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (_backView.alpha == 1) {
        [UIView animateWithDuration:0.5 animations:^{
            
            _backView.alpha = 0;
        }];
    }else if (_backView.alpha == 0){
        [UIView animateWithDuration:0.5 animations:^{
            
            _backView.alpha = 1;
        }];
    }
    
    if (_backView.alpha == 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                _backView.alpha = 0;
            }];
            
        });
    }
}
#pragma mark - 平移手势方法
- (void)panDirection:(UIPanGestureRecognizer *)pan{
    CGPoint movePoint = [pan velocityInView:self.view];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            //绝对值判断移动方向
            CGFloat x = fabs(movePoint.x);
            CGFloat y = fabs(movePoint.y);
            
            CGFloat lrX = movePoint.x;//处理左还是右
            
            if (x > y) {//横向改变进度
                panDirection = panHorizontalMove;
                
                //转成float
                if (lrX > 0) {
                    sumTime = CMTimeGetSeconds(self.playerItem.currentTime);
                }else{
                    sumTime = -CMTimeGetSeconds(self.playerItem.currentTime);
                }
                
                self.horizontalLabel.hidden = NO;
                _backView.alpha = 1;
            }else if (x < y){//纵向改变音量
                
                panDirection = panVerticalMove;
                isVolume = YES;
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{
            if (panDirection == panHorizontalMove) {
                [self horizontalMoved:movePoint.x];
            }else if (panDirection == panVerticalMove) {
                [self verticalMoved:movePoint.y];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:{
            if (panDirection == panHorizontalMove){
                self.horizontalLabel.hidden = YES;
                
                //暂时用这个
                if (sumTime >0) {
                    [self playerTime:10];
                }else{
                    [self playerTime:-10];
                }
                sumTime = 0;
                _backView.alpha = 0;
                
            }else if (panDirection == panVerticalMove){
                isVolume = NO;
            }
            break;
        }
        default:
            break;
    }
}
#pragma mark - pan水平移动的方法
- (void)horizontalMoved:(CGFloat)value
{
    // 快进快退的方法
    NSString *style = @"";
    if (value < 0) {
        style = @"<<";
    }else if (value > 0){
        style = @">>";
    }
    
    // 每次滑动需要叠加时间
    sumTime += value / 200;
    
    // 需要限定sumTime的范围
    if (sumTime > CMTimeGetSeconds(self.playerItem.currentTime)) {
        sumTime = CMTimeGetSeconds(self.playerItem.currentTime);
    }else if (sumTime < 0){
        sumTime = 0;
    }
    
    // 当前快进的时间
    NSString *nowTime = [self durationStringWithTime:(int)sumTime];
    // 总时间
    NSString *durationTime = [self durationStringWithTime:(int)CMTimeGetSeconds(self.playerItem.duration)];
    // 给label赋值
    self.horizontalLabel.text = [NSString stringWithFormat:@"%@ %@ / %@",style, nowTime, durationTime];
}
#pragma mark - 根据时长求出字符串
- (NSString *)durationStringWithTime:(int)time
{
    // 获取分钟
    NSString *min = [NSString stringWithFormat:@"%02d",time / 60];
    // 获取秒数
    NSString *sec = [NSString stringWithFormat:@"%02d",time % 60];
    return [NSString stringWithFormat:@"%@:%@", min, sec];
}
#pragma mark - pan垂直移动的方法
- (void)verticalMoved:(CGFloat)value
{
    if (value > 0) {
        if (_player.volume > 0) {
            _player.volume -= 0.3;
        }else{
            _player.volume = 0;
        }
    }else{
        if(_player.volume < 2){
            _player.volume += 0.3;
        }else{
            _player.volume = 2;
        }
    }
    _voicePro.progress = _player.volume/2;
}
#pragma mark  返回
- (void)backButtonAction
{
    [_player pause];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)refreshBtnAction {
    [self removePlayerOnPlayerLayer];
    [self resetPlayerToPlayerLayer];
}

#pragma mark - 计时器事件
- (void)Stack{
    if (_playerItem.duration.timescale != 0) {
        //总时长
        _slider.maximumValue = 1;
        //当前进度
        _slider.value = CMTimeGetSeconds([_playerItem currentTime]) / (_playerItem.duration.value / _playerItem.duration.timescale);
        
        //当前时长进度pro
        //秒
        NSInteger proMin = (NSInteger)CMTimeGetSeconds([_player currentTime]) / 60;
        //分钟
        NSInteger proMax = (NSInteger)CMTimeGetSeconds([_player currentTime]) % 60;
        
        //总时长
        NSInteger durMin = (NSInteger)_playerItem.duration.value / _playerItem.duration.timescale / 60;//秒
        NSInteger durMax = (NSInteger)_playerItem.duration.value / _playerItem.duration.timescale % 60;//分钟
        _currentTimeLab.text = [NSString stringWithFormat:@"%02ld:%02ld / %02ld:%02ld",proMin,proMax,durMin,durMax];
    }
    
    //控制菊花
    if (_player.status == AVPlayerStatusReadyToPlay) {
        [_activity stopAnimating];
    }else{
        [_activity startAnimating];
    }
}
#pragma mark 音量btn事件
-(void)volume:(UIButton *)sender{
    [sender setShowsTouchWhenHighlighted:YES];//亮度
    
    if (sender.tag == 100) {//加
        if(_player.volume < 2){
            _player.volume += 0.3;
        }else{
            _player.volume = 2;
        }
    }else{//减
        if (_player.volume > 0) {
            _player.volume -= 0.3;
        }else{
            _player.volume = 0;
        }
    }
    _voicePro.progress = _player.volume/2;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
}
#pragma mark  缓存方式  监听
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"loadedTime"]) {
        //计算缓冲进度
        NSTimeInterval time = [self availableDuration];
        
        //直播无缓冲
        CMTime duration = self.playerItem.duration;
        
        CGFloat totalDur = CMTimeGetSeconds(duration);
        
        //设置进度
        [_pro setProgress:time / totalDur animated:YES];
    }
}
#pragma mark 计算缓冲进度
-(NSTimeInterval)availableDuration{
    
    //当前视频的，加载时间
    NSArray *timeRange = [[_player currentItem] loadedTimeRanges];
    CMTimeRange cmTimeRange = [timeRange.firstObject CMTimeRangeValue];
    
    //缓冲区间
    float startSecond = CMTimeGetSeconds(cmTimeRange.start);
    float durationSecond = CMTimeGetSeconds(cmTimeRange.duration);
    
    //计算
    NSTimeInterval result = startSecond + durationSecond;
    return result;
}



@end
