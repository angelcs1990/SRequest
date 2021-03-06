//
//  SDemoBaseRequest.m
//  SRequest
//
//      ┏┓   ┏┓
//    ┏━┛┻━━━┻┻━┓
//    ┃         ┃
//    ┃    ━    ┃
//    ┃  ┳┛ ┗┳  ┃
//    ┃         ┃
//    ┃    ┻    ┃
//    ┃         ┃
//    ┗━┓     ┏━┛  Codes are far away from bugs with the animal protecting
//      ┃     ┃    神兽保佑,代码无bug
//      ┃     ┃
//      ┃     ┗━━━┓
//      ┃         ┣┓
//      ┃        ┏┛
//      ┗┓┓┏━┳┓┏┛
//       ┃┫┫ ┃┫┫
//       ┗┻┛ ┗┻┛
//
//  Created by chens on 2018/8/29.
//  Copyright © 2018年 angelcs1990@sohu.com. All rights reserved.
//

#import "SDemoBaseRequest.h"

#import <AFNetworking/AFNetworking.h>
@interface SDemoBaseRequest ()

@end

@implementation SDemoBaseRequest
{
    BOOL _needToken;
}

- (instancetype)setNeedToken
{
    _needToken = YES;
    return self;
}

- (NSDictionary *)requestExtendheader
{
    NSDictionary *dic = [super requestExtendheader];
    NSMutableDictionary *retDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    if (_needToken) {
        [retDic setValue:@"cssssssscc" forKey:@"token"];
    }
    
    return retDic;
}


- (void)requestExtendSet:(id)mgr
{
    if ([mgr isKindOfClass:[AFHTTPSessionManager class]]) {
        
    }
}

- (id)requestHandleSuccessData:(id)data
{
    NSLog(@"截取到中间");
    return data;
}
//- (NSString *)requestBaseUrl
//{
//    return @"https://www.sojson.com";
//}

@end
