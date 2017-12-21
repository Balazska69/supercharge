//
//  SCRoute.h
//  supercharge
//
//  Created by Balázs Novák on 2017. 12. 21..
//  Copyright © 2017. Balázs Novák. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    routeTypeBus,
    routeTypeTrolleyBus
} SCRouteType;

@interface SCRoute : NSObject

@property (nonatomic, strong) NSString *routeId;
@property (nonatomic, strong) NSString *routeDescription;
@property (nonatomic, strong) NSString *agencyId;
@property (nonatomic, strong) NSString *shortName;
@property (nonatomic, strong) NSString *longName;
@property (nonatomic, strong) NSString *iconDisplayText;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic) SCRouteType routeType;

- (instancetype)initWithDataDictionary:(NSDictionary *)dataDictionary;

@end
