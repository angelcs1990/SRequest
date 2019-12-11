//
//  SRequestConfig.h
//  SRequest
//
//  Created by chens on 2018/7/30.
//  Copyright © 2018年 chens. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SRequestMacro.h"

SFinal_Class @interface SRequestConfig : NSObject

+ (instancetype)shareInstance;

/**
 请求基地址
 */
@property (nonatomic, copy) NSString *reqBaseUrl;

/**
 请求超时时间
 */
@property (nonatomic, assign) NSTimeInterval reqTimeout;

@property (nonatomic, copy) NSString *reqDownloadPath;

/**打开输出*/
@property (nonatomic, assign) BOOL debugOpen;

@end
