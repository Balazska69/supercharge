//
//  SCStation.m
//  supercharge
//
//  Created by Balázs Novák on 2017. 12. 21..
//  Copyright © 2017. Balázs Novák. All rights reserved.
//

#import "SCStation.h"

@implementation SCStation
@synthesize stopId;
@synthesize stopCode;
@synthesize stopName;
@synthesize stopDirection;
@synthesize stopLatitude;
@synthesize stopLongitude;
@synthesize wheelChairBoarding;
@synthesize parentStation;
@synthesize routesArray;

- (instancetype)initWithDataDictionary:(NSDictionary *)dataDictionary {
    self = [super init];
    
    if (self) {
        if ([dataDictionary objectForKey:@"stop_id"] && [[dataDictionary objectForKey:@"stop_id"] isKindOfClass:[NSString class]]) {
            self.stopId = [dataDictionary objectForKey:@"stop_id"];
        }
        
        if ([dataDictionary objectForKey:@"stop_direction"] && [[dataDictionary objectForKey:@"stop_direction"] isKindOfClass:[NSString class]]) {
            self.stopDirection = [dataDictionary objectForKey:@"stop_direction"];
        }
        
        if ([dataDictionary objectForKey:@"stop_lat"] && [[dataDictionary objectForKey:@"stop_lat"] isKindOfClass:[NSNumber class]]) {
            stopLatitude = [[dataDictionary objectForKey:@"stop_lat"] doubleValue];
        }
        
        if ([dataDictionary objectForKey:@"stop_lon"] && [[dataDictionary objectForKey:@"stop_lon"] isKindOfClass:[NSNumber class]]) {
            stopLongitude = [[dataDictionary objectForKey:@"stop_lon"] doubleValue];
        }
        
        if ([dataDictionary objectForKey:@"stop_code"] && [[dataDictionary objectForKey:@"stop_code"] isKindOfClass:[NSString class]]) {
            self.stopCode = [dataDictionary objectForKey:@"stop_code"];
        }
        
        if ([dataDictionary objectForKey:@"stop_name"] && [[dataDictionary objectForKey:@"stop_name"] isKindOfClass:[NSString class]]) {
            self.stopName = [dataDictionary objectForKey:@"stop_name"];
        }
        
        if ([dataDictionary objectForKey:@"wheelchair_boarding"] && [[dataDictionary objectForKey:@"wheelchair_boarding"] isKindOfClass:[NSNumber class]]) {
            wheelChairBoarding = [[dataDictionary objectForKey:@"wheelchair_boarding"] integerValue];
        }
        
        if ([dataDictionary objectForKey:@"parent_station"] && [[dataDictionary objectForKey:@"parent_station"] isKindOfClass:[NSString class]]) {
            self.parentStation = [dataDictionary objectForKey:@"parent_station"];
        }
    }
    
    return self;
}


- (BOOL)isNearStationFromLation:(CLLocation *)location {
    NSLog(@"%f", [[[CLLocation alloc] initWithLatitude:self.stopLatitude longitude:self.stopLongitude] distanceFromLocation:location]);
    if ([[[CLLocation alloc] initWithLatitude:self.stopLatitude longitude:self.stopLongitude] distanceFromLocation:location] <= 1000.0f) {
        return YES;
    }
    return NO;
}


@end
