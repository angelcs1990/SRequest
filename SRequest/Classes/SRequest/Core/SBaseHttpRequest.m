//
//  SBaseHttpRequest.m
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
//  Created by chens on 2018/7/30.
//  Copyright © 2018年 chens. All rights reserved.
//

#import "SBaseHttpRequest.h"

#import "SRequestAgent.h"

@interface SBaseHttpRequest ()


@end

@implementation SBaseHttpRequest

+ (instancetype)httpRequest
{
    return [[self alloc] init];
}

- (void)cancelAllRequest
{
    [[SRequestAgent shareInstance] cancelAllRequests];
}

- (void)dealloc
{
    NSLog(@"dealloc f");
}

#pragma mark - SHttpResponseProtocol
- (void)httpRequest:(SBaseHttpRequest *)request onFinishedData:(id)data
{
    NSAssert(nil, @"子类必须实现");
}

- (void)httpRequest:(SBaseHttpRequest *)request onFailed:(NSError *)error
{
    NSAssert(nil, @"子类必须实现");
}

- (void)httpRequest:(SBaseHttpRequest *)request onProgress:(NSProgress *)progress
{
    NSAssert(nil, @"子类必须实现");
}

#pragma mark - SHttpRequestProtocol
- (void)startRequest
{
    [[SRequestAgent shareInstance] startRequest:self];
//    [self httpRequest:self onFinishedData:@"ssss"];
}

- (void)cancelRequest
{
    [[SRequestAgent shareInstance] cancelRequest:self];
}

- (SHttpRequestActionMethod)requestMethod
{
    return SHttpRequestActionType_Post;
}

- (NSString *)requestUrl
{
    return nil;
}

- (id)requestParams
{
    return nil;
}

- (SHttpRequestDataType)requestDataType
{
    return SHttpRequestDataTypeData;
}

- (SHttpRequestSerizlization)requestSerizlizationType
{
    return SHttpRequestSerializerHttp;
}

- (SHttpResponseSerialization)responseSerializationType
{
    return SHttpResponseSerializationJson;
}

- (NSTimeInterval)requestTimeout
{
    return [SRequestConfig  shareInstance].reqTimeout;
}

- (NSString *)requestDownloadPath
{
    return [SRequestConfig shareInstance].reqDownloadPath;
}

- (void)constructFormatData:(id)formData
{
    
}

- (void)requestExtendSet:(id)mgr
{
    
}

- (NSDictionary *)requestExtendheader
{
    return nil;
}

- (NSString *)requestBaseUrl
{
    return [SRequestConfig shareInstance].reqBaseUrl;
}


@end
