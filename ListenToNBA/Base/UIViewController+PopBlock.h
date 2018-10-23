//
//  UIViewController+PopBlock.h
//  Meet
//
//  Created by 罗德良 on 2018/10/15.
//  Copyright © 2018年 luode. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PopBlock)(UIBarButtonItem *backItem);

@interface UIViewController (PopBlock)
@property(nonatomic,copy)PopBlock popBlock;

@end
