//
//  ViewController.m
//  DelegateDemo
//
//  Created by csdc-iMac on 16/8/2.
//  Copyright © 2016年 Cloudox. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

// 遵循子界面的协议
@interface ViewController ()<SecondViewControllerDelegate>

@property (nonatomic, strong) UIView *square;// 方块

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"主界面";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 进入子界面的按钮
    UIButton *secondViewBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 20)];
    [secondViewBtn setTitle:@"进入子界面" forState:UIControlStateNormal];
    [secondViewBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [secondViewBtn addTarget:self action:@selector(showSecondView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondViewBtn];
    
    // 方块
    self.square = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 100)/2, 250, 100, 100)];
    self.square.backgroundColor = [UIColor lightGrayColor];
    self.square.alpha = 0;// 初始设为不可见
    [self.view addSubview:self.square];
}

// 进入子界面
- (void)showSecondView {
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.delegate = self;
    [self.navigationController pushViewController:secondVC animated:YES];
}

#pragma mark - SecondViewController Delegate

// 显示方块
- (void)showTheSquare {
    self.square.alpha = 1;
}

// 隐藏方块
- (void)dismissTheSquare {
    self.square.alpha = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
