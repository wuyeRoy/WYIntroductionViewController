//
//  WYIntroductionViewController.h
//  WYIntroductionViewControllerDemo
//
//  Created by WYRoy on 17/2/7.
//  Copyright © 2017年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYIntroductionViewController : UIViewController

@property(nonatomic,strong)NSArray *images;
/**
 *  选中page的指示器颜色，默认白色
 */
@property (nonatomic, strong) UIColor *currentColor;
/**
 *  其他状态下的指示器的颜色，默认
 */
@property (nonatomic, strong) UIColor *nomalColor;

/**
 yes：以按钮的形式进入程序   NO：以滑动进入
 默认NO
 */
@property(nonatomic,assign)BOOL enterType_Btn;
@end
