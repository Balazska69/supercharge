//
//  ContentManager.h
//  supercharge
//
//  Created by Balázs Novák on 2017. 12. 21..
//  Copyright © 2017. Balázs Novák. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "SCStation.h"

#define kContentManager [ContentManager getInstance]

typedef void (^AsyncNetworkSuccessCallback)(NSError *error, NSObject *data);

@interface ContentManager : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

+ (ContentManager *)getInstance;

- (void)getStationsWithCompletion:(AsyncNetworkSuccessCallback)completion;
- (void)getStopDetailsWithStation:(SCStation *)station completion:(AsyncNetworkSuccessCallback)completion;

@property (nonatomic, strong) NSArray *nearStationsArray;

@property (nonatomic, strong) CLLocation *myLocation;

@end
