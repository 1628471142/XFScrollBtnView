//
//  XFScrollBtnView.h
//  吃在中国
//
//  Created by 李雪峰 on 16/5/9.
//  Copyright © 2016年 hfuu. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef void (^ScrollBtnClickBlock)(NSInteger btnIndex);

@class XFScrollButton;
@interface XFScrollBtnView : UIScrollView

@property ( nonatomic, strong) NSArray *titleArray;

@property ( nonatomic, strong) ScrollBtnClickBlock btnClickBlock;

@property ( nonatomic, strong) UIFont *titleFont;

@property ( nonatomic, strong) UIColor *btnSelectedColor;//按钮选中title颜色

@property ( nonatomic, strong) UIColor *groundNormalColor;//按钮背景色

@property ( nonatomic, strong) UIColor *groundSelectedColor;//按钮选中背景色

@property ( nonatomic, strong) UIColor *titleColor;//按钮title颜色

@property ( nonatomic, assign) CGFloat btnHeight;

@property ( nonatomic, assign) CGFloat btnWidth;

@property ( nonatomic, assign) BOOL isVertical;//是否为竖直方向滚动按钮

@property ( nonatomic, strong) XFScrollButton *scrollButton;
@end

//补充：后续添加一个自定义Button
@interface XFScrollButton : UIButton

@end