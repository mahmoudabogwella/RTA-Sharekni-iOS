//
//  Constants.h
//  Sharekni
//
//  Created by Mohamed Abd El-latef on 9/26/15.
//
//

#ifndef Sharekni_Constants_h
#define Sharekni_Constants_h



#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#define appDelegate (AppDelegate*)[[UIApplication sharedApplication] delegate]


#define RGBA(r, g, b, a) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:a]

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


#define String_Open_Tag @"<string xmlns=\"http://tempuri.org/\">"
#define String_Close_Tag @"</string>"
#define XML_Open_Tag @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
#define XML_Tag2 @"<string xmlns=\"http://MobAccount.org/\">"
#define XML_Tag1 @"<string xmlns=\"http://Sharekni-MobIOS-Data.org/\">"

//#define Sharkeni_BASEURL @"http://sharekni.sdgstaff.com/_MobFiles/"
#define Sharkeni_BASEURL @"http://sharekni-web.sdg.ae/_mobfiles/"
#define GetAgeRanges_URL @"cls_mobmasterdata.asmx/GetAgeRanges"
#define GetEmirates_URL @"cls_mobmasterdata.asmx/GetEmirates"
#define GetBestDrivers_URL @"cls_mobdriver.asmx/GetBestDrivers"
#define GetMostRides_URL @"CLS_MobRoute.asmx/GetMostDesiredRides"
#define GetMostRideDetails_URL @"cls_mobios.asmx/GetMostDesiredRideDetails"
#define GetDriverRideDetails_URL @"cls_mobios.asmx/GetDriverDetailsByAccountId"


#define GetEmployers_URL @"cls_mobmasterdata.asmx/GetEmployers"
#define GetRegionById_URL @"cls_mobmasterdata.asmx/GetRegionById"
#define GetNationalities_URL @"cls_mobmasterdata.asmx/GetNationalities"
#define GetRegionsByEmirateId_URL @"cls_mobmasterdata.asmx/GetRegionsByEmirateId"
#define GetTermsAndConditions_URL @"cls_mobmasterdata.asmx/GetTermsAndConditions"
#define GetPrefferedLanguages_URL @"cls_mobmasterdata.asmx/GetPrefferedLanguages"
#define GetPhoto_URL @"CLS_MobAccount.asmx/GetPhotoPath"
#define RegisterPassenger_URL @"CLS_MobAccount.asmx/RegisterPassenger"
#define ChangePassword_URL @"CLS_MobAccount.asmx/ChangePassword"
#define CheckLogin_URL @"CLS_MobAccount.asmx/CheckLogin"
#define ConfirmMobile_URL @"CLS_MobAccount.asmx/Confirm_Mobile"
#define DriverReviewList_URL @"CLS_MobAccount.asmx/Driver_GetReviewList"
#define PassengerReviewList_URL @"CLS_MobAccount.asmx/Passenger_GetReviewList"
#define EditProfile_URL @"CLS_MobAccount.asmx/EditProfile"
#define ForgotPassword_URL @"CLS_MobAccount.asmx/ForgetPassword"
#define GetCalculatedRating_URL @"CLS_MobAccount.asmx/GetCalculatedRating"
#define GetPrefferedLanguages_URL @"cls_mobmasterdata.asmx/GetPrefferedLanguages"
#define Passenger_FindRide_URL @"CLS_MobDriver.asmx/Passenger_FindRide"

//MobVehicle
#define GetVehicles_URL @"CLS_MobVehicle.asmx/Get?id=%@"
#define GetVehiclesByDriveID_URL @"CLS_MobVehicle.asmx/GetByDriverId?id=%@"


#pragma Colors
#define Red_HEX @"E30613"
#define Red_UIColor [UIColor add_colorWithRGBHexString:Red_HEX]


#pragma ENUMS

typedef enum RoadType : NSUInteger {
    PeriodicType,
    SingleRideType
} RoadType;

typedef enum AccountType : NSUInteger {
    AccountTypeDriver,
    AccountTypePassenger,
    AccountTypeBoth
} AccountType;

typedef enum TextFieldType : NSUInteger {
    PickupTextField,
    DestinationTextField,
    NationalityTextField,
    LanguageTextField,
    AgeRangeTextField,
    VehiclesTextField
} TextFieldType;


#define API_PARAMETERS_KEYS

#define Account_KEY         @"AccountID"
#define Gender_KEY          @"PreferredGender"
#define Time_KEY            @"Time"
#define FromEmirateID_KEY   @"FromEmirateID"
#define FromRegionID_KEY    @"FromRegionID"
#define ToEmirateID_KEY     @"ToEmirateID"
#define ToRegionID_KEY      @"ToRegionID"
#define Language_KEY        @"PrefferedLanguageId"
#define Nationality_KEY     @"PrefferedNationlaities"
#define AgeRange_KEY        @"AgeRangeId"
#define StartDate_KEY       @"StartDate"
#define IsPeriodic_KEY      @"IsPeriodic"
#define id_KEY @"id"
#define fileName_KEY @"s_FileName"

#endif
