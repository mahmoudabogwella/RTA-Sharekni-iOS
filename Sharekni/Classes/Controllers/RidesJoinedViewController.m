//
//  RidesJoinedViewController.m
//  sharekni
//
//  Created by Mohamed Abd El-latef on 11/17/15.
//
//

#import "RidesJoinedViewController.h"
#import "Constants.h"
#import <UIColor+Additions.h>
#import "DriverRideCell.h"
#import "Ride.h"
#import "RideDetailsViewController.h"
#import "MobAccountManager.h"
#import <KVNProgress.h>
#import "NSObject+Blocks.h"

#import "UIView+Borders.h"

#define JOINED_RIDE_CELLHEIGHT 210
@interface RidesJoinedViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *rides;
@property (nonatomic,strong) Ride *toBeLeavedRide;
@end

@implementation RidesJoinedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Rides Joined";
    
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];

    [self configureTableView];
    [self configureData];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void) configureTableView{
    [self.tableView registerClass:[DriverRideCell class] forCellReuseIdentifier:RIDE_CELLID];
    [self.tableView registerNib:[UINib nibWithNibName:@"DriverRideCell" bundle:nil] forCellReuseIdentifier:RIDE_CELLID];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

- (void) configureData{
    __block RidesJoinedViewController *blockSelf = self;
    [KVNProgress showWithStatus:NSLocalizedString(@"Loading...", nil)];
    [[MobAccountManager sharedMobAccountManager] getJoinedRidesWithSuccess:^(NSMutableArray *array) {
        [KVNProgress dismiss];
        blockSelf.rides = array;
        [blockSelf.tableView reloadData];
        
    } Failure:^(NSString *error) {
        [blockSelf handleManagerFailure];
    }];
}

- (void) handleManagerFailure{
    [KVNProgress dismiss];
    [KVNProgress showErrorWithStatus:@"Error"];
    [self performBlock:^{
        [KVNProgress dismiss];
    } afterDelay:3];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.rides.count;
}

- (DriverRideCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DriverRideCell *rideCell = [[DriverRideCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RIDE_CELLID];
    [rideCell.RouteName addLeftBorderWithColor:Red_UIColor];
    
    Ride *ride = self.rides[indexPath.row];
    [rideCell setJoinedRide:ride];
    
    __block RidesJoinedViewController *blockSelf = self;
    __block Ride *blockRide = ride;
    

    [rideCell setLeaveHandler:^{
        [blockSelf leaveRide:blockRide];
    }];
    [rideCell setDetailsHandler:^{
        [blockSelf showDetailsViewControllerWithRide:blockRide];
    }];
    [rideCell setDriverHandler:^{
        NSLog(@"not implemented");
    }];
    return rideCell ;
}

#pragma mark -
#pragma mark UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}

- (void)leaveRide:(Ride *)ride{
    self.toBeLeavedRide = ride;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Confirm", nil) message:NSLocalizedString(@"Do you want to leave this ride", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"Leave", nil), nil];
    [alertView show];
}


- (void) showDetailsViewControllerWithRide:(Ride *)createdRide{
    RideDetailsViewController *rideDetails = [[RideDetailsViewController alloc] initWithNibName:@"RideDetailsViewController" bundle:nil];
    rideDetails.joinedRide = createdRide ;
    [self.navigationController pushViewController:rideDetails animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [KVNProgress showWithStatus:NSLocalizedString(@"Loading...", nil)];
        __block RidesJoinedViewController *blockSelf = self;
        [[MobAccountManager sharedMobAccountManager] leaveRideWithID:self.toBeLeavedRide.RouteID.stringValue withSuccess:^(BOOL deletedSuccessfully) {
            [KVNProgress dismiss];
            [KVNProgress showSuccessWithStatus:NSLocalizedString(@"Ride leaved successfully.", nil)];
            [blockSelf performBlock:^{
                [KVNProgress dismiss];
                [blockSelf configureData];
            } afterDelay:3];
            
        } Failure:^(NSString *error) {
            [KVNProgress showErrorWithStatus:NSLocalizedString(@"an error occured when leaving ride", nil)];
            [blockSelf configureData];
            [blockSelf performBlock:^{
                [KVNProgress dismiss];
            } afterDelay:3];
        }];
    }
}


@end
