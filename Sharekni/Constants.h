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


#define Sharkeni_BASEURL @"http://sharekni-web.sdg.ae/_mobfiles/"
#define GetAgeRanges_URL @"cls_mobmasterdata.asmx/GetAgeRanges"
#define GetEmirates_URL @"cls_mobmasterdata.asmx/GetEmirates"
#define GetEmployers_URL @"cls_mobmasterdata.asmx/GetEmployers"
#define GetRegionById_URL @"cls_mobmasterdata.asmx/GetRegionById"
#define GetNationalities_URL @"cls_mobmasterdata.asmx/GetNationalities"
#define GetRegionsByEmirateId_URL @"cls_mobmasterdata.asmx/GetRegionsByEmirateId"
#define GetTermsAndConditions_URL @"cls_mobmasterdata.asmx/GetTermsAndConditions"
#define GetPrefferedLanguages_URL @"cls_mobmasterdata.asmx/GetPrefferedLanguages"

#define RegisterPassenger_URL @"CLS_MobAccount.asmx/RegisterPassenger"
#define ChangePassword_URL @"CLS_MobAccount.asmx/ChangePassword"
#define CheckLogin_URL @"CLS_MobAccount.asmx/CheckLogin"
#define ConfirmMobile_URL @"CLS_MobAccount.asmx/Confirm_Mobile"
#define DriverReviewList_URL @"CLS_MobAccount.asmx/Driver_GetReviewList"
#define PassengerReviewList_URL @"CLS_MobAccount.asmx/Passenger_GetReviewList"
#define EditProfile_URL @"CLS_MobAccount.asmx/EditProfile"
#define ForgotPassword_URL @"CLS_MobAccount.asmx/ForgetPassword"
#define GetCalculatedRating_URL @"CLS_MobAccount.asmx/GetCalculatedRating"


#pragma Colors
#define Red_HEX @"E30613"

#endif
