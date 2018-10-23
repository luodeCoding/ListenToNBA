//
//  UIViewController+PopBlock.m
//  Meet
//
//  Created by 罗德良 on 2018/10/15.
//  Copyright © 2018年 luode. All rights reserved.
//

#import "UIViewController+PopBlock.h"
#import <objc/runtime.h>
@implementation UIViewController (PopBlock)
-(void)setPopBlock:(PopBlock)popBlock{
    objc_setAssociatedObject(self, @selector(popBlock), popBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(PopBlock)popBlock{
    return objc_getAssociatedObject(self, _cmd);
}
@end
