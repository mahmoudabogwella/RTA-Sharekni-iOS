//
//  DriverDetails.h
//  sharekni
//
//  Created by Ahmed Askar on 11/4/15.
//
//

#import <Foundation/Foundation.h>

@interface DriverDetails : NSObject

@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *RouteId;
@property (nonatomic,strong) NSString *RouteArName;
@property (nonatomic,strong) NSString *RouteEnName;
@property (nonatomic,strong) NSString *NoOfSeats;
@property (nonatomic,strong) NSString *AccountId;
@property (nonatomic,strong) NSString *DriverName;
@property (nonatomic,strong) NSString *DriverMobile;
@property (nonatomic,strong) NSString *PreferredGender;

@property (nonatomic,strong) NSString *NationalityId;
@property (nonatomic,strong) NSString *NationalityArName;
@property (nonatomic,strong) NSString *NationalityEnName;
@property (nonatomic,strong) NSString *NationalityFrName;
@property (nonatomic,strong) NSString *NationalityChName;
@property (nonatomic,strong) NSString *NationalityUrName;

@property (nonatomic,strong) NSString *PrefLanguageId;
@property (nonatomic,strong) NSString *PrefLanguageArName;
@property (nonatomic,strong) NSString *PrefLanguageEnName;
@property (nonatomic,strong) NSString *PrefLanguageFrName;
@property (nonatomic,strong) NSString *PrefLanguageChName;
@property (nonatomic,strong) NSString *PrefLanguageUrName;

@property (nonatomic,strong) NSString *AgeRangeId;
@property (nonatomic,strong) NSString *AgeRange;

@property (nonatomic,strong) NSString *FromEmirateId;
@property (nonatomic,strong) NSString *ToEmirateId;
@property (nonatomic,strong) NSString *FromRegionId;
@property (nonatomic,strong) NSString *ToRegionId;

@property (nonatomic,strong) NSString *FromEmirateArName;
@property (nonatomic,strong) NSString *FromEmirateEnName;
@property (nonatomic,strong) NSString *FromEmirateNameFr;
@property (nonatomic,strong) NSString *FromEmirateNameCh;
@property (nonatomic,strong) NSString *FromEmirateNameUr;

@property (nonatomic,strong) NSString *ToEmirateArName;
@property (nonatomic,strong) NSString *ToEmirateEnName;
@property (nonatomic,strong) NSString *ToEmirateNameFr;
@property (nonatomic,strong) NSString *ToEmirateNameCh;
@property (nonatomic,strong) NSString *ToEmirateNameUr;

@property (nonatomic,strong) NSString *FromRegionArName;
@property (nonatomic,strong) NSString *FromRegionEnName;
@property (nonatomic,strong) NSString *FromRegionNameFr;
@property (nonatomic,strong) NSString *FromRegionNameCh;
@property (nonatomic,strong) NSString *FromRegionNameUr;

@property (nonatomic,strong) NSString *ToRegionArName;
@property (nonatomic,strong) NSString *ToRegionEnName;
@property (nonatomic,strong) NSString *ToRegionNameFr;
@property (nonatomic,strong) NSString *ToRegionNameCh;
@property (nonatomic,strong) NSString *ToRegionNameUr;

@property (nonatomic,strong) NSString *VehicelId;
@property (nonatomic,strong) NSString *VehicleManuName_ar;
@property (nonatomic,strong) NSString *VehicleManuName_en;
@property (nonatomic,strong) NSString *VehicleManYear;
@property (nonatomic,strong) NSString *VechilePhoto;
@property (nonatomic,strong) NSString *VehicleNoOfSeats;

@property (nonatomic,strong) NSString *BasisId;
@property (nonatomic,strong) NSString *BasisArName;
@property (nonatomic,strong) NSString *BasisEnName;
@property (nonatomic,strong) NSString *BasisFrName;
@property (nonatomic,strong) NSString *BasisChName;
@property (nonatomic,strong) NSString *BasisUrName;

@property (nonatomic,strong) NSNumber *Saturday;
@property (nonatomic,strong) NSNumber *Sunday;
@property (nonatomic,strong) NSNumber *Monday;
@property (nonatomic,strong) NSNumber *Tuesday;
@property (nonatomic,strong) NSNumber *Wendenday;
@property (nonatomic,strong) NSNumber *Thrursday;
@property (nonatomic,strong) NSNumber *Friday;

@property (nonatomic,strong) NSNumber *IsSmoking;
@property (nonatomic,strong) NSNumber *IsRounded;
@property (nonatomic,strong) NSNumber *IsPassenger;

@property (nonatomic,strong) NSString *StartTime;
@property (nonatomic,strong) NSString *EndTime;
@property (nonatomic,strong) NSString *StartFromTime;
@property (nonatomic,strong) NSString *StartToTime;
@property (nonatomic,strong) NSString *EndFromTime;
@property (nonatomic,strong) NSString *EndToTime;

@property (nonatomic,strong) NSString *FromStreetName;
@property (nonatomic,strong) NSString *ToStreetName;

@property (nonatomic,strong) NSString *Remarks;

@end
