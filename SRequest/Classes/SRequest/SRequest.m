//
//  SRequest.m
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

#import "SRequest.h"



@interface SRequest ()



@property (nonatomic, assign) SHttpRequestActionMethod sr_RequestMethod;

@end

@implementation SRequest

+ (instancetype)requestWithMethod:(SHttpRequestActionMethod)method url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id data))success failed:(void (^)(NSError *error))failed
{
    SRequest *request = [[self alloc] init];
    request.sr_RequestParams = (id)params;
    request.sr_RequestUrl = url;
    request.sr_RequestMethod = method;
    request.success = [success copy];
    request.failed = [failed copy];
    
    return request;
}

+ (instancetype)requestWithMethod:(SHttpRequestActionMethod)method url:(NSString *)url params:(NSDictionary *)params
{
    return [self requestWithMethod:method url:url params:params success:nil failed:nil];
}

+ (instancetype)Get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failed:(void (^)(NSError *))failed
{
    return [self requestWithMethod:SHttpRequestActionType_Get url:url params:params success:success failed:failed];
}

+ (instancetype)Post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id data))success failed:(void (^)(NSError *error))failed;
{
    return [self requestWithMethod:SHttpRequestActionType_Post url:url params:params success:success failed:failed];
}

+ (instancetype)Put:(NSString *)url params:(NSDictionary *)params success:(void (^)(id data))success failed:(void (^)(NSError *error))failed;
{
    return [self requestWithMethod:SHttpRequestActionType_Put url:url params:params success:success failed:failed];
}

+ (instancetype)Delete:(NSString *)url params:(NSDictionary *)params success:(void (^)(id data))success failed:(void (^)(NSError *error))failed;
{
    return [self requestWithMethod:SHttpRequestActionType_Delete url:url params:params success:success failed:failed];
}

+ (instancetype)Patch:(NSString *)url params:(NSDictionary *)params success:(void (^)(id data))success failed:(void (^)(NSError *error))failed;
{
    return [self requestWithMethod:SHttpRequestActionType_Patch url:url params:params success:success failed:failed];
}

+ (instancetype)Head:(NSString *)url params:(NSDictionary *)params success:(void (^)(id data))success failed:(void (^)(NSError *error))failed;
{
    return [self requestWithMethod:SHttpRequestActionType_Head url:url params:params success:success failed:failed];
}

#pragma mark - SHttpResponseProtocol
- (void)httpRequest:(SBaseHttpRequest *)request onFinishedData:(id)data
{
//    NSAssert(nil, @"子类必须实现");
    id retData = data;
    if ([self respondsToSelector:@selector(requestHandleSuccessData:)]) {
        retData = [self requestHandleSuccessData:data];
    }
    if (self.success) {
        self.success(retData);
    }
}

- (void)httpRequest:(SBaseHttpRequest *)request onFailed:(NSError *)error
{
//    NSAssert(nil, @"子类必须实现");
//    NSError *retError = error;
    if ([self respondsToSelector:@selector(requestHandleFailedData:)]) {
        [self requestHandleFailedData:error];
    }
    if (self.failed) {
        self.failed(error);
    }
}

- (void)httpRequest:(SBaseHttpRequest *)request onProgress:(NSProgress *)progress
{
//    NSAssert(nil, @"子类必须实现");
    if (self.progress) {
        self.progress(progress);
    }
}

#pragma mark - SHttpRequestProtocol
- (SHttpRequestActionMethod)requestMethod
{
    return self.sr_RequestMethod;
}

- (NSString *)requestUrl
{
    return self.sr_RequestUrl;
}

- (id)requestParams
{
    return self.sr_RequestParams;
}

- (NSString *)requestDownloadPath
{
    return self.sr_RequestDownloadPath;
}

- (SHttpRequestDataType)requestDataType
{
    return self.sr_RequestDataType;
}

- (SHttpRequestSerizlization)requestSerizlization
{
    return self.sr_RequestSerializationType;
}

- (SHttpResponseSerialization)responseSerialization
{
    return self.sr_ResponseSerializationType;
}

- (NSTimeInterval)requestTimeout
{
    return self.sr_RequestTimeout;
}

- (NSDictionary *)requestExtendheader
{
    return self.sr_RequestExtendHeader;
}

- (NSString *)requestBaseUrl
{
    return self.sr_RequestBaseUrl;
}

#pragma mark - lazy
- (NSString *)sr_RequestBaseUrl
{
    if (_sr_RequestBaseUrl == nil) {
        _sr_RequestBaseUrl = [super requestBaseUrl];
    }
    
    return _sr_RequestBaseUrl;
}

- (NSTimeInterval)sr_RequestTimeout
{
    if (_sr_RequestTimeout == 0) {
        _sr_RequestTimeout = [super requestTimeout];
    }
    
    return _sr_RequestTimeout;
}

- (SHttpRequestDataType)sr_RequestDataType
{
    if (_sr_RequestDataType == SHttpRequestDataTypeNone) {
        _sr_RequestDataType = [super requestDataType];
    }
    
    return _sr_RequestDataType;
}

- (SHttpResponseSerialization)sr_ResponseSerializationType
{
    if (_sr_ResponseSerializationType == SHttpResponseSerializationNone) {
        _sr_ResponseSerializationType = [super responseSerializationType];
    }
    
    return _sr_ResponseSerializationType;
}

- (SHttpRequestSerizlization)sr_RequestSerializationType
{
    if (_sr_RequestSerializationType == SHttpRequestSerializerNone) {
        _sr_RequestSerializationType = [super requestSerizlizationType];
    }
    
    return _sr_RequestSerializationType;
}

@end
