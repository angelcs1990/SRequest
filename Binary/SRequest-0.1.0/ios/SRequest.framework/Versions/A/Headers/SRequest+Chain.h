//
//  SRequest+Chain.h
//  SRequest
//
//  Created by chens on 2018/7/31.
//  Copyright © 2018年 chens. All rights reserved.
//

#import "SRequest.h"

@interface SRequest (Chain)

@property (nonatomic, strong) SRequestChain *chain;

#pragma mark - chain method
+ (instancetype)Get;
+ (instancetype)Post;
+ (instancetype)Put;
+ (instancetype)Delete;
+ (instancetype)Patch;
+ (instancetype)Head;

@end
