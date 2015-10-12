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
@property (nonatomic,strong) NSString *DriverArName;
@property (nonatomic,strong) NSString *DriverEnName;
@property (nonatomic,strong) NSString *DriverLicenseNo;
@property (nonatomic,strong) NSString *DriverTrafficFileNo;

@property (nonatomic,strong) NSString *EmployerID;

@property (nonatomic,strong) NSString *From_EmirateName_ar;
@property (nonatomic,strong) NSString *From_EmirateName_en;
@property (nonatomic,strong) NSString *From_EmirateName_fr;
@property (nonatomic,strong) NSString *From_EmirateName_ch;

@property (nonatomic,strong) NSString *From_RegionName_ar;
@property (nonatomic,strong) NSString *From_RegionName_en;
@property (nonatomic,strong) NSString *From_RegionName_fr;
@property (nonatomic,strong) NSString *From_RegionName_ch;
@property (nonatomic,strong) NSString *From_RegionName_ur;

@property (nonatomic,strong) NSString *Rating;

@property (nonatomic,strong) NSString *SDG_Route_Coordinates_End_Lat;
@property (nonatomic,strong) NSString *SDG_Route_Coordinates_End_Lng;
@property (nonatomic,strong) NSString *SDG_Route_Coordinates_Start_Lat;
@property (nonatomic,strong) NSString *SDG_Route_Coordinates_Start_Lng;

@property (nonatomic,strong) NSString *SDG_Route_FromEmirate_ID;
@property (nonatomic,strong) NSString *SDG_Route_Name_ar;
@property (nonatomic,strong) NSString *SDG_Route_Name_en;
@property (nonatomic,strong) NSString *SDG_Route_NoOfSeats;
@property (nonatomic,strong) NSString *SDG_Route_PreferredGender;
@property (nonatomic,strong) NSString *SDG_Route_Start_Date;
@property (nonatomic,strong) NSString *SDG_Route_Start_FromTime;
@property (nonatomic,strong) NSString *SDG_Route_ToEmirate_ID;

@property (nonatomic,strong) NSString *SDG_Route_ToRegion_ID;
@property (nonatomic,strong) NSString *SDG_Route_IsRounded;

@property (nonatomic,strong) NSString *To_EmirateName_ar;

@property (nonatomic,strong) NSString *To_EmirateName_en;
@property (nonatomic,strong) NSString *To_EmirateName_fr;
@property (nonatomic,strong) NSString *To_EmirateName_ch;
@property (nonatomic,strong) NSString *To_EmirateName_ur;

@property (nonatomic,strong) NSString *To_RegionName_ar;
@property (nonatomic,strong) NSString *To_RegionName_en;
@property (nonatomic,strong) NSString *To_RegionName_fr;
@property (nonatomic,strong) NSString *To_RegionName_ch;
@property (nonatomic,strong) NSString *To_RegionName_ur;



@property (nonatomic,strong) NSString *FromEmirateId;
@property (nonatomic,strong) NSString *FromEmirateArName;
@property (nonatomic,strong) NSString *FromEmirateEnName;

@property (nonatomic,strong) NSString *ToEmirateId;
@property (nonatomic,strong) NSString *ToEmirateArName;
@property (nonatomic,strong) NSString *ToEmirateEnName;

@property (nonatomic,strong) NSString *FromRegionId;
@property (nonatomic,strong) NSString *FromRegionArName;
@property (nonatomic,strong) NSString *FromRegionEnName;

@property (nonatomic,strong) NSString *ToRegionId;
@property (nonatomic,strong) NSString *ToRegionArName;
@property (nonatomic,strong) NSString *ToRegionEnName;

@property (nonatomic,strong) NSString *RouteId;
@property (nonatomic,strong) NSString *VehicelId;
@property (nonatomic,strong) NSString *NationalityId;
@property (nonatomic,strong) NSString *NationalityArName;
@property (nonatomic,strong) NSString *NationalityEnName;

@property (nonatomic,strong) NSString *PrefLanguageId;
@property (nonatomic,strong) NSString *PrefLanguageArName;
@property (nonatomic,strong) NSString *PrefLanguageEnName;


@property (nonatomic,strong) NSString *BasisId;
@property (nonatomic,strong) NSString *BasisArName;
@property (nonatomic,strong) NSString *BasisEnName;

@property (nonatomic,strong) NSString *FromStreetName;
@property (nonatomic,strong) NSString *ToStreetName;
@property (nonatomic,strong) NSString *Remarks;
@property (nonatomic,strong) NSString *AccountId;


@property (nonatomic,strong) NSString *StartLatitude;
@property (nonatomic,strong) NSString *EndLatitude;
@property (nonatomic,strong) NSString *StartLongitude;
@property (nonatomic,strong) NSString *EndLongitude;

//"StartFromTime": "\/Date(1444323600000)\/",
//"StartToTime": "\/Date(1444323600000)\/",
//"EndFromTime": "\/Date(1444352400000)\/",
//"EndToTime_": "\/Date(1444352400000)\/",
//"IsRounded": false,
//"IsPassenger": false,
//
//"Saturday": true,
//"Sunday": false,
//"Monday": false,
//"Tuesday": false,
//"Wednesday": false,
//"Thursday": false,
//"Friday": false,



@end
