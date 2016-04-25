//
//  MostRideDetailsDataForPassenger.m
//  sharekni
//
//  Created by killvak on 2/26/16.
//
//


#import "MostRideDetailsDataForPassenger.h"
#import "MobAccountManager.h"
@implementation MostRideDetailsDataForPassenger

+ (NSDictionary *)mapping {
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"DriverRouteId"] = @"DriverRouteId";
    mapping[@"RouteArName"] = @"RouteArName";
    mapping[@"RouteEnName"] = @"RouteEnName";
    mapping[@"NoOfSeats"] = @"NoOfSeats";
    mapping[@"AccountId"] = @"AccountId";
    mapping[@"PassengerName"] = @"PassengerName";
    mapping[@"PassengerMobile"] = @"PassengerMobile";
    mapping[@"PassengerPhoto"] = @"PassengerPhoto";
    //GonMade WebServe
//    mapping[@"RequestStatus"] = @"RequestStatus"; //TestIng Comment
    //    mapping[@"Rating"] = @"Rating";
    
    mapping[@"NationalityArName"] = @"NationalityArName";
    mapping[@"NationlityEnName"] = @"NationlityEnName";
    mapping[@"NationlityFrName"] = @"NationlityFrName";
    mapping[@"NationlityChName"] = @"NationlityChName";
    mapping[@"NationlityUrName"] = @"NationlityUrName";
    
    mapping[@"FromEmirateId"] = @"FromEmirateId";
    mapping[@"ToEmirateId"] = @"ToEmirateId";
    mapping[@"FromRegionId"] = @"FromRegionId";
    mapping[@"ToRegionId"] = @"ToRegionId";
    
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
    
    
    mapping[@"CoordinatesStartLat"] = @"CoordinatesStartLat";
    mapping[@"CoordinatesStartLng"] = @"CoordinatesStartLng";
    mapping[@"CoordinatesEndLat"] = @"CoordinatesEndLat";
    mapping[@"CoordinatesEndLng"] = @"CoordinatesEndLng";
    
    mapping[@"Saturday"] = @"Saturday";
    mapping[@"Sunday"] = @"Sunday";
    mapping[@"Monday"] = @"Monday";
    mapping[@"Tuesday"] = @"Tuesday";
    mapping[@"Wendenday"] = @"Wendenday";
    mapping[@"Thrursday"] = @"Thrursday";
    mapping[@"Friday"] = @"Friday";
    
    mapping[@"DriverInvitationStatus"] = @"DriverInvitationStatus";

    mapping[@"StartTime"] = @"StartTime";
    mapping[@"EndTime"] = @"EndTime";
    return mapping;
}

- (void)setAccountId:(NSString *)AccountId{
    _AccountId = AccountId;
    __block MostRideDetailsDataForPassenger *blockSelf = self;
    [[MobAccountManager sharedMobAccountManager] getCalculatedRatingForAccount:AccountId WithSuccess:^(NSString *rating) {
        blockSelf.Rating = rating;
    } Failure:^(NSString *error) {
        blockSelf.Rating = @"0.0";
    }];
}

-(void)setPassengerPhoto:(NSString *)PassengerPhoto {
    __block MostRideDetailsDataForPassenger *blockSelf = self;
    _PassengerPhoto = PassengerPhoto ;
    [[MobAccountManager sharedMobAccountManager] GetPhotoWithName:PassengerPhoto withSuccess:^(UIImage *image, NSString *filePath) {
        if(image){
            blockSelf.PassengerImage = image;
            blockSelf.PassengerImagePath = filePath;
        }
        else{
            blockSelf.PassengerImage = [UIImage imageNamed:@"thumbnail"];
            blockSelf.PassengerImagePath = nil;
        }
    } Failure:^(NSString *error) {
        blockSelf.PassengerImage = [UIImage imageNamed:@"thumbnail"];
        blockSelf.PassengerImagePath = nil;
    }];
}
/*
- (void)setDriverPhoto:(NSString *)DriverPhoto
{
    __block MostRideDetailsDataForPassenger *blockSelf = self;
    _DriverPhoto = DriverPhoto ;
    [[MobAccountManager sharedMobAccountManager] GetPhotoWithName:DriverPhoto withSuccess:^(UIImage *image, NSString *filePath) {
        if(image){
            blockSelf.PassengerImage = image;
            blockSelf.PassengerImagePath = filePath;
        }
        else{
            blockSelf.PassengerImage = [UIImage imageNamed:@"thumbnail"];
            blockSelf.PassengerImagePath = nil;
        }
    } Failure:^(NSString *error) {
        blockSelf.PassengerImage = [UIImage imageNamed:@"thumbnail"];
        blockSelf.PassengerImagePath = nil;
    }];
}*/

@end
