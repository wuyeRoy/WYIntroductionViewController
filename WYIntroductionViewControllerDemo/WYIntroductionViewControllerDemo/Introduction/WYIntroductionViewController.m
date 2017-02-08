//
//  WYIntroductionViewController.m
//  WYIntroductionViewControllerDemo
//
//  Created by WYRoy on 17/2/7.
//  Copyright © 2017年 ihefe－0006. All rights reserved.
//
#define kScreen_height  [[UIScreen mainScreen] bounds].size.height
#define kScreen_width   [[UIScreen mainScreen] bounds].size.width


#import "WYIntroductionViewController.h"
#import "ViewController.h"

@interface WYIntroductionViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,weak)UIPageControl *pageControl;


@end

@implementation WYIntroductionViewController
static NSString *const kAppVersion = @"appVersion";


- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatScrollView];
}

#pragma mark - setUp
- (void)creatScrollView
{
    //creat pageControl
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height)];
    scrollView.contentSize = CGSizeMake(kScreen_width * _images.count, kScreen_height);
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    
    //add images
    for (int i = 0; i < _images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreen_width, 0, kScreen_width, kScreen_height)];
        imageView.image = [UIImage imageNamed:_images[i]];
        [scrollView addSubview:imageView];
        
        if (_enterType_Btn) {//以按钮的形式进入程序
            if (i == _images.count - 1) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * kScreen_width + (kScreen_width-100)/2, kScreen_height - 200, 100, 50)];
                [btn setTitle:@"进入" forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor redColor]];
                btn.layer.cornerRadius = 10;
                btn.layer.masksToBounds = YES;
                [btn addTarget:self action:@selector(enterMainVCClick) forControlEvents:UIControlEventTouchUpInside];
                [scrollView addSubview:btn];
            }
        }
    }
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //creat pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreen_height - 50, kScreen_width, 30)];
    pageControl.numberOfPages = _images.count;
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = self.currentColor ? self.currentColor : [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = self.nomalColor ? self.nomalColor : [UIColor darkGrayColor];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        _pageControl.currentPage = (scrollView.contentOffset.x + kScreen_width*0.5) / kScreen_width;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    int currentIndex = (scrollView.contentOffset.x + kScreen_width*0.5) / kScreen_width;
    if (currentIndex == _images.count - 1) {
        if ([self isScrollToLeft]) {
            //向右滚动 进入程序
            if (!_enterType_Btn) {
                 [self enterMainVCClick];
            }
        }
    }
}

#pragma mark - 判断向左滚动
- (BOOL)isScrollToLeft
{
    //返回YES为手指向左滑，出现右边的页面
    NSLog(@"%f",[_scrollView.panGestureRecognizer translationInView:_scrollView.superview].x);
    if ([_scrollView.panGestureRecognizer translationInView:_scrollView.superview].x < 0) {//获取手指移动后，在相对坐标中的偏移量
        NSLog(@"手指向左滑");
        return YES;
    }
    else
    {
        NSLog(@"手指向右滑");
        return NO;
    }
}

#pragma mark - 点击按钮进入程序
-(void)enterMainVCClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [UIView animateWithDuration:0.5 animations:^{
        
        ViewController *vc = [[ViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        window.rootViewController = nav;
    }];
}



@end
