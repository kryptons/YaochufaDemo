//
//  CFSocialShareView.m
//  ToStartTravelAround
//
//  Created by SkyWalker on 15/8/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CFSocialShareView.h"
#import "UIView+Extension.h"

@interface CFSocialShareView()
/**
 *  将来用来显示具体内容的容器
 */
@property (nonatomic, strong) UIView *containerView;
@end

@implementation CFSocialShareView



-(UIView *)containerView{

    if (!_containerView) {
        
        _containerView = [[UIView alloc] init];
    
        [self addSubview:_containerView];
 
    }
    return _containerView;
}



-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
    
        self.backgroundColor = [UIColor clearColor];
   
    }
    return self;
}


+(instancetype)shareView{

    return [[self alloc] init];
}




/**
 *  显示
 *
 */
-(void)show{

    //获取最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    //添加自己到窗口上
    [window addSubview:self];
    //设置尺寸
    self.frame = window.bounds;
 
    CGFloat containterViewHeight = IphoneHeight*0.4;
    
    self.containerView.frame = CGRectMake(0, window.bounds.size.height - containterViewHeight, window.bounds.size.width, containterViewHeight);
    
    self.containerView.userInteractionEnabled = YES;

    self.content.backgroundColor = [UIColor colorWithWhite:0.927 alpha:1.000];

}


- (void)setContent:(UIView *)content
{
    _content = content;
    
    // 设置控件容器的高度
    self.containerView.height = CGRectGetMaxY(content.frame);
    // 设置控件容器的宽度
    self.containerView.width = CGRectGetMaxX(content.frame);
    
    // 添加内容到灰色图片中
    [self.containerView addSubview:content];
}

/**
 *  销毁
 */
-(void)dismiss{
    
    [self removeFromSuperview];

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self dismiss];

}

- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    
    self.content = contentController.view;
    
}



@end
