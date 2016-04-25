//
//  Passenger.h
//  sharekni
//
//  Created by Mohamed Abd El-latef on 11/22/15.
//
//

#import <Foundation/Foundation.h>

@interface Passenger : NSObject
@property (nonatomic,strong) NSNumber *ID;
@property (nonatomic,strong) NSString *RequestDate;
@property (nonatomic,strong) NSNumber *IsRemoved;
@property (nonatomic,strong) NSString *RemoveDate;
//GonMade webServeSub 3
@property (nonatomic,strong) NSString *RequestStatus;
@property (nonatomic,strong) NSString *PassengerStatus;

@property (nonatomic,strong) NSString *Remarks;
@property (nonatomic,strong) NSNumber *AccountId;
@property (nonatomic,strong) NSString *AccountName;
@property (nonatomic,strong) NSString *AccountMobile;
@property (nonatomic,strong) NSString *AccountNationalityAr;
@property (nonatomic,strong) NSString *AccountNationalityEn;
@property (nonatomic,strong) NSString *AccountNationalityFr;
@property (nonatomic,strong) NSString *AccountNationalityUr;
@property (nonatomic,strong) NSString *AccountNationalityCh;
@property (nonatomic,strong) NSString *PassenegerRateByDriver;

@end