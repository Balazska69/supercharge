//
//  SCMainViewController.m
//  supercharge
//
//  Created by Balázs Novák on 2017. 12. 21..
//  Copyright © 2017. Balázs Novák. All rights reserved.
//

#import "SCMainViewController.h"
#import "SCStation.h"

@interface SCMainViewController ()

@end

@implementation SCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, kScreenWidth, kScreenHeight - 20.0f)];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView.backgroundColor = [UIColor clearColor];
    tableDelegate = [[SCStationsTableDelegate alloc] init];
    tableView.delegate = tableDelegate;
    tableView.dataSource = tableDelegate;
    [self.view addSubview:tableView];
    
    [self getStationsData];
}

- (void)getStationsData {
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    [kContentManager getStationsWithCompletion:^(NSError *error, NSObject *data) {
        if (data && !error) {
            __block NSInteger fetchedDetailsCount = 0;
            for (SCStation *station in kContentManager.nearStationsArray) {
                [kContentManager getStopDetailsWithStation:station completion:^(NSError *error, NSObject *data) {
                    if (data && !error) {
                        fetchedDetailsCount ++;
                        if (fetchedDetailsCount == kContentManager.nearStationsArray.count) {
                            [activityIndicator stopAnimating];
                            [tableView reloadData];
                        }
                    } else {
                        [activityIndicator stopAnimating];
                        [self showErrorPopUp];
                    }
                }];
            }
        } else {
            [activityIndicator stopAnimating];
            [self showErrorPopUp];
        }
    }];
}

- (void)showErrorPopUp {
    if (!alert) {
        alert = [UIAlertController alertControllerWithTitle:@"Upsz" message:@"Hiba lépett fel a szerverrel való kommunikáció során. Megpróbálod újra." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Újrapróbálom" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [self getStationsData];
            alert = nil;
            
        }];
        UIAlertAction *noButton = [UIAlertAction actionWithTitle:@"Mégsem" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                       exit(0);
                                   }];
        [alert addAction:okButton];
        [alert addAction:noButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
