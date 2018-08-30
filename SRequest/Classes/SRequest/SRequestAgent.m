//
//  SRequestAgent.m
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

#import "SRequestAgent.h"

#import "AFNetworking.h"

#define SHttpSessionMgr mgr
#define SHttpRequestAction(_action) [SHttpSessionMgr _action


@interface SRequestAgent ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionMgr;

@end

@implementation SRequestAgent

+ (instancetype)shareInstance
{
    static SRequestAgent *agent;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        agent = [SRequestAgent new];
    });
    
    return agent;
}

- (void)startRequest:(SBaseHttpRequest *)request
{
    AFHTTPSessionManager *sessionMgr = [self genSessionManagerWithRequest:request];
    
    //请求方法
    SHttpRequestActionMethod method = [request requestMethod];
    id params = [request requestParams];
    NSString *url = [SRequestAgent contructUrlWithRequest:request];
    
    //额外参数设置
    
    switch (method) {
        case SHttpRequestActionType_Get:
        {
            if ([request requestDataType] == SHttpRequestDataTypeData) {
                //普通请求
                request.task = [sessionMgr GET:url
                                    parameters:params
                                      progress:^(NSProgress * _Nonnull downloadProgress) {
                                          [self handleProgressWithRequest:request andProgress:downloadProgress];
                                      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                          [self handleSuccessWithRequest:request andResponseData:responseObject];
                                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                          [self handleErrorWithRequest:request andError:error];
                                      }];
            } else {
                //文件下载等
                NSURL *webUrl = [NSURL URLWithString:url];
                NSURLRequest *requestDownloadUrl = [NSURLRequest requestWithURL:webUrl];
                request.task = [sessionMgr downloadTaskWithRequest:requestDownloadUrl
                                                          progress:^(NSProgress * _Nonnull downloadProgress) {
                                                              [self handleProgressWithRequest:request andProgress:downloadProgress];
                                                          } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                                              return [SRequestAgent constructDownloadPathWithRequest:request];
                                                          } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                                              [self handleSuccessWithRequest:request andResponseData:filePath.absoluteString];
                                                          }];
            }
            
        }
            break;
        case SHttpRequestActionType_Put:
        {
            request.task = [sessionMgr PUT:url
                 parameters:params
                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        [self handleSuccessWithRequest:request andResponseData:responseObject];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [self handleErrorWithRequest:request andError:error];
                    }];
        }
            break;
        case SHttpRequestActionType_Post:
        {
            if ([request requestDataType] == SHttpRequestDataTypeData) {
                //data
                request.task = [sessionMgr POST:url
                      parameters:params
                        progress:^(NSProgress * _Nonnull uploadProgress) {
                            [self handleProgressWithRequest:request andProgress:uploadProgress];
                        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            [self handleSuccessWithRequest:request andResponseData:responseObject];
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            [self handleErrorWithRequest:request andError:error];
                        }];
            } else {
                //file
                void (^bodyContructBlock)(id <AFMultipartFormData> formData) = ^(id <AFMultipartFormData> formData){
                    [request constructFormatData:formData];
                };
                request.task = [sessionMgr POST:url
                      parameters:params
       constructingBodyWithBlock:bodyContructBlock
                        progress:^(NSProgress * _Nonnull uploadProgress) {
                            [self handleProgressWithRequest:request andProgress:uploadProgress];
                        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            [self handleSuccessWithRequest:request andResponseData:responseObject];
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            [self handleErrorWithRequest:request andError:error];
                        }];
            }
        }
            break;
        case SHttpRequestActionType_Patch:
        {
            request.task = [sessionMgr PATCH:url
                   parameters:params
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                          [self handleSuccessWithRequest:request andResponseData:responseObject];
                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          [self handleErrorWithRequest:request andError:error];
                      }];
        }
            break;
        case SHttpRequestActionType_Head:
        {
            request.task = [sessionMgr HEAD:url
                  parameters:params
                     success:^(NSURLSessionDataTask * _Nonnull task) {
                         [self handleSuccessWithRequest:request andResponseData:nil];
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         [self handleErrorWithRequest:request andError:error];
                     }];
        }
            break;
        case SHttpRequestActionType_Delete:
        {
            request.task = [sessionMgr DELETE:url
                    parameters:params
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                           [self handleSuccessWithRequest:request andResponseData:responseObject];
                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                           [self handleErrorWithRequest:request andError:error];
                       }];
        }
            break;
        default:
            break;
    }
    
}

- (void)cancelRequest:(SBaseHttpRequest *)request
{
    [request.task cancel];
}

- (void)cancelAllRequests
{
    [self.sessionMgr.operationQueue cancelAllOperations];
}

#pragma mark - handle
- (void)handleSuccessWithRequest:(SBaseHttpRequest *)request andResponseData:(id)responseData
{
    [request httpRequest:request onFinishedData:responseData];
}

- (void)handleErrorWithRequest:(SBaseHttpRequest *)request andError:(NSError *)error
{
    [request httpRequest:request onFailed:error];
}

- (void)handleProgressWithRequest:(SBaseHttpRequest *)request andProgress:(NSProgress *)progress
{
    [request httpRequest:request onProgress:progress];
}

#pragma mark - private
+ (NSURL *)constructDownloadPathWithRequest:(SBaseHttpRequest *)request
{
    NSString *downloadPath = [request requestDownloadPath];
    
    if ([downloadPath hasPrefix:@"file://"]) {
        return [NSURL URLWithString:downloadPath];
    }
    
    return [NSURL fileURLWithPath:downloadPath];
}

+ (NSString *)contructUrlWithRequest:(SBaseHttpRequest *)request
{
    if (request.requestUrl == nil || request.requestUrl.length == 0) {
        return request.requestBaseUrl;
    }
    NSString *ret = [NSString stringWithFormat:@"%@%@", request.requestBaseUrl, request.requestUrl];
    return [ret stringByReplacingOccurrencesOfString:@"\\" withString:@"\\"];
}

- (AFHTTPSessionManager *)genSessionManagerWithRequest:(SBaseHttpRequest *)request
{
    if (self.sessionMgr == nil) {
        self.sessionMgr = [AFHTTPSessionManager manager];
    }
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    AFHTTPSessionManager *mgr = self.sessionMgr;
    mgr.requestSerializer = [SRequestAgent requestSerializerFromType:request.requestSerizlizationType];
    mgr.responseSerializer = [SRequestAgent responseSerializerFromType:request.responseSerializationType];
    mgr.requestSerializer.timeoutInterval = request.requestTimeout;
    
    //header 设置
    NSDictionary *headerFieldDic = [request requestExtendheader];
    if (headerFieldDic) {
        [headerFieldDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([key isKindOfClass:[NSString class]] && [obj isKindOfClass:[NSString class]]) {
                [mgr.requestSerializer setValue:obj forHTTPHeaderField:key];
            }
        }];
    }
    
    //特殊设置
    [request requestExtendSet:mgr];
    
    return mgr;
}

+ (AFHTTPResponseSerializer *)responseSerializerFromType:(SHttpResponseSerialization)type
{
    switch (type) {
        case SHttpResponseSerializationJson:
            return [AFJSONResponseSerializer serializer];
        case SHttpResponseSerializationXML:
            return [AFXMLParserResponseSerializer serializer];
        case SHttpResponseSerializationHttp:
            return [AFHTTPResponseSerializer serializer];
        case SHttpResponseSerializationImage:
            return [AFImageResponseSerializer serializer];
        case SHttpResponseSerializationPropertyList:
            return [AFPropertyListResponseSerializer serializer];
            
        default:
            return nil;
    }
}

+ (AFHTTPRequestSerializer *)requestSerializerFromType:(SHttpRequestSerizlization)type
{
    switch (type) {
        case SHttpRequestSerializerHttp:
            return [AFHTTPRequestSerializer serializer];
        case SHttpRequestSerializerJson:
            return [AFJSONRequestSerializer serializer];
        case SHttpRequestSerializerPropertyList:
            return [AFPropertyListRequestSerializer serializer];
        default:
            return nil;
    }
}

@end
