//
//  SCStation.h
//  supercharge
//
//  Created by Balázs Novák on 2017. 12. 21..
//  Copyright © 2017. Balázs Novák. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface SCStation : NSObject

@property (nonatomic, strong) NSString *stopId;
@property (nonatomic, strong) NSString *stopDirection;
@property (nonatomic) double stopLatitude;
@property (nonatomic) double stopLongitude;
@property (nonatomic, strong) NSString *stopCode;
@property (nonatomic) NSInteger wheelChairBoarding;
@property (nonatomic, strong) NSString *stopName;
@property (nonatomic, strong) NSString *parentStation;
@property (nonatomic, strong) NSArray *routesArray;
- (instancetype)initWithDataDictionary:(NSDictionary *)dataDictionary;

- (BOOL)isNearStationFromLation:(CLLocation *)location;

@end
