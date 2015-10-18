//
//  MostRideDetails.h
//  Sharekni
//
//  Created by Mohamed Abd El-latef on 10/18/15.
//
//

#import <Foundation/Foundation.h>

@interface MostRideDetails : NSObject
@property (nonatomic,strong) NSString *RouteId;
@property (nonatomic,strong) NSString *RouteArName;
@property (nonatomic,strong) NSString *RouteEnName;
@property (nonatomic,strong) NSString *NoOfSeats;
@property (nonatomic,strong) NSString *AccountId;
@property (nonatomic,strong) NSString *DriverName;
@property (nonatomic,strong) NSString *Rating;

@property (nonatomic,strong) NSString *NationalityArName;
@property (nonatomic,strong) NSString *NationalityEnName;
@property (nonatomic,strong) NSString *NationalityFrName;
@property (nonatomic,strong) NSString *NationalityChName;
@property (nonatomic,strong) NSString *NationalityUrName;

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

@property (nonatomic,strong) NSString *Saturday;
@property (nonatomic,strong) NSString *Sunday;
@property (nonatomic,strong) NSString *Monday;
@property (nonatomic,strong) NSString *Tuesday;
@property (nonatomic,strong) NSString *Wendenday;
@property (nonatomic,strong) NSString *Thrursday;
@property (nonatomic,strong) NSString *Friday;


@property (nonatomic,strong) NSString *StartTime;
@property (nonatomic,strong) NSString *EndTime;

@end
