//
//  DriverSearchResult.h
//  Sharekni
//
//  Created by ITWORX on 10/8/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DriverSearchResult : NSObject
@property (nonatomic,strong) NSString *AccountEmail;
@property (nonatomic,strong) NSString *AccountMobile;
@property (nonatomic,strong) NSString *AccountName;
@property (nonatomic,strong) NSString *AccountPhoto;
@property (nonatomic,strong) NSString *AvilableOrRequiredSeats;

@property (nonatomic,strong) NSString *DriverId;
@property (nonatomic,strong) NSString *DriverArName;
@property (nonatomic,strong) NSString *DriverEnName;
@property (nonatomic,strong) NSString *DriverLicenseNo;
@property (nonatomic,strong) NSString *DriverTrafficFileNo;

@property (nonatomic,strong) NSString *EmployerID;

@property (nonatomic,strong) NSString *From_EmirateName_ar;
@property (nonatomic,strong) NSString *From_EmirateName_en;
@property (nonatomic,strong) NSString *From_EmirateName_fr;
@property (nonatomic,strong) NSString *From_EmirateName_ch;

@property (nonatomic,strong) NSString *From_RegionName_ar;
@property (nonatomic,strong) NSString *From_RegionName_en;
@property (nonatomic,strong) NSString *From_RegionName_fr;
@property (nonatomic,strong) NSString *From_RegionName_ch;
@property (nonatomic,strong) NSString *From_RegionName_ur;

@property (nonatomic,strong) NSString *Rating;

@property (nonatomic,strong) NSString *SDG_Route_Coordinates_End_Lat;
@property (nonatomic,strong) NSString *SDG_Route_Coordinates_End_Lng;
@property (nonatomic,strong) NSString *SDG_Route_Coordinates_Start_Lat;
@property (nonatomic,strong) NSString *SDG_Route_Coordinates_Start_Lng;

@property (nonatomic,strong) NSString *SDG_Route_FromEmirate_ID;
@property (nonatomic,strong) NSString *SDG_Route_Name_ar;
@property (nonatomic,strong) NSString *SDG_Route_Name_en;
@property (nonatomic,strong) NSString *SDG_Route_NoOfSeats;
@property (nonatomic,strong) NSString *SDG_Route_PreferredGender;
@property (nonatomic,strong) NSString *SDG_Route_Start_Date;
@property (nonatomic,strong) NSString *SDG_Route_Start_FromTime;
@property (nonatomic,strong) NSString *SDG_Route_ToEmirate_ID;

@property (nonatomic,strong) NSString *SDG_Route_ToRegion_ID;
@property (nonatomic,strong) NSString *SDG_Route_IsRounded;

@property (nonatomic,strong) NSString *To_EmirateName_ar;

@property (nonatomic,strong) NSString *To_EmirateName_en;
@property (nonatomic,strong) NSString *To_EmirateName_fr;
@property (nonatomic,strong) NSString *To_EmirateName_ch;
@property (nonatomic,strong) NSString *To_EmirateName_ur;

@property (nonatomic,strong) NSString *To_RegionName_ar;
@property (nonatomic,strong) NSString *To_RegionName_en;
@property (nonatomic,strong) NSString *To_RegionName_fr;
@property (nonatomic,strong) NSString *To_RegionName_ch;
@property (nonatomic,strong) NSString *To_RegionName_ur;

@property (nonatomic,strong) NSString *VehicleDescription;
@property (nonatomic,strong) NSString *VehiclePlateCode;
@property (nonatomic,strong) NSString *VehiclePlateNumber;
@property (nonatomic,strong) NSString *VehiclePlateSource;

@property (nonatomic,strong) NSString *Nationality_ar;
@property (nonatomic,strong) NSString *Nationality_en;
@property (nonatomic,strong) NSString *Nationality_fr;
@property (nonatomic,strong) NSString *Nationality_ch;
@property (nonatomic,strong) NSString *Nationality_ur;

@property (nonatomic,strong) NSNumber *Saturday;

@property (nonatomic,strong) NSNumber *SDG_RouteDays_Sunday;
@property (nonatomic,strong) NSNumber *SDG_RouteDays_Monday;
@property (nonatomic,strong) NSNumber *SDG_RouteDays_Tuesday;
@property (nonatomic,strong) NSNumber *SDG_RouteDays_Wednesday;
@property (nonatomic,strong) NSNumber *SDG_RouteDays_Thursday;
@property (nonatomic,strong) NSNumber *SDG_RouteDays_Friday;
@property (nonatomic,strong) NSNumber *PassengersCountPerRoute;

@property (nonatomic,strong) NSString *LastSeen;


@property (nonatomic,strong) UIImage *driverImage;
@property (nonatomic,strong) NSString *driverImageLocalPath;

@property (nonatomic,strong) NSNumber *CO2Saved;
@property (nonatomic,strong) NSNumber *GreenPoints;

@end
