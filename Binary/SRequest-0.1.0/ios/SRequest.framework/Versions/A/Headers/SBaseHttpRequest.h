//
//  SBaseHttpRequest.h
//  SRequest
//
//  Created by chens on 2018/7/30.
//  Copyright © 2018年 chens. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SRequestConfig.h"
#import "SRequestMacro.h"


typedef NS_ENUM(NSInteger, SHttpRequestActionMethod) {
    SHttpRequestActionType_Get,
    SHttpRequestActionType_Post,
    SHttpRequestActionType_Put,
    SHttpRequestActionType_Delete,
    SHttpRequestActionType_Head,
    SHttpRequestActionType_Patch
};

typedef NS_ENUM(NSInteger, SHttpRequestSerizlization) {
    SHttpRequestSerializerNone,
    SHttpRequestSerializerHttp,
    SHttpRequestSerializerJson,
    SHttpRequestSerializerPropertyList
};

typedef NS_ENUM(NSInteger, SHttpResponseSerialization){
    SHttpResponseSerializationNone,
    SHttpResponseSerializationHttp,
    SHttpResponseSerializationJson,
    SHttpResponseSerializationXML,
    SHttpResponseSerializationPropertyList,
    SHttpResponseSerializationImage
};

typedef NS_ENUM(NSInteger, SHttpRequestSessionState){
    SHttpRequestSessionStateNone = -1,
    SHttpRequestSessionStateRunning = 0,    /* The task is currently being serviced by the session */
    SHttpRequestSessionStateSuspended,
    SHttpRequestSessionStateCanceling,  /* The task has been told to cancel.  The session will receive a URLSession:task:didCompleteWithError: message. */
    SHttpRequestSessionStateCompleted,
};

typedef NS_ENUM(NSInteger, SHttpRequestDataType) {
    SHttpRequestDataTypeNone,
    SHttpRequestDataTypeFile,
    SHttpRequestDataTypeData
};

@protocol SHttpRequestProtocol <NSObject>

@required
- (SHttpRequestActionMethod)requestMethod;
- (NSString *)requestUrl;
- (id)requestParams;
- (void)startRequest;
- (void)cancelRequest;
- (SHttpRequestDataType)requestDataType;
@optional

/**
 默认Http
 */
- (SHttpRequestSerizlization)requestSerizlizationType;

/**
 默认Json
 */
- (SHttpResponseSerialization)responseSerializationType;
- (NSTimeInterval)requestTimeout;
- (NSDictionary *)requestExtendheader;
- (NSString *)requestBaseUrl;
- (NSString *)requestDownloadPath;

/**
 构建上传表单

 @param formData 根据不同的网络库表示不同类型
 */
- (void)constructFormatData:(id)formData;


/**
 特殊设置，以上操作不满足的时候,继承自己实现

 @param mgr 设置的网络类，afnetwork是AFHTTPSessionManager
 */
- (void)requestExtendSet:(id)mgr;

@end


@class SBaseHttpRequest;

@protocol SHttpResponseProtocol <NSObject>

@optional
- (void)httpRequest:(SBaseHttpRequest *)request onFinishedData:(id)data;
- (void)httpRequest:(SBaseHttpRequest *)request onFailed:(NSError *)error;
- (void)httpRequest:(SBaseHttpRequest *)request onProgress:(NSProgress *)progress;

@end


@interface SBaseHttpRequest : NSObject<SHttpRequestProtocol, SHttpResponseProtocol>

@property (nonatomic, weak) NSURLSessionTask *task;

+ (instancetype)httpRequest;

/**
 取消所有请求
 */
- (void)cancelAllRequest;

@end
