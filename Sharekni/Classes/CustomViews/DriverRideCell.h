//
//  DriverRideCell.h
//  sharekni
//
//  Created by Ahmed Askar on 11/4/15.
//
//

#import <UIKit/UIKit.h>
#import "DriverDetails.h"
#import "Ride.h"

#define RIDE_CELLID @"RIDECELL"

@interface DriverRideCell : UITableViewCell

@property (nonatomic ,weak) IBOutlet UILabel *RouteName ;
@property (nonatomic ,weak) IBOutlet UIView *containerView ;
@property (nonatomic ,weak) IBOutlet UILabel *FromRegionName ;
@property (nonatomic ,weak) IBOutlet UILabel *ToRegionName ;
@property (weak, nonatomic) IBOutlet UIButton *detailsButton;
@property (weak, nonatomic) IBOutlet UIButton *driverButton;
@property (weak, nonatomic) IBOutlet UIButton *leaveButton;


@property (nonatomic,strong) DriverDetails *driverRideDetails;
@property (nonatomic,strong) Ride *rideDetails;

@end
