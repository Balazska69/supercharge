//
//  ContentManager.m
//  supercharge
//
//  Created by Balázs Novák on 2017. 12. 21..
//  Copyright © 2017. Balázs Novák. All rights reserved.
//

#import "ContentManager.h"

@implementation ContentManager

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
        
    }
    return self;
}

- (void)getXmasDailyStatusesWithCompletion:(AsyncNetworkSuccessCallback)completion {
    [kNetworkManager getXmasDailyStatusesWithCompletion:^(NSError *error, NSObject *data) {
        if (!error && data) {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:(NSData *)data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *xmasCalendarResponseDictionary = [[[responseDictionary objectForKey:@"page"] objectForKey:@"app"] objectForKey:@"app"];
            NSMutableArray *tempAdventDaysArray = [NSMutableArray new];
            if ([xmasCalendarResponseDictionary objectForKey:@"result"] && [[xmasCalendarResponseDictionary objectForKey:@"result"] isEqualToString:@"Success"]) {
//                for (NSDictionary *adventDayDictionary in [xmasCalendarResponseDictionary objectForKey:@"day"]) {
//                    MTAdventDay *adventDay = [[MTAdventDay alloc] initWithJSONDictionary:adventDayDictionary];
//                    [tempAdventDaysArray addObject:adventDay];
//                }
            }
//            self.xmasCalendarDays = [NSArray arrayWithArray:tempAdventDaysArray];
            return completion(nil, responseDictionary);
        } else {
            return completion(error, nil);
        }
    }];
}


@end
