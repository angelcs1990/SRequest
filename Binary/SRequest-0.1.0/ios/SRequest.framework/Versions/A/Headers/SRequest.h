//
//  SRequest.h
//  SRequest
//
//  Created by chens on 2018/7/30.
//  Copyright © 2018年 chens. All rights reserved.
//

#import "SBaseHttpRequest.h"

@class SRequest;
@class SRequestChain;
@class SRequestChainRetBlock;


typedef SRequestChain *(^requestObjectChain)(id value);
typedef SRequestChain *(^requestFloatChain)(double value);
typedef SRequestChain *(^requestIntChain)(NSInteger value);
typedef SRequestChainRetBlock *(^requestEndChain)(void);

typedef SRequestChainRetBlock *(^requestChainBlockSuccess)(void(^success)(id data));
typedef SRequestChainRetBlock *(^requestChainBlockFailure)(void(^failed)(NSError *error));
typedef SRequestChainRetBlock *(^requestChainBlockProgress)(void(^progress)(NSProgress *progress));

@interface SRequestChainRetBlock : NSObject

@property (nonatomic, copy, readonly) requestChainBlockSuccess successChain;

@property (nonatomic, copy, readonly) requestChainBlockFailure failureChain;

@property (nonatomic, copy, readonly) requestChainBlockProgress progressChain;

@end


@interface SRequestChain : NSObject

@property (nonatomic, weak) SRequest *request;

@property (nonatomic, copy, readonly) requestObjectChain requestParamsChain;

@property (nonatomic, copy, readonly) requestObjectChain requestUrlChain;

//@property (nonatomic, copy, readonly) requestIntChain requestMethodChain;

@property (nonatomic, copy, readonly) requestIntChain requestDataTypeChain;

@property (nonatomic, copy, readonly) requestIntChain requestSerizlizationTypeChain;

@property (nonatomic, copy, readonly) requestIntChain responseSerializationTypeChain;

@property (nonatomic, copy, readonly) requestFloatChain requestTimeoutChain;

@property (nonatomic, copy, readonly) requestObjectChain requestExtendheaderChain;

@property (nonatomic, copy, readonly) requestObjectChain requestBaseUrlChain;

@property (nonatomic, copy, readonly) requestObjectChain requestDownloadPath;

@property (nonatomic, copy, readonly) requestObjectChain requestConstructFormData;

@property (nonatomic, copy, readonly) requestEndChain startRequest;

@end

@interface SRequest : SBaseHttpRequest

@property (nonatomic, strong) id sr_RequestParams;

@property (nonatomic, copy) NSString *sr_RequestUrl;

@property (nonatomic, assign) SHttpRequestDataType sr_RequestDataType;

@property (nonatomic, assign) SHttpRequestSerizlization sr_RequestSerializationType;

@property (nonatomic, assign) SHttpResponseSerialization sr_ResponseSerializationType;

@property (nonatomic, assign) NSTimeInterval sr_RequestTimeout;

@property (nonatomic, strong) NSDictionary *sr_RequestExtendHeader;

@property (nonatomic, copy) NSString *sr_RequestBaseUrl;

@property (nonatomic, copy) NSString *sr_RequestDownloadPath;

@property (nonatomic, copy) void(^success)(id data);

@property (nonatomic, copy) void(^failed)(NSError *error);

@property (nonatomic, copy) void(^progress)(NSProgress *progress);

+ (instancetype)requestWithMethod:(SHttpRequestActionMethod)method url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id data))success failed:(void (^)(NSError *error))failed;


+ (instancetype)Get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id data))success failed:(void (^)(NSError *error))failed;

+ (instancetype)Post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id data))success failed:(void (^)(NSError *error))failed;;

+ (instancetype)Put:(NSString *)url params:(NSDictionary *)params success:(void (^)(id data))success failed:(void (^)(NSError *error))failed;;

+ (instancetype)Delete:(NSString *)url params:(NSDictionary *)params success:(void (^)(id data))success failed:(void (^)(NSError *error))failed;;

+ (instancetype)Patch:(NSString *)url params:(NSDictionary *)params success:(void (^)(id data))success failed:(void (^)(NSError *error))failed;;

+ (instancetype)Head:(NSString *)url params:(NSDictionary *)params success:(void (^)(id data))success failed:(void (^)(NSError *error))failed;;

@end
