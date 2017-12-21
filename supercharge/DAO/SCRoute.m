//
//  SCRoute.m
//  supercharge
//
//  Created by Balázs Novák on 2017. 12. 21..
//  Copyright © 2017. Balázs Novák. All rights reserved.
//
#import "SCRoute.h"

@implementation SCRoute
@synthesize routeId;
@synthesize routeDescription;
@synthesize agencyId;
@synthesize shortName;
@synthesize longName;
@synthesize iconDisplayText;
@synthesize textColor;
@synthesize color;
@synthesize routeType;

- (instancetype)initWithDataDictionary:(NSDictionary *)dataDictionary {
    self = [super init];
    
    if (self) {
        if ([dataDictionary objectForKey:@"id"] && [[dataDictionary objectForKey:@"id"] isKindOfClass:[NSString class]]) {
            self.routeId = [dataDictionary objectForKey:@"id"];
        }
        
        if ([dataDictionary objectForKey:@"description"] && [[dataDictionary objectForKey:@"description"] isKindOfClass:[NSString class]]) {
            self.routeDescription = [dataDictionary objectForKey:@"description"];
        }
        
        if ([dataDictionary objectForKey:@"agencyId"] && [[dataDictionary objectForKey:@"agencyId"] isKindOfClass:[NSString class]]) {
            self.agencyId = [dataDictionary objectForKey:@"agencyId"];
        }
        
        if ([dataDictionary objectForKey:@"shortName"] && [[dataDictionary objectForKey:@"shortName"] isKindOfClass:[NSString class]]) {
            self.shortName = [dataDictionary objectForKey:@"shortName"];
        }
        
        if ([dataDictionary objectForKey:@"longName"] && [[dataDictionary objectForKey:@"longName"] isKindOfClass:[NSString class]]) {
            self.longName = [dataDictionary objectForKey:@"longName"];
        }
        
        if ([dataDictionary objectForKey:@"iconDisplayText"] && [[dataDictionary objectForKey:@"iconDisplayText"] isKindOfClass:[NSString class]]) {
            self.iconDisplayText = [dataDictionary objectForKey:@"iconDisplayText"];
        }
        
        if ([dataDictionary objectForKey:@"textColor"] && [[dataDictionary objectForKey:@"textColor"] isKindOfClass:[NSString class]]) {
            self.textColor = [self getUIColorObjectFromHexString:[dataDictionary objectForKey:@"textColor"] alpha:1.0f];
        }
        
        if ([dataDictionary objectForKey:@"color"] && [[dataDictionary objectForKey:@"color"] isKindOfClass:[NSString class]]) {
            self.color = [self getUIColorObjectFromHexString: [dataDictionary objectForKey:@"color"] alpha:1.0f];
        }
        
        if ([dataDictionary objectForKey:@"type"] && [[dataDictionary objectForKey:@"type"] isKindOfClass:[NSString class]]) {
            if ([[[dataDictionary objectForKey:@"type"] uppercaseString] isEqualToString:@"BUS"]) {
                self.routeType = routeTypeBus;
            } else if ([[[dataDictionary objectForKey:@"type"] uppercaseString] isEqualToString:@"TROLLEYBUS"]) {
                self.routeType = routeTypeTrolleyBus;
            }
        }
    }
    
    return self;
}

- (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha {
    // Convert hex string to an integer
    unsigned int hexint = [self intFromHexString:hexStr];
    
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}

- (unsigned int)intFromHexString:(NSString *)hexStr {
    unsigned int hexInt = 0;
    
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}


@end
