//
//  Ride.h
//  sharekni
//
//  Created by Mohamed Abd El-latef on 11/17/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Ride : NSObject
@property (nonatomic,strong) NSNumber *RoutePassengerId;
@property (nonatomic,strong) NSNumber *DriverAccept;
@property (nonatomic,strong) NSNumber *RouteID;
@property (nonatomic,strong) NSNumber *Account;

@property (nonatomic,strong) NSString *Name_ar;
@property (nonatomic,strong) NSString *Name_en;

@property (nonatomic,strong) NSString *Vehicle_ManufactureModel_ar;
@property (nonatomic,strong) NSString *Vehicle_ManufactureModel_en;
@property (nonatomic,strong) NSString *Vehicle_ManufactureName_ar;
@property (nonatomic,strong) NSString *Vehicle_ManufactureName_en;

@property (nonatomic,strong) NSNumber *NoOfSeats;
@property (nonatomic,strong) NSNumber *NoOfSeatsAvailable;

@property (nonatomic,strong) NSString *DriverMobile;
@property (nonatomic,strong) NSString *DriverName;
@property (nonatomic,strong) NSString *DriverPhoto;
@property (nonatomic,strong) NSString *DriverNationalityId;
@property (nonatomic,strong) NSString *DriverNationalityArName;
@property (nonatomic,strong) NSString *DriverNationalityEnName;
@property (nonatomic,strong) NSString *DriverNationalityFrName;
@property (nonatomic,strong) NSString *DriverNationalityChName;
@property (nonatomic,strong) NSString *DriverNationalityUrName;
@property (nonatomic,strong) NSString *DriverRating;

@property (nonatomic,strong) NSNumber *FromEmirateId;
@property (nonatomic,strong) NSString *FromEmirateArName;
@property (nonatomic,strong) NSString *FromEmirateEnName;
@property (nonatomic,strong) NSString *FromEmirateNameFr;
@property (nonatomic,strong) NSString *FromEmirateNameCh;
@property (nonatomic,strong) NSString *FromEmirateNameUr;

@property (nonatomic,strong) NSNumber *ToEmirateId;
@property (nonatomic,strong) NSString *ToEmirateArName;
@property (nonatomic,strong) NSString *ToEmirateEnName;
@property (nonatomic,strong) NSString *ToEmirateNameFr;
@property (nonatomic,strong) NSString *ToEmirateNameCh;
@property (nonatomic,strong) NSString *ToEmirateNameUr;

@property (nonatomic,strong) NSNumber *FromRegionId;
@property (nonatomic,strong) NSString *FromRegionArName;
@property (nonatomic,strong) NSString *FromRegionEnName;
@property (nonatomic,strong) NSString *FromRegionNameFr;
@property (nonatomic,strong) NSString *FromRegionNameCh;
@property (nonatomic,strong) NSString *FromRegionNameUr;

@property (nonatomic,strong) NSNumber *ToRegionId;
@property (nonatomic,strong) NSString *ToRegionArName;
@property (nonatomic,strong) NSString *ToRegionEnName;
@property (nonatomic,strong) NSString *ToRegionNameFr;
@property (nonatomic,strong) NSString *ToRegionNameCh;
@property (nonatomic,strong) NSString *ToRegionNameUr;

@property (nonatomic,strong) UIImage *driverImage;
@property (nonatomic,strong) NSString *driverImageLocalPath;

@end



