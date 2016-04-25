//
//  MostRideDetailsDataForPassenger.h
//  sharekni
//
//  Created by killvak on 2/26/16.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MostRideDetailsDataForPassenger : NSObject
@property (nonatomic,strong) NSString *DriverRouteId;
@property (nonatomic,strong) NSString *RouteArName;
@property (nonatomic,strong) NSString *RouteEnName;
@property (nonatomic,strong) NSString *NoOfSeats;
@property (nonatomic,strong) NSString *AccountId;
@property (nonatomic,strong) NSString *PassengerName;
@property (nonatomic,strong) NSString *PassengerMobile;
@property (nonatomic,strong) NSString *PassengerPhoto;
@property (nonatomic,strong) NSString *DriverPhoto;

@property (nonatomic,strong) NSString *Rating;

@property (nonatomic,strong) NSString *NationalityArName;
@property (nonatomic,strong) NSString *NationlityEnName;
@property (nonatomic,strong) NSString *NationlityFrName;
@property (nonatomic,strong) NSString *NationlityChName;
@property (nonatomic,strong) NSString *NationlityUrName;

@property (nonatomic,strong) NSString *FromEmirateId;
@property (nonatomic,strong) NSString *ToEmirateId;
@property (nonatomic,strong) NSString *FromRegionId;
@property (nonatomic,strong) NSString *ToRegionId;

@property (nonatomic,strong) NSString *FromEmirateArName;
@property (nonatomic,strong) NSString *FromEmirateEnName;
@property (nonatomic,strong) NSString *FromEmirateNameFr;
@property (nonatomic,strong) NSString *FromEmirateNameCh;
@property (nonatomic,strong) NSString *FromEmirateNameUr;

@property (nonatomic,strong) NSString *ToEmirateArName;
@property (nonatomic,strong) NSString *ToEmirateEnName;
@property (nonatomic,strong) NSString *ToEmirateNameFr;
@property (nonatomic,strong) NSString *ToEmirateNameCh;
@property (nonatomic,strong) NSString *ToEmirateNameUr;

@property (nonatomic,strong) NSString *FromRegionArName;
@property (nonatomic,strong) NSString *FromRegionEnName;
@property (nonatomic,strong) NSString *FromRegionNameFr;
@property (nonatomic,strong) NSString *FromRegionNameCh;
@property (nonatomic,strong) NSString *FromRegionNameUr;

@property (nonatomic,strong) NSString *ToRegionArName;
@property (nonatomic,strong) NSString *ToRegionEnName;
@property (nonatomic,strong) NSString *ToRegionNameFr;
@property (nonatomic,strong) NSString *ToRegionNameCh;
@property (nonatomic,strong) NSString *ToRegionNameUr;

@property (nonatomic,strong) NSString *CoordinatesStartLat;
@property (nonatomic,strong) NSString *CoordinatesStartLng;
@property (nonatomic,strong) NSString *CoordinatesEndLat;
@property (nonatomic,strong) NSString *CoordinatesEndLng;

@property (nonatomic,strong) NSNumber *Saturday;
@property (nonatomic,strong) NSNumber *Sunday;
@property (nonatomic,strong) NSNumber *Monday;
@property (nonatomic,strong) NSNumber *Tuesday;
@property (nonatomic,strong) NSNumber *Wendenday;
@property (nonatomic,strong) NSNumber *Thrursday;
@property (nonatomic,strong) NSNumber *Friday;

@property (nonatomic,strong) NSString *StartTime;
@property (nonatomic,strong) NSString *EndTime;

@property (nonatomic ,strong) UIImage *PassengerImage ;
@property (nonatomic ,strong) NSString *PassengerImagePath ;

@property (nonatomic,strong) NSNumber *DriverInvitationStatus;


@end

