//
//  CreatedRidesViewController.m
//  sharekni
//
//  Created by Mohamed Abd El-latef on 11/21/15.
//
//

#import "CreatedRidesViewController.h"
#import "Constants.h"
#import "MobAccountManager.h"
#import "DriverRideCell.h"
#import <KVNProgress.h>
#import "RideDetailsViewController.h"
#import "NSObject+Blocks.h"
#import "CreateRideViewController.h"
#import "UIView+Borders.h"
#import <UIColor+Additions.h>


@interface CreatedRidesViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *noResultLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *createdRides;
@property (nonatomic,strong) CreatedRide *toBeDeletedRide;
@end

@implementation CreatedRidesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView];
    
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    
    self.noResultLabel.textColor = Red_UIColor;
    self.noResultLabel.alpha = 0;
    
    self.navigationItem.title = NSLocalizedString(@"Rides Created", nil);
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self configureData];
}

- (void) configureTableView{
    [self.tableView registerClass:[DriverRideCell class] forCellReuseIdentifier:RIDE_CELLID];
    [self.tableView registerNib:[UINib nibWithNibName:@"DriverRideCell" bundle:nil] forCellReuseIdentifier:RIDE_CELLID];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

- (void) configureData{
    __block CreatedRidesViewController  *blockSelf = self;
    [KVNProgress showWithStatus:NSLocalizedString(@"Loading...", nil)];
    
    [[MobAccountManager sharedMobAccountManager] getCreatedRidesWithSuccess:^(NSMutableArray *array) {
        [KVNProgress dismiss];
        blockSelf.createdRides = array;
        if (blockSelf.createdRides.count == 0) {
            blockSelf.noResultLabel.alpha = 1;
        }
        [blockSelf.tableView reloadData];
    } Failure:^(NSString *error) {
        [KVNProgress dismiss];
        [KVNProgress showErrorWithStatus:@"an error occured when getting your created rides."];
        [blockSelf performBlock:^{
            [KVNProgress dismiss];
        } afterDelay:3];
    }];
}

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    return self.createdRides.count;
}

- (DriverRideCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DriverRideCell *rideCell = [[DriverRideCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RIDE_CELLID];
    [rideCell.RouteName addLeftBorderWithColor:Red_UIColor];

    CreatedRide *ride = self.createdRides[indexPath.row];
    __block CreatedRidesViewController *blockSelf = self;
    __block CreatedRide *blockRide = ride;
    [rideCell setCreatedRide:ride];
    
    [rideCell setEditHandler:^{
        CreateRideViewController *editRideViewController = [[CreateRideViewController alloc] initWithNibName:@"CreateRideViewController" bundle:nil];
        editRideViewController.ride = ride;
        [blockSelf.navigationController pushViewController:editRideViewController animated:YES];
        
    }];
    [rideCell setDeleteHandler:^{
        [blockSelf deleteRide:ride];
    }];
    [rideCell setDetailsHandler:^{
        [blockSelf showDetailsViewControllerWithRide:blockRide];
    }];
    return rideCell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CreatedRide *ride = self.createdRides[indexPath.row];
    
}


- (void)deleteRide:(CreatedRide *)ride{
    self.toBeDeletedRide = ride;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Confirm", nil) message:NSLocalizedString(@"Do you want to delete this ride", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:NSLocalizedString(@"Delete", nil), nil];
    [alertView show];
}

- (void)editRide:(CreatedRide *)ride{
    CreateRideViewController *editRideViewController = [[CreateRideViewController alloc] initWithNibName:@"CreateRideViewController" bundle:nil];
    editRideViewController.ride = ride;
    __block CreatedRidesViewController *blockSelf = self;
    [editRideViewController setEditHandler:^{
        [blockSelf configureData];
    }];
    [self.navigationController pushViewController:editRideViewController animated:YES];
}

- (void) showDetailsViewControllerWithRide:(CreatedRide *)createdRide{
    RideDetailsViewController *rideDetails = [[RideDetailsViewController alloc] initWithNibName:@"RideDetailsViewController" bundle:nil];
    rideDetails.createdRide = createdRide ;
    [self.navigationController pushViewController:rideDetails animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [KVNProgress showWithStatus:NSLocalizedString(@"Loading...", nil)];
        __block CreatedRidesViewController *blockSelf = self;
        [[MobAccountManager sharedMobAccountManager] deleteRideWithID:self.toBeDeletedRide.RouteID.stringValue withSuccess:^(BOOL deletedSuccessfully) {
            [KVNProgress dismiss];
            [KVNProgress showSuccessWithStatus:NSLocalizedString(@"Ride Delete successfully.", nil)];
            [blockSelf performBlock:^{
                [KVNProgress dismiss];
                [blockSelf configureData];                
            } afterDelay:3];
            
        } Failure:^(NSString *error) {
            [KVNProgress showErrorWithStatus:NSLocalizedString(@"an error occured when deleting ride", nil)];
            [blockSelf configureData];
            [blockSelf performBlock:^{
                [KVNProgress dismiss];
            } afterDelay:3];
        }];
    }
}



@end
