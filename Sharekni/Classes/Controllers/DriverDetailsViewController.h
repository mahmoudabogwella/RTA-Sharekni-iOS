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
@property (weak, nonatomic) IBOutlet UILabel *TPoints;
@property (weak, nonatomic) IBOutlet UILabel *TVehicles;
@property (weak, nonatomic) IBOutlet UILabel *TRoutes;
@property (weak, nonatomic) IBOutlet UILabel *TKM;

@property (weak, nonatomic) IBOutlet UILabel *CO2;

@property (weak, nonatomic) IBOutlet UILabel *GreenPointKmOutLets;
@property (weak, nonatomic) IBOutlet UILabel *KmOutLet;
@property (weak, nonatomic) IBOutlet UILabel *RoutesOutLet;
@property (weak, nonatomic) IBOutlet UILabel *VehiclesOutLet;
@property (weak, nonatomic) IBOutlet UILabel *PointsOutLet;

@property (nonatomic ,strong) MostRideDetails *mostRideDetails ;
@property (nonatomic ,strong) BestDriver *bestDriver ;
@property (nonatomic ,strong) DriverSearchResult *driverSearchResult ;
@property (nonatomic ,assign) BOOL isBestDriver ;
@property (nonatomic ,strong) Ride *joinedRide;

@end