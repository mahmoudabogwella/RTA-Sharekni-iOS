//
//  RideDetailsViewController.h
//  sharekni
//
//  Created by Ahmed Askar on 10/31/15.
//
//

#import <UIKit/UIKit.h>
#import "DriverDetails.h"
#import "CreatedRide.h"
@interface RideDetailsViewController : UIViewController

@property (nonatomic ,strong) DriverDetails *driverDetails;
@property (nonatomic ,strong) CreatedRide *createdRide;

@end
