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

#ifndef SChainDefine
#define SChainDefine(_key_name_,_Chain_, _type_ , _block_type_)\
- (_block_type_)_key_name_{\
__weak typeof(self) weakSelf = self;\
if (!_##_key_name_) {\
_##_key_name_ = ^(_type_ value){\
__strong typeof(self) self = weakSelf;\
self.request.sr_##_Chain_ = value;\
return self;\
};\
}\
return _##_key_name_;\
}
#endif


@interface SRequestChainRetBlock ()

@property (nonatomic, weak) SRequest *request;

@end

@implementation SRequestChainRetBlock
S_SYNTHESIZE(successChain);
S_SYNTHESIZE(failureChain);
S_SYNTHESIZE(progressChain);

- (requestChainBlockProgress)progressChain
{
    if (_progressChain == nil) {
        __weak typeof(self) weakSelf = self;
        _progressChain = ^(void(^progress)(NSProgress *progress)){
            __strong typeof(self) self = weakSelf;
            self.request.progress = progress;
            
            return self;
        };
    }
    
    return _progressChain;
}

- (requestChainBlockFailure)failureChain
{
    if (_failureChain == nil) {
        __weak typeof(self) weakSelf = self;
        _failureChain = ^(void(^failed)(NSError *error)){
            __strong typeof(self) self = weakSelf;
            self.request.failed = failed;
            
            return self;
        };
    }
    
    return _failureChain;
}

- (requestChainBlockSuccess)successChain
{
    if (_successChain == nil) {
        __weak typeof(self) weakSelf = self;
        _successChain = ^(void(^success)(id data)){
            __strong typeof(self) self = weakSelf;
            self.request.success = success;
            
            return self;
        };
    }
    
    return _successChain;
}
@end


@interface SRequestChain ()

@property (nonatomic, strong) SRequestChainRetBlock *retBlockChain;

@end

@implementation SRequestChain

S_SYNTHESIZE(requestParamsChain);
S_SYNTHESIZE(requestUrlChain);
//S_SYNTHESIZE(requestMethodChain);
S_SYNTHESIZE(requestBaseUrlChain);
S_SYNTHESIZE(requestTimeoutChain);
S_SYNTHESIZE(requestDataTypeChain);
S_SYNTHESIZE(requestExtendheaderChain);
S_SYNTHESIZE(requestSerizlizationTypeChain);
S_SYNTHESIZE(responseSerializationTypeChain);
S_SYNTHESIZE(requestDownloadPath);
S_SYNTHESIZE(startRequest);
S_SYNTHESIZE(requestConstructFormData);


SChainDefine(requestParamsChain, RequestParams, id, requestObjectChain);
SChainDefine(requestUrlChain, RequestUrl, NSString *, requestObjectChain);
//SChainDefine(requestMethodChain, RequestMethod, SHttpRequestActionMethod, requestIntChain);
SChainDefine(requestDataTypeChain, RequestDataType, SHttpRequestDataType, requestIntChain);
SChainDefine(requestSerizlizationTypeChain, RequestSerializationType, SHttpRequestSerizlization, requestIntChain);
SChainDefine(responseSerializationTypeChain, ResponseSerializationType, SHttpResponseSerialization, requestIntChain);
SChainDefine(requestTimeoutChain, RequestTimeout, NSTimeInterval, requestFloatChain);
SChainDefine(requestExtendheaderChain, RequestExtendHeader, NSDictionary *, requestObjectChain);
SChainDefine(requestBaseUrlChain, RequestBaseUrl, NSString *, requestObjectChain);
SChainDefine(requestDownloadPath, RequestDownloadPath, NSString *, requestObjectChain);

- (requestObjectChain)requestConstructFormData
{
    if (_requestConstructFormData == nil) {
        __weak typeof(self) weakSelf = self;
        _requestConstructFormData = ^(id value){
            __strong typeof(self) self = weakSelf;
            [self.request constructFormatData:value];
            return self;
        };
    }
    
    return _requestConstructFormData;
}

- (SRequestChainRetBlock *)retBlockChain
{
    if (_retBlockChain == nil) {
        _retBlockChain = [SRequestChainRetBlock new];
        
        _retBlockChain.request = self.request;
    }
    
    return _retBlockChain;
}

- (requestEndChain)startRequest
{
    if (_startRequest == nil) {
        __weak typeof(self) weakSelf = self;
        _startRequest = ^{
            __strong typeof(self) self = weakSelf;
            [self.request startRequest];
            
            return self.retBlockChain;
        };
    }
    
    return _startRequest;
}


@end

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
    if (self.success) {
        self.success(data);
    }
}

- (void)httpRequest:(SBaseHttpRequest *)request onFailed:(NSError *)error
{
//    NSAssert(nil, @"子类必须实现");
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
