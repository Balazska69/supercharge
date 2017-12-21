//
//  SCRouteTableViewCell.h
//  supercharge
//
//  Created by Balázs Novák on 2017. 12. 21..
//  Copyright © 2017. Balázs Novák. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCRoute.h"

@interface SCRouteTableViewCell : UITableViewCell {
    UILabel *titleLabel;
    UILabel *descriptionLabel;
    UIImageView *iconImageView;
    UIView *separatorView;
}

@property (nonatomic, strong) SCRoute *route;

@end
