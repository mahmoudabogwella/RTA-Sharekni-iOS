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



- (void) findRidesFromEmirate:(Emirate *)fromemirate andFromRegion:(Region *)fromRegion toEmirate:(Emirate *)toEmirate andToRegion:(Region *)toRegion PerfferedLanguage:(Language *)language nationality:(Nationality *)nationality ageRange:(AgeRange *)ageRange date:(NSDate *)date isPeriodic:(BOOL)isPeriodic saveSearch:(BOOL)saveSearch WithSuccess:(void (^)(NSArray *searchResults))success Failure:(void (^)(NSString *error))failure;

- (void) findRidesFromEmirateID:(NSString *)fromEmirateID andFromRegionID:(NSString *)fromRegionID toEmirateID:(NSString *)toEmirateID andToRegionID:(NSString *)toRegionID PerfferedLanguageID:(NSString *)languageID nationalityID:(NSString *)nationalityID ageRangeID:(NSString *)ageRangeID date:(NSDate *)date isPeriodic:(BOOL)isPeriodic saveSearch:(BOOL)saveSearch WithSuccess:(void (^)(NSArray *searchResults))success Failure:(void (^)(NSString *error))failure;

- (void) getMapLookupWithSuccess:(void (^)(NSArray *items))success Failure:(void (^)(NSString *error))failure;

- (void) createRideWithName:(NSString *)name fromEmirate:(Emirate *)fromEmirate fromRegion:(Region *)fromRegion toEmirate:(Emirate *)toEmirate toRegion:(Region *)toRegion isRounded:(BOOL)isRounded  date:(NSDate *)date saturday:(BOOL) saturday sunday:(BOOL) sunday  monday:(BOOL) monday  tuesday:(BOOL) tuesday  wednesday:(BOOL) wednesday  thursday:(BOOL) thursday friday:(BOOL) friday PreferredGender:(NSString *)gender vehicle:(Vehicle *)vehicle noOfSeats:(NSInteger)noOfSeats language:(Language *)language nationality:(Nationality *)nationality ageRange:(AgeRange *)ageRange  WithSuccess:(void (^)(NSString *response))success Failure:(void (^)(NSString *error))failure;

+(MobDriverManager *) sharedMobDriverManager;
@end
