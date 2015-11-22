//
//  Notification.m
//  sharekni
//
//  Created by Ahmed Askar on 11/22/15.
//
//

#import "Notification.h"

@implementation Notification

+ (NSDictionary *)mapping
{
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"RequestId"] = @"RequestId";
    mapping[@"PassengerName"] = @"PassengerName";
    mapping[@"RouteName"] = @"RouteName";
    mapping[@"Remarks"] = @"Remarks";
    mapping[@"RequestDate"] = @"RequestDate";
    mapping[@"PassengerMobile"] = @"PassengerMobile";
    mapping[@"AccountPhoto"] = @"AccountPhoto";
    mapping[@"NationalityEnName"] = @"AccountGender";
    mapping[@"NationalityFrName"] = @"AccountGenderAr";
    mapping[@"NationalityChName"] = @"AccountGenderEn";
    mapping[@"NationalityUrName"] = @"AccountNationality";
    mapping[@"NationalityEnName"] = @"NationalityArName";
    mapping[@"NationalityFrName"] = @"NationalityEnName";
    mapping[@"NationalityChName"] = @"NationalityFrName";
    mapping[@"NationalityUrName"] = @"NationalityChName";
    mapping[@"NationalityUrName"] = @"NationalityUrName";

    return mapping;
}

@end
