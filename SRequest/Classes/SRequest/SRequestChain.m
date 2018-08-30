//
//  SRequestChain.m
//  Pods
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
//  Created by chens on 2018/8/30.
//  
//

#import "SRequestChain.h"

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
