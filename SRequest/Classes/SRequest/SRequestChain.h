//
//  SRequestChain.h
//  AFNetworking
//
//  Created by chens on 2018/8/30.
//

#import <Foundation/Foundation.h>

@class SRequestChain;
@class SRequest;
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
