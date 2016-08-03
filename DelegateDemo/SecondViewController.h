//
//  SecondViewController.h
//  DelegateDemo
//
//  Created by csdc-iMac on 16/8/2.
//  Copyright © 2016年 Cloudox. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SecondViewControllerDelegate
- (void)showTheSquare;// 显示方块的委托
- (void)dismissTheSquare;// 隐藏方块的委托
@end

@interface SecondViewController : UIViewController

@property (nonatomic, weak) id<SecondViewControllerDelegate> delegate;

@end
