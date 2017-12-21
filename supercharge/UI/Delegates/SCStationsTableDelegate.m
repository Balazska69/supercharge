//
//  SCStationsTableDelegate.m
//  supercharge
//
//  Created by Balázs Novák on 2017. 12. 21..
//  Copyright © 2017. Balázs Novák. All rights reserved.
//

#import "SCStationsTableDelegate.h"
#import "SCStation.h"
#import "SCRouteTableViewCell.h"

@implementation SCStationsTableDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return kContentManager.nearStationsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return ((SCStation *)[kContentManager.nearStationsArray objectAtIndex:section]).routesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"routeCell"];
    if (!cell) {
        cell = [[SCRouteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"routeCell"];
    }
    ((SCRouteTableViewCell *)cell).route = [((SCStation *)[kContentManager.nearStationsArray objectAtIndex:indexPath.section]).routesArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 33.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, 33.0f)];
    sectionHeaderView.backgroundColor = [UIColor colorWithWhite:255.0f / 255.0f alpha:1.0f];
    UILabel *sectionHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, CGRectGetWidth(sectionHeaderView.frame) - 40.0f, 33.0f)];
    sectionHeaderLabel.font = [UIFont systemFontOfSize:15.0f];
    sectionHeaderLabel.textColor = [UIColor colorWithWhite:0.0f / 255.0f alpha:0.5f];
    sectionHeaderLabel.textAlignment = NSTextAlignmentLeft;
    sectionHeaderLabel.text = ((SCStation *)[kContentManager.nearStationsArray objectAtIndex:section]).stopName;
    [sectionHeaderView addSubview:sectionHeaderLabel];
    return sectionHeaderView;
}

@end
