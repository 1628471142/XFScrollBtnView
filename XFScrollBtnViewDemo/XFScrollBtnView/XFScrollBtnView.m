//
//  XFScrollBtnView.m
//  吃在中国
//
//  Created by 李雪峰 on 16/5/9.
//  Copyright © 2016年 hfuu. All rights reserved.
//

#import "XFScrollBtnView.h"
#define XFBtnTag 1666
#define XFDeseletNotifation @"deseletBtnState"

@implementation XFScrollBtnView
{
    CGRect superFrame;
    CGSize superContentSize;
    NSInteger visibleCenterIndex;//可见的中间位置
    CGFloat centerOffSetY;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setFrame:frame];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame{

    [super setFrame:frame];
    
    self.bounces = NO;
    self.showsVerticalScrollIndicator = NO;
    superFrame = frame;
    _isVertical = frame.size.width > frame.size.height ? NO : YES;
    [self addObserver:self forKeyPath:@"titleArray" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"isVertical" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"titleFont" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"groundSelectedColor" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"groundNormalColor" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"btnHeight" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"btnWidth" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"titleColor" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"btnSelectedColor" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];

}

- (void)setContentSize:(CGSize)contentSize{
    [super setContentSize:contentSize];
    superContentSize = contentSize;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"titleArray"];
    [self removeObserver:self forKeyPath:@"isVertical"];
    [self removeObserver:self forKeyPath:@"titleFont"];
    [self removeObserver:self forKeyPath:@"groundSelectedColor"];
    [self removeObserver:self forKeyPath:@"groundNormalColor"];
    [self removeObserver:self forKeyPath:@"btnHeight"];
    [self removeObserver:self forKeyPath:@"btnWidth"];
    [self removeObserver:self forKeyPath:@"titleColor"];
    [self removeObserver:self forKeyPath:@"btnSelectedColor"];

}

- (UIColor *)groundNormalColor{
    if (!_groundNormalColor) {
        _groundNormalColor = [UIColor whiteColor];
    }
    return _groundNormalColor;
}

- (UIColor *)groundSelectedColor{
    if (!_groundSelectedColor) {
        _groundSelectedColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    }
    return _groundSelectedColor;
}

- (UIColor *)titleColor{
    if (!_titleColor) {
        _titleColor = [UIColor darkGrayColor];
    }
    return _titleColor;
}

- (UIColor *)btnSelectedColor{
    if (!_btnSelectedColor) {
        _btnSelectedColor = [UIColor redColor];
    }
    return _btnSelectedColor;
}

- (UIFont *)titleFont{
    if (!_titleFont) {
        _titleFont = [UIFont systemFontOfSize:15];
    }
    return _titleFont;
}

- (CGFloat)btnHeight{
    if (!_btnHeight) {
        _btnHeight = 50;
    }
    return _btnHeight;
}

- (CGFloat)btnWidth{
    if (!_btnWidth) {
        _btnWidth = 70;
    }
    return _btnWidth;
}

//添加按钮
- (void)addBtnOnScrollView{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (_isVertical) {
        
        for(int i = 0 ; i < _titleArray.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, i * self.btnHeight, self.btnWidth, self.btnHeight)];
            
            btn.titleLabel.font = self.titleFont;
            [btn setTitle:[_titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
            [btn setTitleColor:self.btnSelectedColor forState:UIControlStateDisabled];
            [btn setBackgroundColor:self.groundNormalColor];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _btnHeight-1, _btnWidth, 1)];
            [line setBackgroundColor:self.groundSelectedColor];
            [btn addSubview:line];
            if (i == 0) {
                btn.enabled = NO;
                [btn setBackgroundColor:self.groundSelectedColor];
            }
            btn.tag = XFBtnTag + i;
            [self addSubview:btn];
        }
    }else{
        for(int i = 0 ; i < self.titleArray.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*self.btnWidth, 0, self.btnWidth, self.btnHeight)];
            
            [btn setTitle:[_titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
            [btn setTitleColor:self.btnSelectedColor forState:UIControlStateDisabled];
            [btn setBackgroundColor:self.groundNormalColor];
            btn.titleLabel.font = self.titleFont;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(_btnWidth-1, 0, 1, _btnHeight)];
            [line setBackgroundColor:self.groundSelectedColor];
            [btn addSubview:line];
            if (i == 0) {
                btn.enabled = NO;
                [btn setBackgroundColor:self.groundSelectedColor];
            }
            btn.tag = XFBtnTag + i;
            [self addSubview:btn];
        }
    }
}

//计算中间按钮的位置
- (void)scaleCenterIndex{
    
    if (_isVertical) {
        visibleCenterIndex = superFrame.size.height/self.btnHeight/2;
        centerOffSetY = visibleCenterIndex * self.btnHeight;
    }else{
        visibleCenterIndex = superFrame.size.height/self.btnWidth/2;
        centerOffSetY = visibleCenterIndex * self.btnWidth;
    }
    
}

- (void)btnClick:(UIButton *)curbtn{
    for (int i = 0; i < self.titleArray.count; i ++) {
        UIButton *btn = [self viewWithTag:i + XFBtnTag];
        if (![btn isEqual:curbtn]) {
            btn.enabled = YES;
            [btn setBackgroundColor:self.groundNormalColor];
        }else{
            btn.enabled = NO;
            [btn setBackgroundColor:self.groundSelectedColor];
            NSInteger btnIndex = btn.tag - XFBtnTag;
            if (self.btnClickBlock) {
                self.btnClickBlock(btnIndex);
            }
            if (btnIndex > visibleCenterIndex && self.titleArray.count - btnIndex > visibleCenterIndex) {
                    if (_isVertical) {
                        [self setContentOffset:CGPointMake(0, btnIndex*self.btnHeight - centerOffSetY) animated:YES];
                    }else{
                        [self setContentOffset:CGPointMake(btnIndex*self.btnWidth - centerOffSetY, 0) animated:YES];

                }
            }else{
                if (btnIndex <= visibleCenterIndex) {
                    [self setContentOffset:CGPointMake(0, 0) animated:YES];

                }
                if (btnIndex >= (self.titleArray.count - visibleCenterIndex)) {
                    if (_isVertical) {
                        [self setContentOffset:CGPointMake(0, self.contentSize.height - superFrame.size.height) animated:YES];
                    }else{
                        [self setContentOffset:CGPointMake(self.contentSize.width - superFrame.size.width, 0) animated:YES];
                    }
                    
                }
            }
        }
    }
}

//重置btn属性
- (void)configBtnProperty{
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"titleArray"]) {
        [self addBtnOnScrollView];
        [self freshContentSize];
        [self scaleCenterIndex];

    }
    if ([keyPath isEqualToString:@"isVertical"]) {
        [self addBtnOnScrollView];
        [self freshContentSize];
        [self scaleCenterIndex];

    }
    if ([keyPath isEqualToString:@"titleFont"]) {
        [self addBtnOnScrollView];

    }
    if ([keyPath isEqualToString:@"groundSelectedColor"]) {
        [self addBtnOnScrollView];

    }
    if ([keyPath isEqualToString:@"groundNormalColor"]) {
        [self addBtnOnScrollView];

    }
    if ([keyPath isEqualToString:@"btnHeight"]) {
        [self addBtnOnScrollView];
        [self freshContentSize];
        [self scaleCenterIndex];

    }
    if ([keyPath isEqualToString:@"btnWidth"]) {
        [self addBtnOnScrollView];
        [self freshContentSize];
        [self scaleCenterIndex];

    }
    if ([keyPath isEqualToString:@"titleColor"]) {
        [self addBtnOnScrollView];

    }
    if ([keyPath isEqualToString:@"btnSelectedColor"]) {
        [self addBtnOnScrollView];

    }
    if (_isVertical) {
        self.scrollEnabled = _titleArray.count * self.btnHeight > superFrame.size.height ? YES : NO;
    }else{
        self.scrollEnabled = _titleArray.count * self.btnWidth > superFrame.size.width ? YES : NO;
    }
}

//更新contentsize
- (void)freshContentSize{
    if (_isVertical) {
        [self setContentSize:CGSizeMake(self.btnWidth, self.titleArray.count*self.btnHeight)];
    }else{
        [self setContentSize:CGSizeMake(self.titleArray.count*self.btnWidth, self.btnHeight)];

    }
}



@end
