//
//  User.m
//  Sharekni
//
//  Created by ITWORX on 9/28/15.
//
//

#import "User.h"
#import "MobAccountManager.h"
@implementation User

+ (NSDictionary *)mapping {
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"ID"] = @"ID";
    mapping[@"FirstName"] = @"FirstName";
    mapping[@"MiddleName"] = @"MiddleName";
    mapping[@"LastName"] = @"LastName";
    mapping[@"BirthDate"] = @"BirthDate";
    mapping[@"PhotoPath"] = @"PhotoPath";
    mapping[@"Email"] = @"Email";
    mapping[@"Phone"] = @"Phone";
    mapping[@"Mobile"] = @"Mobile";
    mapping[@"GenderAr"] = @"GenderAr";
    mapping[@"GenderEn"] = @"GenderEn";
    mapping[@"Username"] = @"Username";
    mapping[@"Password"] = @"Password";
//    mapping[@"AccountRating"] = @"AccountRating";
    mapping[@"Active"] = @"Active";
    mapping[@"DateAdded"] = @"DateAdded";
    mapping[@"NationalityId"] = @"NationalityId";
    mapping[@"NationalityArName"] = @"NationalityArName";
    mapping[@"NationalityEnName"] = @"NationalityEnName";
    mapping[@"NationalityFrName"] = @"NationalityFrName";
    mapping[@"NationalityChName"] = @"NationalityChName";
    mapping[@"NationalityUrName"] = @"NationalityUrName";
    mapping[@"EmployerId"] = @"EmployerId";
    mapping[@"EmployerArName"] = @"EmployerArName";
    mapping[@"EmployerEnName"] = @"EmployerEnName";
    mapping[@"AccountTypeId"] = @"AccountTypeId";
    mapping[@"AccountTypeArName"] = @"AccountTypeArName";
    mapping[@"AccountTypeEnName"] = @"AccountTypeEnName";
    mapping[@"AccountStatus"] = @"AccountStatus";
//    IsPassenger
    mapping[@"IsPassenger"] = @"IsPassenger";

    mapping[@"PrefferedLanguage"] = @"PrefferedLanguage";
    mapping[@"DriverMyRidesCount"] = @"DriverMyRidesCount";
    mapping[@"DriverMyAlertsCount"] = @"DriverMyAlertsCount";
    mapping[@"PassengerJoinedRidesCount"] = @"PassengerJoinedRidesCount";
    mapping[@"PassengerMyRidesCount"] = @"PassengerMyRidesCount";
    mapping[@"IsMobileVerified"] = @"IsMobileVerified";
    mapping[@"IsPhotoVerified"] = @"IsPhotoVerified";
    mapping[@"DriverTrafficFileNo"] = @"DriverTrafficFileNo";
    mapping[@"VehiclesCount"] = @"VehiclesCount";
    
    mapping[@"PendingInvitationCount"] = @"PendingInvitationCount";
    mapping[@"Passenger_Invitation_Count"] = @"Passenger_Invitation_Count";
    mapping[@"PassengerMyAlertsCount"] = @"PassengerMyAlertsCount";
    mapping[@"PendingRequestsCount"] = @"PendingRequestsCount";

    mapping[@"CO2Saved"] = @"CO2Saved";
    mapping[@"GreenPoints"] = @"GreenPoints";
    mapping[@"TotalDistance"] = @"TotalDistance";
    
    return mapping;
}
-(void)setIsPassenger:(NSString *)IsPassenger {
    _IsPassenger = IsPassenger;
    NSLog(@"that is passenger value :%@",_IsPassenger);
    NSString *LOL = [NSString stringWithFormat:@"%@",_IsPassenger];
    NSLog(@"that is LOL Value :%@",LOL);
    if ([LOL containsString:@"0"] || [LOL containsString:@"false"]) {
        NSLog(@"value is 0");
        self.accountType = AccountTypeBoth;
    } else if ([LOL containsString:@"1"] || [LOL containsString:@"true"]) {
        NSLog(@"value is 1");
        self.accountType = AccountTypePassenger;

    }
}

//- (void)setAccountStatus:(NSString *)AccountStatus{
//    _AccountStatus = AccountStatus;
//    if ([_AccountStatus containsString:@"D"]) {
//        self.accountType = AccountTypeDriver;
//    }
//    else if ([_AccountStatus containsString:@"P"]){
//        self.accountType = AccountTypePassenger;
//    }
//    else if ([_AccountStatus containsString:@"B"]){
//        self.accountType = AccountTypeBoth;
//    }
//}

- (void)setPhotoPath:(NSString *)PhotoPath{
    _PhotoPath = PhotoPath;
    __block User *blockSelf = self;
    [[MobAccountManager sharedMobAccountManager] GetPhotoWithName:PhotoPath withSuccess:^(UIImage *image, NSString *filePath) {
        blockSelf.userImage = image;
        blockSelf.imageLocalPath = filePath;
    } Failure:^(NSString *error) {
        blockSelf.userImage = [UIImage imageNamed:@"thumbnail"];
        blockSelf.imageLocalPath = nil;
    }];
}

- (void)setID:(NSNumber *)ID{
    _ID = ID;
    __block User *blockSelf = self  ;
    [[MobAccountManager sharedMobAccountManager] getCalculatedRatingForAccount:ID.stringValue WithSuccess:^(NSString *rating) {
        blockSelf.AccountRating = rating;
    } Failure:^(NSString *error) {
        
    }];
}


@end