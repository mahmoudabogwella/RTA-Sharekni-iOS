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
#define JOINED_RIDE_CELLHEIGHT 210
@interface RidesJoinedViewController ()
@property (nonatomic,strong) NSArray *rides;
@end

@implementation RidesJoinedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.rides.count;
}

- (DriverRideCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier  = @"DriverRideCell";
    
    DriverRideCell *driverCell = (DriverRideCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (driverCell == nil)
    {
        driverCell = (DriverRideCell *)[[[NSBundle mainBundle] loadNibNamed:@"DriverRideCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    Ride *driver = self.rides[indexPath.row];
    [driverCell setRideDetails:driver];
    
    return driverCell ;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Ride *driver = self.rides[indexPath.row];
    RideDetailsViewController *rideDetails = [[RideDetailsViewController alloc] initWithNibName:@"RideDetailsViewController" bundle:nil];
//    rideDetails.driverDetails = driver ;
    [self.navigationController pushViewController:rideDetails animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Driver_Ride_CELLHEIGHT;
}

@end
