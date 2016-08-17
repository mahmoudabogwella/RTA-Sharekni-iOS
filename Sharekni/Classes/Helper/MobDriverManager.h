//
//  MobDriverManager.h
//  Sharekni
//
//  Created by ITWORX on 10/8/15.
//
//

#import "BaseAPIManager.h"
#import "SynthesizeSingleton.h"
#import "Emirate.h"
#import "Region.h"
#import "Language.h"
#import "Nationality.h"
#import "AgeRange.h"
#import "Vehicle.h"


@interface MobDriverManager : BaseAPIManager


- (void) findRidesFromEmirate:(Emirate *)fromemirate andFromRegion:(Region *)fromRegion toEmirate:(Emirate *)toEmirate andToRegion:(Region *)toRegion PerfferedLanguage:(Language *)language nationality:(Nationality *)nationality ageRange:(AgeRange *)ageRange date:(NSDate *)date isPeriodic:(NSNumber *)isPeriodic saveSearch:(BOOL)saveSearch Gender:(NSString *)gender Smoke:(NSString *)smoke startLat:(NSString *)startLat startLng:(NSString *)startLng EndLat:(NSString *)EndLat EndLng:(NSString *)EndLng  WithSuccess:(void (^)(NSArray *searchResults))success Failure:(void (^)(NSString *error))failure;

- (void) findRidesFromEmirateID:(NSString *)fromEmirateID andFromRegionID:(NSString *)fromRegionID toEmirateID:(NSString *)toEmirateID andToRegionID:(NSString *)toRegionID PerfferedLanguageID:(NSString *)languageID nationalityID:(NSString *)nationalityID ageRangeID:(NSString *)ageRangeID date:(NSDate *)date isPeriodic:(NSNumber *)isPeriodic saveSearch:(NSNumber *)saveSearch startLat:(NSString *)startLat startLng:(NSString *)startLng EndLat:(NSString *)EndLat EndLng:(NSString *)EndLng  WithSuccess:(void (^)(NSArray *searchResults))success Failure:(void (^)(NSString *error))failure;

- (void) getMapLookupWithSuccess:(void (^)(NSArray *items))success Failure:(void (^)(NSString *error))failure;
/*
- (void) getMapLookupForPassenger:(NSString *)accountID WithSuccess:(void (^)(NSArray *items))success Failure:(void (^)(NSString *error))failure;
*/
- (void) getMapLookupForPassengerWithSuccess:(NSString *)accountID WithSuccess:(void (^)(NSArray *items))success Failure:(void (^)(NSString *error))failure;

- (void) GetFromOnlyMostDesiredRidesDetails:(NSString *)fromEmirateID andFromRegionID:(NSString *)fromRegionID WithSuccess:(void (^)(NSArray *searchResults))success Failure:(void (^)(NSString *error))failure;


- (void) createEditRideWithName:(NSString *)name fromEmirateID:(NSString *)fromEmirateID fromRegionID:(NSString *)fromRegionID toEmirateID:(NSString *)toEmirateID toRegionID:(NSString *)toRegionID isRounded:(BOOL)isRounded  date:(NSDate *)date saturday:(BOOL) saturday sunday:(BOOL) sunday  monday:(BOOL) monday  tuesday:(BOOL) tuesday  wednesday:(BOOL) wednesday  thursday:(BOOL) thursday friday:(BOOL) friday PreferredGender:(NSString *)gender vehicleID:(NSString *)vehicleID noOfSeats:(NSInteger)noOfSeats language:(Language *)language nationality:(Nationality *)nationality ageRange:(AgeRange *)ageRange  isEdit:(BOOL) isEdit routeID:(NSString *)routeID startLat:(NSString *)startLat startLng:(NSString *)startLng endLat:(NSString *)endLat endLng:(NSString *)endLng Smoke:(NSString *)smoke Distance:(NSString *)distance Duration:(NSString *)duration WithSuccess:(void (^)(NSString *response))success Failure:(void (^)(NSString *error))failure;

- (void) DestinationAndDuration:(NSString *)StartLnglang andEndL:(NSString *)EndLngLang WithSuccess:(void (^)(NSArray *items))success Failure:(void (^)(NSString *error))failure;
    
+(MobDriverManager *) sharedMobDriverManager;
@end
