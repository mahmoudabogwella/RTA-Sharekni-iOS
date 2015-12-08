//
//  Permit.h
//  sharekni
//
//  Created by Ahmed Askar on 11/22/15.
//
//

#import <Foundation/Foundation.h>

@interface Permit : NSObject

@property (nonatomic,strong) NSNumber *ID;
@property (nonatomic,strong) NSNumber *PermitRef;
@property (nonatomic,strong) NSString *IssueDate;
@property (nonatomic,strong) NSString *ExpireDate;
@property (nonatomic,strong) NSNumber *MaxPassengers;
@property (nonatomic,strong) NSNumber *CurrentPassengers;
@property (nonatomic,strong) NSString *Remarks;
@property (nonatomic,strong) NSNumber *DriverId;
@property (nonatomic,strong) NSNumber *RouteId;
@property (nonatomic,strong) NSString *RouteArName;
@property (nonatomic,strong) NSString *RouteEnName;
@property (nonatomic,strong) NSNumber *VehicelId;



@end