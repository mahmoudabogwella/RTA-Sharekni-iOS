//
//  MostRideDetailsViewController.h
//  sharekni
//
//  Created by Ahmed Askar on 10/31/15.
//
//

#import <UIKit/UIKit.h>
#import "MostRide.h"
#import "MostRideDetailsDataForPassenger.h"

@interface MostRideDetailsViewControllerForPassenger : UIViewController

@property (nonatomic ,strong) MostRide *ride ;

@property (nonatomic ,weak) IBOutlet UILabel *fromLbl ;
@property (nonatomic ,weak) IBOutlet UILabel *toLbl ;
@property (nonatomic,strong) NSString *fromEmirate;
@property (nonatomic,strong) NSString *fromRegion;
@property (nonatomic,strong) NSString *toEmirate;
@property (nonatomic,strong) NSString *toRegion;
@property (nonatomic,strong) NSString *LanguageIs;
@property (nonatomic,strong) NSString *RouteIDString;
@property (nonatomic,strong) NSString *AccountID;
@property (nonatomic,strong) NSString *FromEmirateID;
@property (nonatomic,strong) NSString *ToEmirateID;
@property (nonatomic,strong) NSString *FromRegionID;
@property (nonatomic,strong) NSString *ToRegionID;
@property (nonatomic,strong) NSString *WebAccountID;
@property (nonatomic,strong) NSString *TheFlag;

@property (nonatomic,strong) NSString *CheckIfCreatRide;

@property (nonatomic ,strong) MostRideDetailsDataForPassenger *driverDetails;

@end
