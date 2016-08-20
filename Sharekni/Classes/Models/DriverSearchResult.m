//
//  DriverSearchResult.m
//  Sharekni
//
//  Created by ITWORX on 10/8/15.
//
//

#import "DriverSearchResult.h"
#import "MobAccountManager.h"

@implementation DriverSearchResult

+ (NSDictionary *)mapping {
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"AccountEmail"] = @"AccountEmail";
    mapping[@"AccountMobile"] = @"AccountMobile";
    mapping[@"AccountName"] = @"AccountName";
    
    mapping[@"AccountPhoto"] = @"AccountPhoto";
    mapping[@"AvilableOrRequiredSeats"] = @"AvilableOrRequiredSeats";
    mapping[@"DriverId"] = @"DriverId";
    
    mapping[@"DriverArName"] = @"DriverArName";
    mapping[@"DriverEnName"] = @"DriverEnName";
    mapping[@"DriverLicenseNo"] = @"DriverLicenseNo";
    mapping[@"DriverTrafficFileNo"] = @"DriverTrafficFileNo";
    
    mapping[@"EmployerID"] = @"EmployerID";
    
    mapping[@"From_EmirateName_ar"] = @"From_EmirateName_ar";
    mapping[@"From_EmirateName_en"] = @"From_EmirateName_en";
    mapping[@"From_EmirateName_fr"] = @"From_EmirateName_fr";
    mapping[@"From_EmirateName_ch"] = @"From_EmirateName_ch";
    
    mapping[@"From_RegionName_ar"] = @"From_RegionName_ar";
    mapping[@"From_RegionName_en"] = @"From_RegionName_en";
    mapping[@"From_RegionName_fr"] = @"From_RegionName_fr";
    mapping[@"From_RegionName_ch"] = @"From_RegionName_ch";
    mapping[@"From_RegionName_ur"] = @"From_RegionName_ur";
    
//    mapping[@"Rating"] = @"Rating";
    
    mapping[@"SDG_Route_Coordinates_End_Lat"] = @"SDG_Route_Coordinates_End_Lat";
    mapping[@"SDG_Route_Coordinates_End_Lng"] = @"SDG_Route_Coordinates_End_Lng";
    mapping[@"SDG_Route_Coordinates_Start_Lat"] = @"SDG_Route_Coordinates_Start_Lat";
    mapping[@"SDG_Route_Coordinates_Start_Lng"] = @"SDG_Route_Coordinates_Start_Lng";
    
    mapping[@"SDG_Route_FromEmirate_ID"] = @"SDG_Route_FromEmirate_ID";
    mapping[@"SDG_Route_Name_ar"] = @"SDG_Route_Name_ar";
    mapping[@"SDG_Route_Name_en"] = @"SDG_Route_Name_en";
    mapping[@"SDG_Route_NoOfSeats"] = @"SDG_Route_NoOfSeats";
    mapping[@"SDG_Route_PreferredGender"] = @"SDG_Route_PreferredGender";
    mapping[@"SDG_Route_Start_Date"] = @"SDG_Route_Start_Date";
    mapping[@"SDG_Route_Start_FromTime"] = @"SDG_Route_Start_FromTime";
    mapping[@"SDG_Route_ToEmirate_ID"] = @"SDG_Route_ToEmirate_ID";
    
    mapping[@"SDG_Route_ToRegion_ID"] = @"SDG_Route_ToRegion_ID";
    mapping[@"SDG_Route_IsRounded"] = @"SDG_Route_IsRounded";
    
    mapping[@"To_EmirateName_ar"] = @"To_EmirateName_ar";
    mapping[@"To_EmirateName_en"] = @"To_EmirateName_en";
    mapping[@"To_EmirateName_fr"] = @"To_EmirateName_fr";
    mapping[@"To_EmirateName_ch"] = @"To_EmirateName_ch";
    mapping[@"To_EmirateName_ur"] = @"To_EmirateName_ur";
    
    mapping[@"To_RegionName_ar"] = @"To_RegionName_ar";
    mapping[@"To_RegionName_en"] = @"To_RegionName_en";
    mapping[@"To_RegionName_fr"] = @"To_RegionName_fr";
    mapping[@"To_RegionName_ch"] = @"To_RegionName_ch";
    mapping[@"To_RegionName_ur"] = @"To_RegionName_ur";
    
    mapping[@"VehicleDescription"] = @"VehicleDescription";
    mapping[@"VehiclePlateCode"] = @"VehiclePlateCode";
    mapping[@"VehiclePlateNumber"] = @"VehiclePlateNumber";
    mapping[@"VehiclePlateSource"] = @"VehiclePlateSource";
    
    mapping[@"Nationality_ar"] = @"Nationality_ar";
    mapping[@"Nationality_en"] = @"Nationality_en";
    mapping[@"Nationality_fr"] = @"Nationality_fr";
    mapping[@"Nationality_ch"] = @"Nationality_ch";
    mapping[@"Nationality_ur"] = @"Nationality_ur";
    mapping[@"Saturday"] = @"Saturday";
    
    mapping[@"SDG_RouteDays_Sunday"] = @"SDG_RouteDays_Sunday";
    mapping[@"SDG_RouteDays_Monday"] = @"SDG_RouteDays_Monday";
    mapping[@"SDG_RouteDays_Tuesday"] = @"SDG_RouteDays_Tuesday";
    mapping[@"SDG_RouteDays_Wednesday"] = @"SDG_RouteDays_Wednesday";
    mapping[@"SDG_RouteDays_Thursday"] = @"SDG_RouteDays_Thursday";
    mapping[@"SDG_RouteDays_Friday"] = @"SDG_RouteDays_Friday";
    mapping[@"PassengersCountPerRoute"] = @"PassengersCountPerRoute";
    mapping[@"LastSeen"] = @"LastSeen";
    
    
    mapping[@"CO2Saved"] = @"CO2Saved";
    mapping[@"GreenPoints"] = @"GreenPoints";
 
    return mapping;
}

- (void)setDriverId:(NSString *)DriverId{
    _DriverId = DriverId;
    __block DriverSearchResult*blockSelf = self;
    [[MobAccountManager sharedMobAccountManager] getCalculatedRatingForAccount:DriverId WithSuccess:^(NSString *rating) {
        blockSelf.Rating = rating;
    } Failure:^(NSString *error) {
        blockSelf.Rating = @"0.0";
    }];
}


- (void)setAccountPhoto:(NSString *)AccountPhoto{
    _AccountPhoto = AccountPhoto;
    __block DriverSearchResult *blockSelf = self;
    [[MobAccountManager sharedMobAccountManager] GetPhotoWithName:AccountPhoto withSuccess:^(UIImage *image, NSString *filePath) {
        if(image){
            blockSelf.driverImage = image;
            blockSelf.driverImageLocalPath = filePath;
        }
        else{
            blockSelf.driverImage = [UIImage imageNamed:@"thumbnail"];
            blockSelf.driverImageLocalPath = nil;
        }
    } Failure:^(NSString *error) {
        blockSelf.driverImage = [UIImage imageNamed:@"thumbnail"];
        blockSelf.driverImageLocalPath = nil;
    }];
    
}

@end
