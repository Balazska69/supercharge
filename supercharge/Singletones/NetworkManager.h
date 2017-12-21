//
//  NetworkManager.h
//  supercharge
//
//  Created by Balázs Novák on 2017. 12. 21..
//  Copyright © 2017. Balázs Novák. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNetworkManager [NetworkManager getInstance]

typedef void (^AsyncNetworkSuccessCallback)(NSError *error, NSObject *data);

@interface NetworkManager : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

+ (NetworkManager *)getInstance;

- (void)getXmasDailyStatusesWithCompletion:(AsyncNetworkSuccessCallback)completion;

@end
