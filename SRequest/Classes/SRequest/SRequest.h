//
//  SRequest.h
//  SRequest
//
//  Created by chens on 2018/7/30.
//  Copyright © 2018年 chens. All rights reserved.
//

#import "SBaseHttpRequest.h"
#import "SRequestChain.h"
#import "SRequestConfig.h"


@class SRequest;

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
