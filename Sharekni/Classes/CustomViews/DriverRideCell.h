//
//  DriverRideCell.h
//  sharekni
//
//  Created by Ahmed Askar on 11/4/15.
//
//

#import <UIKit/UIKit.h>
#import "DriverDetails.h"


@interface DriverRideCell : UITableViewCell

@property (nonatomic ,weak) IBOutlet UILabel *RouteName ;
@property (nonatomic ,weak) IBOutlet UIView *containerView ;
@property (nonatomic ,weak) IBOutlet UILabel *FromRegionName ;
@property (nonatomic ,weak) IBOutlet UILabel *ToRegionName ;


- (void)setDriverRideDetails:(DriverDetails *)rideDetails;

@end
