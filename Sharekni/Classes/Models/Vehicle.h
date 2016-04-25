//
//  Vehicle.h
//  sharekni
//
//  Created by Mohamed Abd El-latef on 10/24/15.
//
//

#import <Foundation/Foundation.h>

@interface Vehicle : NSObject
@property (nonatomic,strong) NSNumber *ID;
@property (nonatomic,strong) NSString *VehcileDescription;
@property (nonatomic,strong) NSString *PlateCode;
@property (nonatomic,strong) NSString *PlateNumber;
@property (nonatomic,strong) NSString *Passenger;
@property (nonatomic,strong) NSString *RegistrationDate;
@property (nonatomic,strong) NSString *ExpiryDate;
@property (nonatomic,strong) NSString *ManufacturingYear;
@property (nonatomic,strong) NSString *ManufacturingArName;
@property (nonatomic,strong) NSString *ManufacturingEnName;
@property (nonatomic,strong) NSString *ChassisNumber;
@property (nonatomic,strong) NSString *ModelArName;
@property (nonatomic,strong) NSString *ModelEnName;
@property (nonatomic,strong) NSString *ColorArName;
@property (nonatomic,strong) NSString *ColorEnName;
@property (nonatomic,strong) NSString *TypeArName;
@property (nonatomic,strong) NSString *TypeEnName;
@property (nonatomic,strong) NSString *ClassArName;
@property (nonatomic,strong) NSString *ClassEnName;
@property (nonatomic,strong) NSString *NoOfSeats;
@property (nonatomic,strong) NSString *VehcileArStatus;
@property (nonatomic,strong) NSString *VehcileEnStatus;
@property (nonatomic,strong) NSNumber *IsValidate;
@property (nonatomic,strong) NSString *DateAdded;
@property (nonatomic,strong) NSNumber *DriverId;

@end
