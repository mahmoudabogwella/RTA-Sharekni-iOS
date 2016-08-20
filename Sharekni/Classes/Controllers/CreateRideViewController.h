//
//  CreateRideViewController.h
//  sharekni
//
//  Created by Mohamed Abd El-latef on 10/24/15.
//
//

#import <UIKit/UIKit.h>
#import "CreateRideViewController.h"
#import "CreatedRide.h"
#import "RouteDetails.h"

@interface CreateRideViewController : UIViewController

@property (nonatomic,strong) CreatedRide *ride;
@property (strong, nonatomic) RouteDetails *routeDetails;
@property (nonatomic, copy) void (^doneHandler)(void);
@property (nonatomic, copy) void (^editHandler)(void);

@property (nonatomic,strong) NSString *UserID;

@end
