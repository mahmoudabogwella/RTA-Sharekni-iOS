//
//  DriverDetailsViewController.h
//  sharekni
//
//  Created by Ahmed Askar on 11/3/15.
//
//

#import <UIKit/UIKit.h>
#import "MostRideDetails.h"
#import "BestDriver.h"
#import "DriverSearchResult.h"
#import "Ride.h"

@interface DriverDetailsViewController : UIViewController

@property (nonatomic ,strong) MostRideDetails *mostRideDetails ;
@property (nonatomic ,strong) BestDriver *bestDriver ;
@property (nonatomic ,strong) DriverSearchResult *driverSearchResult ;
@property (nonatomic ,assign) BOOL isBestDriver ;
@property (nonatomic ,strong) Ride *joinedRide;

@end