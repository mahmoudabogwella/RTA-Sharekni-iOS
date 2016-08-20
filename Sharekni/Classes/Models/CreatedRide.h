//
//  CreatedRide.h
//  sharekni
//
//  Created by Mohamed Abd El-latef on 11/21/15.
//
//

#import <Foundation/Foundation.h>

@interface CreatedRide : NSObject
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

@property (nonatomic,strong) NSNumber *FromEmirateId;
@property (nonatomic,strong) NSString *FromEmirateArName;
@property (nonatomic,strong) NSString *FromEmirateEnName;
@property (nonatomic,strong) NSString *FromEmirateFrName;
@property (nonatomic,strong) NSString *FromEmirateChName;
@property (nonatomic,strong) NSString *FromEmirateUrName;

@property (nonatomic,strong) NSNumber *ToEmirateId;
@property (nonatomic,strong) NSString *ToEmirateArName;
@property (nonatomic,strong) NSString *ToEmirateEnName;
@property (nonatomic,strong) NSString *ToEmirateFrName;
@property (nonatomic,strong) NSString *ToEmirateChName;
@property (nonatomic,strong) NSString *ToEmirateUrName;

@property (nonatomic,strong) NSNumber *FromRegionId;
@property (nonatomic,strong) NSString *FromRegionArName;
@property (nonatomic,strong) NSString *FromRegionEnName;
@property (nonatomic,strong) NSString *FromRegionFrName;
@property (nonatomic,strong) NSString *FromRegionChName;
@property (nonatomic,strong) NSString *FromRegionUrName;

@property (nonatomic,strong) NSNumber *ToRegionId;
@property (nonatomic,strong) NSString *ToRegionArName;
@property (nonatomic,strong) NSString *ToRegionEnName;
@property (nonatomic,strong) NSString *ToRegionFrName;
@property (nonatomic,strong) NSString *ToRegionChName;
@property (nonatomic,strong) NSString *ToRegionUrName;
@end
