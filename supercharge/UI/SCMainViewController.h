//
//  SCMainViewController.h
//  supercharge
//
//  Created by Balázs Novák on 2017. 12. 21..
//  Copyright © 2017. Balázs Novák. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCStationsTableDelegate.h"

@interface SCMainViewController : UIViewController {
    UITableView *tableView;
    SCStationsTableDelegate *tableDelegate;
    UIActivityIndicatorView *activityIndicator;
    UIAlertController *alert;
}

@end
