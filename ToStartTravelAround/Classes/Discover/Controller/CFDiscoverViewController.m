//
//  CFDiscoverViewController.m
//  ToStartTravelAround
//
//  Created by mac on 15/7/30.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CFDiscoverViewController.h"
#import "CFFinderPageCell.h"
#import "CFSelectCityViewController.h"
#import "CFSearchController.h"
#import "CFWebViewController.h"
@interface CFDiscoverViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_picArray;//图片数据源数组


}
@property (nonatomic, strong)UITableView *picTableView;//表格视图
@property(nonatomic,strong)UIButton *leftButton;//导航栏按钮
@end

@implementation CFDiscoverViewController


#pragma mark - ====================== 视图生命周期 ==========================

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
    
    [self finderPageRequest];
}



#pragma mark - ====================== 创建视图 ==========================
//创建主视图
-(void)createView{
    //实例化一个_pictableView
    _picTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    //设置内嵌的高度为60
    _picTableView.contentInset = UIEdgeInsetsMake(0, 0, 120, 0);
    
    //设置代理
    self.picTableView.delegate = self;
    self.picTableView.dataSource = self;
    //设置分割线的样式
    self.picTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册cell
    [self.picTableView registerNib:[UINib nibWithNibName:@"CFFinderPageCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.picTableView];
    //创建尾部视图
    [self setFooterView];
    //创建下拉刷新视图
    [self setDownRefresh];
    //设置导航栏按钮
    [self createNavButton];
    
}

//创建下拉刷新
-(void)setDownRefresh{




}

-(void)setFooterView{

    UILabel *footerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, 60)];
    
    //设置文字
    footerView.text = @"更多专题，敬请期待";
    //设置居中样式
    footerView.textAlignment = NSTextAlignmentCenter;
    //设置字体大小
    footerView.font = [UIFont systemFontOfSize:13];
    //字体颜色
    footerView.textColor = [UIColor lightGrayColor];
    //设置为tableView的尾部
    self.picTableView.tableFooterView = footerView;
    
}

- (void)createNavButton
{
    //导航栏左边的按钮
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftButton setImage:[UIImage imageNamed:@"home_nav_bar_loaction_arrow_icon"] forState:UIControlStateNormal];
    _leftButton.frame = CGRectMake(0, 0, 40, 20);
    _leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [_leftButton setTitle:@"深圳" forState:UIControlStateNormal];
    
    [_leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //    leftBtn.backgroundColor = [UIColor yellowColor];
    _leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    _leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    //设置点击事件
    [_leftButton addTarget:self action:@selector(selectCityAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_leftButton];
    
    //导航栏右边的按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, IphoneWidth-90, 25);
    
    UIImage *searchBacImage = [UIImage imageNamed:@"home_search_bar_bg"];
    [rightBtn setBackgroundImage:[searchBacImage resizableImageWithCapInsets:UIEdgeInsetsMake(searchBacImage.size.height/2, searchBacImage.size.width/2, (searchBacImage.size.height/2)+1, (searchBacImage.size.width/2)+1)] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    rightBtn.layer.borderColor = CFColor(231, 231, 234).CGColor;
    rightBtn.layer.borderWidth = 1;
    rightBtn.layer.cornerRadius = 4;
    [rightBtn setTitle:@"搜索目的地/景点/酒店等" forState:UIControlStateNormal];
    
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -70, 0, 0);
    
    [rightBtn addTarget:self action:@selector(selectGoalAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    rightBtn.adjustsImageWhenHighlighted = NO;

}


#pragma mark - ====================== 各类触发方法 ==========================

-(void)selectCityAction{
    
    CFSelectCityViewController *citySelectCityVC = [[CFSelectCityViewController alloc] init];
    [self.navigationController pushViewController:citySelectCityVC animated:YES];
}

-(void)selectGoalAction{

    CFSearchController *searchVC = [[CFSearchController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    
    
    
}

#pragma mark - ====================== 数据请求方法 ==========================

-(void)finderPageRequest{

    //首页套餐请求
    NSString *parmas = @"area_code=440300&column=appTopicBig%2CappTopicMid%2CbannerSquare%2CbannerRound%2CbannerScroll&system=ios&version=4.2.6&channel=AppStore";

    [CFNetWork networFinderRequest:parmas whileSuccess:^(id responseObject) {
       
        _picArray = responseObject;
 
        [self.picTableView reloadData];
    } orFail:^(id responseObject) {
    
    }];

}

#pragma mark - ====================== 代理方法 ==========================

//组个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_picArray count]-1;
    
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CFFinderPageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
     [cell fillWithModel:_picArray[indexPath.row+1]];
    
    
    return cell;
    
}

//每个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return IphoneHeight / 4;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        CFWebViewController *webCtl = [[CFWebViewController alloc]init];
        webCtl.url = @"http://m.yaochufa.com/funny/v_2207?wdfaxian-app&DeviceToken=(null)&system=ios&version=4.2.7&long=113.953781&lat=22.540976&checkedLocation";
        webCtl.title = @"团购详情";
        [self.navigationController pushViewController:webCtl animated:YES];
}
@end
