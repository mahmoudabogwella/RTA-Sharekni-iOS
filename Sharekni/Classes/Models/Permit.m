//
//  Permit.m
//  sharekni
//
//  Created by Ahmed Askar on 11/22/15.
//
//

#import "Permit.h"

@implementation Permit

+ (NSDictionary *)mapping
{
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    mapping[@"ID"] = @"ID";
    mapping[@"PermitRef"] = @"PermitRef";
    mapping[@"IssueDate"] = @"IssueDate";
    mapping[@"ExpireDate"] = @"ExpireDate";
    mapping[@"MaxPassengers"] = @"MaxPassengers";
    mapping[@"CurrentPassengers"] = @"CurrentPassengers";
    mapping[@"Remarks"] = @"Remarks";
    mapping[@"DriverId"] = @"DriverId";
    mapping[@"RouteId"] = @"RouteId";
    mapping[@"RouteArName"] = @"RouteArName";
    mapping[@"RouteEnName"] = @"RouteEnName";
    mapping[@"VehicelId"] = @"VehicelId";
    
    return mapping;
}

@end