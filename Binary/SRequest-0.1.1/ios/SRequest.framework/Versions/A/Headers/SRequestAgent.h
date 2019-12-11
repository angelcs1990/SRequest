//
//  SRequestAgent.h
//  SRequest
//
//  Created by chens on 2018/7/30.
//  Copyright © 2018年 chens. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SBaseHttpRequest.h"

@interface SRequestAgent : NSObject

+ (instancetype)shareInstance;

- (void)startRequest:(SBaseHttpRequest *)request;

- (void)cancelRequest:(SBaseHttpRequest *)request;

- (void)cancelAllRequests;

@end
