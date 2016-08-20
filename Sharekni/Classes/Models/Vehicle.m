//
//  Vehicle.m
//  sharekni
//
//  Created by Mohamed Abd El-latef on 10/24/15.
//
//

#import "Vehicle.h"

@implementation Vehicle
+ (NSDictionary *)mapping {
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"ID"] = @"ID";
    mapping[@"VehcileDescription"] = @"VehcileDescription";
    mapping[@"PlateCode"] = @"PlateCode";
    mapping[@"PlateNumber"] = @"PlateNumber";
    mapping[@"Passenger"] = @"Passenger";
    mapping[@"RegistrationDate"] = @"RegistrationDate";
    mapping[@"ExpiryDate"] = @"ExpiryDate";
    mapping[@"ManufacturingYear"] = @"ManufacturingYear";
    mapping[@"ManufacturingArName"] = @"ManufacturingArName";
    mapping[@"ManufacturingEnName"] = @"ManufacturingEnName";
    mapping[@"ChassisNumber"] = @"ChassisNumber";
    mapping[@"ModelArName"] = @"ModelArName";
    mapping[@"ModelEnName"] = @"ModelEnName";
    mapping[@"ColorArName"] = @"ColorArName";
    mapping[@"ColorEnName"] = @"ColorEnName";
    
    mapping[@"TypeArName"] = @"TypeArName";
    mapping[@"TypeEnName"] = @"TypeEnName";
    mapping[@"ClassArName"] = @"ClassArName";
    mapping[@"ClassEnName"] = @"ClassEnName";
    mapping[@"NoOfSeats"] = @"NoOfSeats";
    mapping[@"VehcileArStatus"] = @"VehcileArStatus";
    mapping[@"VehcileEnStatus"] = @"VehcileEnStatus";
    mapping[@"IsValidate"] = @"IsValidate";
    mapping[@"DateAdded"] = @"DateAdded";
    mapping[@"DriverId"] = @"DriverId";
    return mapping;
}
@end
