//
//  SRequest+Chain.m
//  SRequest
//
//  Created by chens on 2018/7/31.
//  Copyright © 2018年 chens. All rights reserved.
//

#import "SRequest+Chain.h"

#import <objc/runtime.h>

@implementation SRequest (Chain)

+ (instancetype)Get
{
    return [self requestWithMethod:SHttpRequestActionType_Get url:nil params:nil success:nil failed:nil];
}

+ (instancetype)Post
{
    return [self requestWithMethod:SHttpRequestActionType_Post url:nil params:nil success:nil failed:nil];
}

+ (instancetype)Put
{
    return [self requestWithMethod:SHttpRequestActionType_Put url:nil params:nil success:nil failed:nil];
}

+ (instancetype)Delete
{
    return [self requestWithMethod:SHttpRequestActionType_Delete url:nil params:nil success:nil failed:nil];
}

+ (instancetype)Patch
{
    return [self requestWithMethod:SHttpRequestActionType_Patch url:nil params:nil success:nil failed:nil];
}

+ (instancetype)Head
{
    return [self requestWithMethod:SHttpRequestActionType_Head url:nil params:nil success:nil failed:nil];
}

- (SRequestChain *)chain
{
    SRequestChain *errView = objc_getAssociatedObject(self, @selector(chain));
    if (errView == nil) {
        errView = [SRequestChain new];
        errView.request = self;

        objc_setAssociatedObject(self, _cmd, errView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return errView;
}

- (void)setChain:(SRequestChain *)chain
{
    objc_setAssociatedObject(self, _cmd, chain, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
