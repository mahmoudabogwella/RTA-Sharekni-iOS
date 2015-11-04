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
@property (nonatomic ,weak) IBOutlet UILabel *FromRegionName ;
@property (nonatomic ,weak) IBOutlet UILabel *ToRegionName ;
@property (nonatomic ,weak) IBOutlet UILabel *startingTime ;
@property (nonatomic ,weak) IBOutlet UILabel *availableDays ;


- (void)setDriverRideDetails:(DriverDetails *)rideDetails;

@end
