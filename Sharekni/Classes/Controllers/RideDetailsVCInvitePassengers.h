//
//  RideDetailsVCInvitePassengers.h
//  sharekni
//
//  Created by killvak on 3/3/16.
//
//

#import <UIKit/UIKit.h>
#import "DriverDetails.h"
#import "CreatedRide.h"
#import "Ride.h"
@interface RideDetailsVCInvitePassengers : UIViewController

@property (nonatomic ,strong) DriverDetails *driverDetails;
@property (nonatomic ,strong) CreatedRide *createdRide;
@property (nonatomic ,strong) Ride *joinedRide;

@property (nonatomic,strong) NSString *ShareLink;//unUsed
@property (nonatomic,strong) NSString *RouteName;


@end