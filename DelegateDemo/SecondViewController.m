//
//  SecondViewController.m
//  DelegateDemo
//
//  Created by csdc-iMac on 16/8/2.
//  Copyright © 2016年 Cloudox. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"子界面";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 显示方块的按钮
    UIButton *showBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 20)];
    [showBtn setTitle:@"显示方块" forState:UIControlStateNormal];
    [showBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [showBtn addTarget:self action:@selector(showSquare) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn];
    
    // 隐藏方块的按钮
    UIButton *dismissBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 250, [UIScreen mainScreen].bounds.size.width, 20)];
    [dismissBtn setTitle:@"隐藏方块" forState:UIControlStateNormal];
    [dismissBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissSquare) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
}

// 显示方块
- (void)showSquare {
    [self.delegate showTheSquare];// 调用委托方法
    [self.navigationController popViewControllerAnimated:YES];// 返回上个界面
}

// 隐藏方块
- (void)dismissSquare {
    [self.delegate dismissTheSquare];// 调用委托方法
    [self.navigationController popViewControllerAnimated:YES];// 返回上个界面
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
