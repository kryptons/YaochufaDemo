//
//  MyTabBarController.m
//  CustomizedTabBar
//
//  Created by DancewithPeng on 15/6/3.
//  Copyright (c) 2015年 dancewithpeng@gmail.com. All rights reserved.
//

#import "MyTabBarController.h"
#import "MyButton.h"
#import "HWNavigationController.h"
#import "BHBPopView.h"

@interface MyTabBarController ()
{
    UIView *_sliderView;
}

@property (nonatomic, strong) MyButton *btn;
@property (nonatomic, assign) BOOL btnClick;
@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置TabBar背景透明度,默认白色
    self.tabBar.translucent = NO;
    self.view.backgroundColor = CFColor(241, 242, 245);
    [self createViewControllers];
    [self createCustomizedTabBarButtons];
}


#pragma mark - 创建ViewControllers




- (void)createViewControllers
{
    //定义一个存放界面名字的数组
    NSArray *vcNames = @[@"CFMainPageViewController", @"CFAroundViewController", @"CFDiscoverViewController", @"CFMineViewController"];
    //定义一个数组接收实例化的控制器
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    //遍历数组,实例化控制器和导航控制器
    for (NSString *name in vcNames) {
        UIViewController *vc = [[NSClassFromString(name) alloc] init];

        HWNavigationController *nav = [[HWNavigationController alloc]initWithRootViewController:vc];
        [viewControllers addObject:nav];
    }
    
    self.viewControllers = viewControllers;
}

- (void)createCustomizedTabBarButtons
{
    // 1.隐藏系统的按钮
    for (UIView *subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            subView.hidden = YES;
        }
    }
    
    // 2.创建我们自己的Button放到TabBar上面
    NSArray *iconNames = @[@"tab_bar_home_icon", @"tab_bar_around_icon",@"tabbar_compose_icon_add", @"tab_bar_discover_icon", @"tab_bar_my_icon"];
    NSArray *selectedIconNames = @[@"tab_bar_home_icon_current", @"tab_bar_around_icon_current",@"tabbar_compose_icon_add", @"tab_bar_discover_icon_current", @"tab_bar_my_icon_current"];
    NSArray *nameArr = @[@"首页",@"周边",@"",@"发现",@"我的"];
    
    static  int index = 0;
    CGFloat btnWidth = [[UIScreen mainScreen] bounds].size.width/iconNames.count;
    for (int i=0; i<iconNames.count; i++) {
        NSString *iconName = iconNames[i];
        NSString *selectedIconName = selectedIconNames[i];
        
        _btn = [[MyButton alloc] initWithFrame:CGRectMake(i*btnWidth, 0, btnWidth, 49)];
        _btn.image = [UIImage imageNamed:iconName];
        _btn.selectedImage = [UIImage imageNamed:selectedIconName];
        if (i == 2) {
            [_btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
            [_btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted@2x"] forState:UIControlStateHighlighted];
            _btn.iconImageView.frame = CGRectMake(0, 0, 30, 30);
            _btn.iconImageView.center = CGPointMake(_btn.frame.size.width/2, _btn.frame.size.height/2);
            [_btn addTarget:self action:@selector(composeBtnCliked)  forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            [_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            _btn.nameLabel.text = nameArr[i];
            _btn.tag = index++;

        }
                [self.tabBar addSubview:_btn];
        
        // 如果当选中的页面的下标等对应这个i
        if (i == self.selectedIndex) {
            _btn.selected = YES;
        }
    }
    
    
    // 4.设置Bar的背景图片
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbg"]];
}
//设置button的点击事件
- (void)btnClicked:(MyButton *)btn
{
    btn.selected = YES;
    
    for (UIView *subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:[MyButton class]] && subView!=btn) {
            
            ((MyButton *)subView).selected = NO;
        }
    }
    self.selectedIndex = btn.tag;
}

- (void)composeBtnCliked
{
    BHBItem * item0 = [[BHBItem alloc]initWithTitle:@"Text" Icon:@"images.bundle/tabbar_compose_idea"];
    BHBItem * item1 = [[BHBItem alloc]initWithTitle:@"Albums" Icon:@"images.bundle/tabbar_compose_photo"];
    BHBItem * item2 = [[BHBItem alloc]initWithTitle:@"Camera" Icon:@"images.bundle/tabbar_compose_camera"];
    BHBItem * item3 = [[BHBItem alloc]initWithTitle:@"Check in" Icon:@"images.bundle/tabbar_compose_lbs"];
    BHBItem * item4 = [[BHBItem alloc]initWithTitle:@"Review" Icon:@"images.bundle/tabbar_compose_review"];
    BHBItem * item5 = [[BHBItem alloc]initWithTitle:@"More" Icon:@"images.bundle/tabbar_compose_more"];
    //添加popview
    [BHBPopView showToView:self.view withItems:@[item0,item1,item2,item3,item4,item5] andSelectBlock:^(BHBItem *item, NSInteger index) {
        NSLog(@"%ld,选中%@",(long)index,item.title);
    }];}


- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    
    if (self.btnClick) {
        self.btnClick = NO;
        return;
    }
    MyButton *btn = (MyButton *)[self.tabBar viewWithTag:selectedIndex];
    if ([btn isKindOfClass:[UITabBar class]]) return;
    if (btn.selected) return;
    
    btn.selected = YES;
    for (UIView *subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:[MyButton class]] && subView!=btn) {
            
            ((MyButton *)subView).selected = NO;
        }
    }
    
}


@end
