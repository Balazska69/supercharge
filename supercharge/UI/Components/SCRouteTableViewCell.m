//
//  SCRouteTableViewCell.m
//  supercharge
//
//  Created by Balázs Novák on 2017. 12. 21..
//  Copyright © 2017. Balázs Novák. All rights reserved.
//

#import "SCRouteTableViewCell.h"

@implementation SCRouteTableViewCell
@synthesize route;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor colorWithWhite:0.0f / 255.0f alpha:0.6f];
        titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:titleLabel];
        
        descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.font = [UIFont systemFontOfSize:10.0f];
        descriptionLabel.textAlignment = NSTextAlignmentLeft;
        descriptionLabel.textColor = [UIColor colorWithWhite:0.0f / 255.0f alpha:0.3f];
        descriptionLabel.numberOfLines = 0;
        descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:descriptionLabel];
        
        iconImageView = [[UIImageView alloc] init];
        iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:iconImageView];
        
        
        separatorView = [[UIView alloc] init];
        separatorView.backgroundColor = [UIColor colorWithWhite:0.0f / 255.0f alpha:0.2f];
        [self.contentView addSubview:separatorView];

    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    titleLabel.frame = CGRectMake(12.0f, 0.0f, 50.0f, CGRectGetHeight(self.contentView.frame));
    titleLabel.text = route.shortName;
//    [titleLabel sizeToFit];
    
    descriptionLabel.text = route.routeDescription;
    descriptionLabel.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 10.0f, 0.0f, CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(titleLabel.frame) - 80.0f, CGRectGetHeight(self.contentView.frame));
    
    iconImageView.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - 25.0f - 15.0f, (CGRectGetHeight(self.contentView.frame) - 25.0f) / 2.0f, 25.0f, 25.0f);
    
    separatorView.frame = CGRectMake(12.0f, CGRectGetHeight(self.contentView.frame) - 1.0f, CGRectGetWidth(self.contentView.frame) - 12.0f, 1.0f);
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRoute:(SCRoute *)_route {
    route = _route;
    
    self.contentView.backgroundColor = route.color;
    titleLabel.textColor = route.textColor;
    descriptionLabel.textColor = route.textColor;
    separatorView.backgroundColor = route.textColor;
    
    switch (route.routeType) {
        case routeTypeBus:
            [iconImageView setImage:[UIImage imageNamed:@"busIcon.png"]];
            break;
        case routeTypeTrolleyBus:
            [iconImageView setImage:[UIImage imageNamed:@"trolleybusIcon.png"]];
            break;
        default:
            break;
    }
    
}

@end
