//
//  AuthenticationManager.h
//  Sharekni
//
//  Created by Mohamed Abd El-latef on 9/26/15.
//
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "BaseAPIManager.h"
#import "User.h"

@interface MobAccountManager : BaseAPIManager

@property (nonatomic,strong) User* applicationUser;

- (NSString *) applicationUserID;

- (void) checkLoginWithUserName:(NSString *)userName andPassword:(NSString *)password WithSuccess:(void (^)(User *user))success Failure:(void (^)(NSString *error))failure;

- (void) registerPassengerWithFirstName:(NSString *)firstName lastName:(NSString *)lastName mobile:(NSString *)mobile username:(NSString *)username password:(NSString *)password gender:(NSString *)gender imagePath:(NSString *)photoName birthDate:(NSString *)birthDate nationalityID:(NSString *)nationalityId PreferredLanguageId:(NSString *)langID WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure;

- (void) registerDriverWithFirstName:(NSString *)firstName lastName:(NSString *)lastName mobile:(NSString *)mobile username:(NSString *)username password:(NSString *)password gender:(NSString *)gender imagePath:(NSString *)photoName birthDate:(NSString *)birthDate nationalityID:(NSString *)nationalityId PreferredLanguageId:(NSString *)langID WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure;

- (void) getJoinedRidesWithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure;

- (void) getCreatedRidesWithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure;

- (void) deleteRideWithID:(NSString *)rideID withSuccess:(void (^)(BOOL deletedSuccessfully))success Failure:(void (^)(NSString *error))failure;

- (void) forgetPassword:(NSString *)number andEmail:(NSString *)email WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure ;

+(MobAccountManager *)sharedMobAccountManager;

- (void) reviewDriver:(NSString *)driverId PassengerId:(NSString *)passengerId RouteId:(NSString *)routeId ReviewText:(NSString *)reviewText WithSuccess:(void (^)(NSString *user))success Failure:(void (^)(NSString *error))failure ;

- (void) registerVehicle:(NSString *)AccountId TrafficFileNo:(NSString *)TrafficFileNo BirthDate:(NSString *)BirthDate WithSuccess:(void (^)(NSString *user))success Failure:(void (^)(NSString *error))failure ;

- (void) joinRidePassenger:(NSString *)PassengerID RouteID:(NSString *)RouteID DriverID:(NSString *)DriverID Remark:(NSString *)remark WithSuccess:(void (^)(NSString *user))success Failure:(void (^)(NSString *error))failure ;

- (void) leaveRideWithID:(NSString *) routeID withSuccess:(void (^)(BOOL deletedSuccessfully))success Failure:(void (^)(NSString *error))failure;

@end
