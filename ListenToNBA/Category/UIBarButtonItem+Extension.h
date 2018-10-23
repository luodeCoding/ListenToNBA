//
//  UIBarButtonItem+Extension.h
//  Meet
//
//  Created by 罗德良 on 2018/10/15.
//  Copyright © 2018年 luode. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>

@interface ItemView:UIView

@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UILabel *titleLabel;

@end


@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                            target:(id)target
                            action:(SEL)action;

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon
                         highIcon:(NSString *)highIcon
                           target:(id)target
                           action:(SEL)action;

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon
                         highIcon:(NSString *)highIcon
                            title:(NSString *)title
                           target:(id)target
                           action:(SEL)action;

@end

