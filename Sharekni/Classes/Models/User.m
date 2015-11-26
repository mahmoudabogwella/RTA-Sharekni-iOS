//
//  User.m
//  Sharekni
//
//  Created by ITWORX on 9/28/15.
//
//

#import "User.h"

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
    mapping[@"AccountRating"] = @"AccountRating";
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
    mapping[@"PrefferedLanguage"] = @"PrefferedLanguage";
    mapping[@"DriverMyRidesCount"] = @"DriverMyRidesCount";
    mapping[@"DriverMyAlertsCount"] = @"DriverMyAlertsCount";
    mapping[@"PassengerJoinedRidesCount"] = @"PassengerJoinedRidesCount";
    mapping[@"PassengerMyRidesCount"] = @"PassengerMyRidesCount";
    mapping[@"IsMobileVerified"] = @"IsMobileVerified";
    mapping[@"IsPhotoVerified"] = @"IsPhotoVerified";
    mapping[@"DriverTrafficFileNo"] = @"DriverTrafficFileNo";
    mapping[@"VehiclesCount"] = @"VehiclesCount";
    return mapping;
}

- (void)setAccountStatus:(NSString *)AccountStatus{
    _AccountStatus = AccountStatus;
    if ([_AccountStatus containsString:@"D"]) {
        self.accountType = AccountTypeDriver;
    }
    else if ([_AccountStatus containsString:@"P"]){
        self.accountType = AccountTypePassenger;
    }
    else if ([_AccountStatus containsString:@"B"]){
        self.accountType = AccountTypeBoth;
    }
}


@end