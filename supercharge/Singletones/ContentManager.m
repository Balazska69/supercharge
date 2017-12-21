//
//  ContentManager.m
//  supercharge
//
//  Created by Balázs Novák on 2017. 12. 21..
//  Copyright © 2017. Balázs Novák. All rights reserved.
//

#import "ContentManager.h"
#import "SCRoute.h"

@implementation ContentManager
@synthesize nearStationsArray;
@synthesize myLocation;

+ (ContentManager *)getInstance {
    static dispatch_once_t pred;
    __strong static id sharedInstance = nil;
    dispatch_once( &pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self != nil) {
        myLocation = [[CLLocation alloc] initWithLatitude:47.497509 longitude:19.054193];
        
    }
    return self;
}

- (void)getStationsWithCompletion:(AsyncNetworkSuccessCallback)completion {
    [kNetworkManager getStationsWithCompletion:^(NSError *error, NSObject *data) {
        if (!error && data) {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:(NSData *)data options:NSJSONReadingMutableContainers error:nil];
            NSMutableArray *tempStationsArray = [NSMutableArray new];
            for (NSDictionary *stationDictionary in responseDictionary) {
                SCStation *station = [[SCStation alloc] initWithDataDictionary:stationDictionary];
                if ([station isNearStationFromLation:myLocation]) {
                    [tempStationsArray addObject:station];
                }
            }
            self.nearStationsArray = [NSArray arrayWithArray:tempStationsArray];
            return completion(nil, nearStationsArray);
        } else {
            return completion(error, nil);
        }
    }];
}

- (void)getStopDetailsWithStation:(SCStation *)station completion:(AsyncNetworkSuccessCallback)completion {
    [kNetworkManager getStopDetailsWithStopID:station.stopId completion:^(NSError *error, NSObject *data) {
        if (!error && data) {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:(NSData *)data options:NSJSONReadingMutableContainers error:nil];
            if ([[responseDictionary objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([[[responseDictionary objectForKey:@"data"] objectForKey:@"references"] objectForKey:@"routes"] && [[[[responseDictionary objectForKey:@"data"] objectForKey:@"references"] objectForKey:@"routes"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *routesDictionary = [[[responseDictionary objectForKey:@"data"] objectForKey:@"references"] objectForKey:@"routes"];
                    
                    NSMutableArray *tempRoutesArray = [NSMutableArray new];
                    for (NSString *routeDictionaryKey in [routesDictionary allKeys]) {
                        SCRoute *route = [[SCRoute alloc] initWithDataDictionary:[routesDictionary objectForKey:routeDictionaryKey]];
                        [tempRoutesArray addObject:route];
                    }
                    station.routesArray = [NSArray arrayWithArray:tempRoutesArray];
                    NSLog(@"he");
                }
            }
            return completion(nil, responseDictionary);
        } else {
            return completion(error, nil);
        }
    }];
}

@end
