//
//  Ride.m
//  sharekni
//
//  Created by Mohamed Abd El-latef on 11/17/15.
//
//

#import "Ride.h"
#import "MobAccountManager.h"
@implementation Ride
+ (NSDictionary *)mapping
{
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    
    mapping[@"RoutePassengerId"] = @"RoutePassengerId";
    mapping[@"DriverAccept"] = @"DriverAccept";
    mapping[@"RouteID"] = @"RouteID";
    mapping[@"Account"] = @"Account";
    mapping[@"Name_ar"] = @"Name_ar";
    mapping[@"Name_en"] = @"Name_en";
    
    mapping[@"Vehicle_ManufactureModel_ar"] = @"Vehicle_ManufactureModel_ar";
    mapping[@"Vehicle_ManufactureModel_en"] = @"Vehicle_ManufactureModel_en";
    mapping[@"Vehicle_ManufactureName_ar"] = @"Vehicle_ManufactureName_ar";
    mapping[@"Vehicle_ManufactureName_en"] = @"Vehicle_ManufactureName_en";
    
    mapping[@"NoOfSeats"] = @"NoOfSeats";
    mapping[@"NoOfSeatsAvailable"] = @"NoOfSeatsAvailable";
    
    mapping[@"DriverMobile"] = @"DriverMobile";
    mapping[@"DriverName"] = @"DriverName";
    mapping[@"DriverPhoto"] = @"DriverPhoto";
    
    mapping[@"FromEmirateArName"] = @"FromEmirateArName";
    mapping[@"FromEmirateEnName"] = @"FromEmirateEnName";
    mapping[@"FromEmirateNameFr"] = @"FromEmirateNameFr";
    mapping[@"FromEmirateNameCh"] = @"FromEmirateNameCh";
    mapping[@"FromEmirateNameUr"] = @"FromEmirateNameUr";
    
    mapping[@"ToEmirateArName"] = @"ToEmirateArName";
    mapping[@"ToEmirateEnName"] = @"ToEmirateEnName";
    mapping[@"ToEmirateNameFr"] = @"ToEmirateNameFr";
    mapping[@"ToEmirateNameCh"] = @"ToEmirateNameCh";
    mapping[@"ToEmirateNameUr"] = @"ToEmirateNameUr";
    
    mapping[@"FromRegionArName"] = @"FromRegionArName";
    mapping[@"FromRegionEnName"] = @"FromRegionEnName";
    mapping[@"FromRegionNameFr"] = @"FromRegionNameFr";
    mapping[@"FromRegionNameCh"] = @"FromRegionNameCh";
    mapping[@"FromRegionNameUr"] = @"FromRegionNameUr";
    
    mapping[@"ToRegionArName"] = @"ToRegionArName";
    mapping[@"ToRegionEnName"] = @"ToRegionEnName";
    mapping[@"ToRegionNameFr"] = @"ToRegionNameFr";
    mapping[@"ToRegionNameCh"] = @"ToRegionNameCh";
    mapping[@"ToRegionNameUr"] = @"ToRegionNameUr";
    
    return mapping;
}

- (void)setAccount:(NSNumber *)Account{
    _Account = Account;
    __block Ride *blockSelf = self  ;
    [[MobAccountManager sharedMobAccountManager] getCalculatedRatingForAccount:Account.stringValue WithSuccess:^(NSString *rating) {
        blockSelf.DriverRating = rating;
    } Failure:^(NSString *error) {
        blockSelf.DriverRating = @"0.0";
    }];
}
- (void)setDriverPhoto:(NSString *)DriverPhoto
{
    __block Ride *blockSelf = self;
    _DriverPhoto = DriverPhoto ;
    [[MobAccountManager sharedMobAccountManager] GetPhotoWithName:DriverPhoto withSuccess:^(UIImage *image, NSString *filePath) {
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