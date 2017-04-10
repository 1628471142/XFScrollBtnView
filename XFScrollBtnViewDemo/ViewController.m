//
//  ViewController.m
//  XFScrollBtnViewDemo
//
//  Created by 展翅的小鸟 on 17/4/10.
//  Copyright © 2017年 com.hfuu. All rights reserved.
//

#define MainHeight [UIScreen mainScreen].bounds.size.height
#define MainWidth [UIScreen mainScreen].bounds.size.width


#import "ViewController.h"
#import "XFScrollBtnView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    XFScrollBtnView *scrollBtnView = [[XFScrollBtnView alloc] init];
    [scrollBtnView setFrame:CGRectMake(0, 20, 70, MainHeight - 20)];
    scrollBtnView.titleColor = [UIColor colorWithRed:0.33 green:0.83 blue:0.44 alpha:1];
    scrollBtnView.titleArray = @[@"家居家纺",@"户外运动",@"钟表珠宝",@"医药保健",@"家居家纺",@"户外运动",@"钟表珠宝",@"医药保健",@"家居家纺",@"户外运动",@"钟表珠宝",@"医药保健",@"家居家纺",@"户外运动",@"钟表珠宝",@"医药保健",@"户外运动",@"钟表珠宝",@"医药保健"];
    [self.view addSubview:scrollBtnView];
    scrollBtnView.btnClickBlock = ^(NSInteger index){
        NSLog(@"点击了%ld",index);
    };

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
