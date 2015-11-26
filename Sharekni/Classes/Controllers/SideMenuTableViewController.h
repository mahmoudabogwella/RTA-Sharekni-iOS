//
//  SideMenuTableViewController.h
//  sharekni
//
//  Created by ITWORX on 10/31/15.
//
//

#import <UIKit/UIKit.h>

@interface SideMenuTableViewController : UITableViewController

@property (nonatomic,strong) UINavigationController * homeNavigationController;
@property (nonatomic,strong) UINavigationController * mostRidesNavigationController;
@property (nonatomic,strong) UINavigationController * notificationsNavigationController;
@property (nonatomic,strong) UINavigationController * bestDriversNavigationController;
@property (nonatomic,strong) UINavigationController * searchNavigationController;
@property (nonatomic,strong) UINavigationController * savedSearchNavigationController;


- (instancetype) initWithNavigationController:(UINavigationController *) navigationController;
@end
