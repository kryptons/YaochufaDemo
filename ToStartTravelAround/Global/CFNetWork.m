//
//  Created by 陈文昊 on 16/5/10.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "CFNetWork.h"
#import "AFNetworking.h"
#import "CFMainPageModel.h"
#import "CFSelectCityModel.h"
#import "CFUserInformationModel.h"
#import "CFLocationModel.h"
#import "CFProductModel.h"
#import "CFFinderPageModel.h"
#import "CFAreaLocationModel.h"
#import "CFAroundProductModel.h"
#import "CFDetailPageModel.h"
#import "CFPointsModel.h"


@implementation CFNetWork
/**
 *  首页广告栏请求
 *
 *  @param parmas       字典类型参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+ (void)networkMainBannerRequest:(id)parmas whileSuccess:(SuccessBlock)successBlock orFail:(FailBlock)failBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setQueryStringSerializationWithStyle:ZDDHTTPRequestQueryStringDefaultStyle];
    [manager GET:HOME_ADURL parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *AdModelArr = [NSMutableArray new];
        for (NSDictionary *dic in responseObject[@"content"][0][@"ad"]) {
            CFMainPageModel *mainPageADModel = [[CFMainPageModel alloc]init];
            [mainPageADModel setValuesForKeysWithDictionary:dic[@"ct"]];
            [AdModelArr addObject:mainPageADModel];
        }
        successBlock(AdModelArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
    }];
}
/**
 *  首页广告栏下面的项目请求
 *
 *  @param parmas       字典类型参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+ (void)networkMainItemRequest:(id)parmas whileSuccess:(SuccessBlock)successBlock orFail:(FailBlock)failBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setQueryStringSerializationWithStyle:ZDDHTTPRequestQueryStringDefaultStyle];
    [manager GET:HOME_ADURL parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *AdModelArr = [NSMutableArray new];
        for (NSDictionary *dic in responseObject[@"content"][1][@"ad"]) {
            CFMainPageModel *mainPageADModel = [[CFMainPageModel alloc]init];
            [mainPageADModel setValuesForKeysWithDictionary:dic[@"ct"]];
            [AdModelArr addObject:mainPageADModel];
        }
        successBlock(AdModelArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
    }];

}
/**
 *  首页广告栏下面的套餐请求
 *
 *  @param parmas       字典类型参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+ (void)networkMainPackageRequest:(id)parmas whileSuccess:(SuccessBlock)successBlock orFail:(FailBlock)failBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setQueryStringSerializationWithStyle:ZDDHTTPRequestQueryStringDefaultStyle];
    [manager GET:HOME_ADURL parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *AdModelArr = [NSMutableArray new];
        for (NSDictionary *dic in responseObject[@"content"][2][@"ad"]) {
            CFMainPageModel *mainPageADModel = [[CFMainPageModel alloc]init];
            [mainPageADModel setValuesForKeysWithDictionary:dic[@"ct"]];
            [AdModelArr addObject:mainPageADModel];
        }
        successBlock(AdModelArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
    }];

}
/**
 *  城市定位选择
 *
 *  @param parmas       字典类型参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+ (void)networkCitySelectRequest:(id)parmas whileSuccess:(SuccessBlock)successBlock orFail:(FailBlock)failBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setQueryStringSerializationWithStyle:ZDDHTTPRequestQueryStringDefaultStyle];
    [manager GET:SelectCity_URL parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *AdModelArr = [NSMutableArray new];
        CFSelectCityModel *selectCityModel = [[CFSelectCityModel alloc]init];
        [selectCityModel setValuesForKeysWithDictionary:responseObject[@"data"]];
        [AdModelArr addObject:selectCityModel];
        //这个数组中只有一个元素
        successBlock(AdModelArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
    }];

}


/**
 *  用户登录请求
 *
 *  @param parmas       字典类型参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+(void)networkUserLoginRequest:(id)parmas whileSuccess:(SuccessBlock)successBlock orFail:(FailBlock)failBlock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:kUserLogin_URL parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        successBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
    }];
}

/**
 *  注册页面获取验证码请求
 *
 *  @param parmas       字典类型参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+(void)networkRegisterVerificationCodeRequest:(id)parmas whileSuccess:(SuccessBlock)successBlock orFail:(FailBlock)failBlock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kRsgisterValidateCode_URL  parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        successBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
    }];
}

/**
 *  登录页面获取验证码请求
 *
 *  @param parmas       字典类型参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+(void)networkLoginVerificationCodeRequest:(id)parmas whileSuccess:(SuccessBlock)successBlock orFail:(FailBlock)failBlock{
    
    
    
    
}

/**
 *  注册页面注册请求
 *
 *  @param parmas       字典类型参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+(void)networkUserRegisterRequest:(id)parmas whileSuccess:(SuccessBlock)successBlock orFail:(FailBlock)failBlock{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:kUserRsgister_URL parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        successBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
    }];
    
    
}

/**
 *  反地理编码请求
 *
 *  @param parmas       字典类型参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+(void)networkGeocoderRequest:(id)parmas whileSuccess:(SuccessBlock)successBlock orFail:(FailBlock)failBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setQueryStringSerializationWithStyle:ZDDHTTPRequestQueryStringDefaultStyle];
    [manager GET:GeocoderURL parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *locationInfoArr = [NSMutableArray new];
        
        CFLocationModel *locationModel = [[CFLocationModel alloc]init];
        [locationModel setValuesForKeysWithDictionary:responseObject[@"result"]];
        [locationInfoArr addObject:locationModel];
        //这个数组中只有一个模型
        successBlock(locationInfoArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
    }];
    
}

/**
 *  发现页面请求
 *
 *  @param parmas       字典类型参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+(void)networFinderRequest:(id)parmas whileSuccess:(SuccessBlock)successBlock orFail:(FailBlock)failBlock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setQueryStringSerializationWithStyle:ZDDHTTPRequestQueryStringDefaultStyle];
    [manager GET:kFinderPage_URL parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *picModelArr = [NSMutableArray new];
        for (NSDictionary *dic in responseObject[@"content"][3][@"ad"]) {
            CFFinderPageModel *finderPageModel = [[CFFinderPageModel alloc]init];
            [finderPageModel setValuesForKeysWithDictionary:dic[@"ct"]];
            [picModelArr addObject:finderPageModel];
        }
        successBlock(picModelArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
    }];
}

/**
 *  首页精品推荐
 *
 *  @param parmas       字典类型参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+(void)networkRecommendRequest:(id)parmas whileSuccess:(SuccessBlock)successBlock orFail:(FailBlock)failBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager.requestSerializer setQueryStringSerializationWithStyle:ZDDHTTPRequestQueryStringDefaultStyle];
    [manager GET:HOME_RecommendURL parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *recommendArr = [NSMutableArray new];
        for (NSDictionary *dic in responseObject[@"content"]) {
            CFProductModel *recommendModel = [[CFProductModel alloc]init];
            [recommendModel setValuesForKeysWithDictionary:dic];
            [recommendArr addObject:recommendModel];

        }
       
        successBlock(recommendArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
    }];
    
}
/*  周边地区景点请求
 *
 *  @param parmas       字典类型参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+(void)networkAreaLocationRequest:(id)parmas whileSuccess:(SuccessBlock)successBlock orFail:(FailBlock)failBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:AROUND_CITYURL parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *areaModelArr = [NSMutableArray new];
        for (NSDictionary *dic in responseObject[@"data"][@"provinces"][0][@"cities"]) {
            CFAreaLocationModel *areaModel = [[CFAreaLocationModel alloc]init];
            [areaModel setValuesForKeysWithDictionary:dic];
            [areaModelArr addObject:areaModel];
        }
        successBlock(areaModelArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
        NSLog(@"=================是吧==================");
    }];

}
/*  周边地区旅游产品请求
 *
 *  @param parmas       字典类型参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+(void)networkAroundProductRequest:(id)parmas whileSuccess:(SuccessBlock)successBlock orFail:(FailBlock)failBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:AroundPage_URL parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *aroundProductModelArr = [NSMutableArray new];
        for (NSDictionary *dic in responseObject[@"data"][@"items"]) {
            CFAroundProductModel *aroundProductModel = [[CFAroundProductModel alloc]init];
            [aroundProductModel setValuesForKeysWithDictionary:dic];
            [aroundProductModelArr addObject:aroundProductModel];
        }
        successBlock(aroundProductModelArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
        NSLog(@"=================是吧==================");
    }];
    
}
/*  周边地区详情界面请求
 *
 *  @param parmas       字典类型参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+(void)networkAroundDetailPageRequest:(id)parmas whileSuccess:(SuccessBlock)successBlock orFail:(FailBlock)failBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:AROUND_DETAILURL parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
            CFDetailPageModel *aroundDetailModel = [[CFDetailPageModel alloc]init];
        [aroundDetailModel setValuesForKeysWithDictionary:responseObject[@"data"]];
        successBlock(aroundDetailModel);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
        NSLog(@"=================是吧==================");
    }];
    
}
/**
 *  积分请求
 *
 *  @param parmas       字典类型参数
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+(void)networkMinePointsRequest:(id)parmas whileSuccess:(SuccessBlock)successBlock orFail:(FailBlock)failBlock{
    
    
    //网络请求管理类
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:kMinePoints_URL parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *pointModelArr = [NSMutableArray new];
        
        CFPointsModel *pointModel = [[CFPointsModel alloc]init];
        
        [pointModel setValuesForKeysWithDictionary:responseObject[@"data"]];
        
        [pointModelArr addObject:pointModel];
        
        successBlock(pointModelArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
    }];
    
}

@end
