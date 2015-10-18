//
//  MapLookUp.h
//  Sharekni
//
//  Created by Ahmed Askar on 10/11/15.
//
//

#import <Foundation/Foundation.h>

@interface MapLookUp : NSObject

@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *RouteArName;
@property (nonatomic,strong) NSString *RouteEnName;
@property (nonatomic,strong) NSString *PreferredGender;
@property (nonatomic,strong) NSNumber *IsSmoking;
@property (nonatomic,strong) NSString *NoOfSeats;

@property (nonatomic,strong) NSString *StartFromTime;
@property (nonatomic,strong) NSString *StartToTime;
@property (nonatomic,strong) NSString *EndFromTime;
@property (nonatomic,strong) NSString *EndToTime;
@property (nonatomic,strong) NSNumber *IsRounded;
@property (nonatomic,strong) NSNumber *IsPassenger;


@property (nonatomic,strong) NSString *EmployerID;

@property (nonatomic,strong) NSString *Rating;



@property (nonatomic,strong) NSString *FromEmirateId;
@property (nonatomic,strong) NSString *FromEmirateArName;
@property (nonatomic,strong) NSString *FromEmirateEnName;
@property (nonatomic,strong) NSString *FromEmirateFrName;
@property (nonatomic,strong) NSString *FromEmirateChName;
@property (nonatomic,strong) NSString *FromEmirateUrName;

@property (nonatomic,strong) NSString *ToEmirateId;
@property (nonatomic,strong) NSString *ToEmirateArName;
@property (nonatomic,strong) NSString *ToEmirateEnName;
@property (nonatomic,strong) NSString *ToEmirateFrName;
@property (nonatomic,strong) NSString *ToEmirateChName;
@property (nonatomic,strong) NSString *ToEmirateUrName;

@property (nonatomic,strong) NSString *FromRegionId;
@property (nonatomic,strong) NSString *FromRegionArName;
@property (nonatomic,strong) NSString *FromRegionEnName;
@property (nonatomic,strong) NSString *FromRegionFrName;
@property (nonatomic,strong) NSString *FromRegionChName;
@property (nonatomic,strong) NSString *FromRegionUrName;

@property (nonatomic,strong) NSString *ToRegionId;
@property (nonatomic,strong) NSString *ToRegionArName;
@property (nonatomic,strong) NSString *ToRegionEnName;
@property (nonatomic,strong) NSString *ToRegionFrName;
@property (nonatomic,strong) NSString *ToRegionChName;
@property (nonatomic,strong) NSString *ToRegionUrName;

@property (nonatomic,strong) NSString *FromStreetName;
@property (nonatomic,strong) NSString *ToStreetName;
@property (nonatomic,strong) NSString *Remarks;
@property (nonatomic,strong) NSString *AccountId;

@property (nonatomic,strong) NSString *BasisId;
@property (nonatomic,strong) NSString *BasisArName;
@property (nonatomic,strong) NSString *BasisEnName;
@property (nonatomic,strong) NSString *BasisFrName;
@property (nonatomic,strong) NSString *BasisChName;
@property (nonatomic,strong) NSString *BasisUrName;



@property (nonatomic,strong) NSString *RouteId;
@property (nonatomic,strong) NSString *VehicelId;
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

@property (nonatomic,strong) NSString *StartLatitude;
@property (nonatomic,strong) NSString *EndLatitude;
@property (nonatomic,strong) NSString *StartLongitude;
@property (nonatomic,strong) NSString *EndLongitude;

@property (nonatomic,strong) NSString *Saturday;
@property (nonatomic,strong) NSString *Sunday;
@property (nonatomic,strong) NSString *Monday;
@property (nonatomic,strong) NSString *Tuesday;
@property (nonatomic,strong) NSString *Wendenday;
@property (nonatomic,strong) NSString *Thrursday;
@property (nonatomic,strong) NSString *Friday;

@end
/*
 public int ToEmirateId { get; set; }
 public string ToEmirateArName { get; set; }
 public string ToEmirateEnName { get; set; }
 public object ToEmirateFrName { get; set; }
 public object ToEmirateChName { get; set; }
 public object ToEmirateUrName { get; set; }
 */
