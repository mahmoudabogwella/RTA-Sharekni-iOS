//
//  AuthenticationManager.m
//  Sharekni
//
//  Created by Mohamed Abd El-latef on 9/26/15.
//
//

#import "MobAccountManager.h"
#import "Nationality.h"
#import <Genome.h>

#import "Sharekni.pch"

#define ID_KEY @"id"

#define FirstName_KEY @"firstName"
#define LastName_KEY  @"lastName"
#define Mobile_KEY    @"mobile"
#define UserName_KEY  @"username"
#define Password_KEY  @"password"
#define Gender_KEY    @"gender"
#define photoName_KEY @"photoName"
#define BirthDate_KEY @"BirthDate"
#define NationalityId_KEY @"NationalityId"
#define PreferredLanguageId_KEY @"PreferredLanguageId"

#define OldPassword_KEY @"oldPassword"
#define NewPassword_KEY @"newPassword"

#define AccountID_KEY @"AccountID"
#define Code_KEY @"Code"

#define DriverId_KEY @"DriverId"
#define PassengerId_KEY @"PassengerId"
#define RouteId_KEY @"RouteId"

#define NewPhotoName_KEY @"NewPhotoName"

#define Email_KEY @"email"


@implementation MobAccountManager

- (void) registerPassengerWithFirstName:(NSString *)firstName lastName:(NSString *)lastName mobile:(NSString *)mobile username:(NSString *)username password:(NSString *)password gender:(NSString *)gender imagePath:(NSString *)photoName birthDate:(NSString *)birthDate nationalityID:(NSString *)nationalityId PreferredLanguageId:(NSString *)langID WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{
    
    NSDictionary *parameters = @{FirstName_KEY:firstName,
                                 LastName_KEY:lastName,
                                 Mobile_KEY:mobile,
                                 UserName_KEY:username,
                                 Password_KEY:password,
                                 Gender_KEY:gender,
                                 photoName_KEY:photoName,
                                 BirthDate_KEY:birthDate,
                                 NationalityId_KEY:nationalityId,
                                 PreferredLanguageId_KEY:langID};
    
    
    
    [self.operationManager POST:RegisterPassenger_URL parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

- (void) changeOldPassword:(NSString *)oldPassword toNewPassword:(NSString *) newPassword WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{
    NSDictionary *parameters = @{ID_KEY:@"",
                                 OldPassword_KEY:oldPassword,
                                 NewPassword_KEY:newPassword};
    [self.operationManager POST:ChangePassword_URL parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

- (void) checkLoginWithUserName:(NSString *)userName andPassword:(NSString *)password WithSuccess:(void (^)(User *user))success Failure:(void (^)(NSString *error))failure{
    NSDictionary *parameters = @{UserName_KEY:userName,
                                 Password_KEY:password};
    
    [self.operationManager GET:CheckLogin_URL parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        if ([responseString containsString:@"ID"]) {
            NSError *jsonError;
            NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:objectData
                                                                             options:NSJSONReadingMutableContainers
                                                                               error:&jsonError];
            User *user = [User gm_mappedObjectWithJsonRepresentation:resultDictionary];
            success(user);
        }
        else{
            success(nil);           
        }
        
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}


- (void) confirmMobileWithCode:(NSString *)code WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{
    NSDictionary *parameters = @{AccountID_KEY:@"",
                                 Code_KEY:code};
    
    [self.operationManager POST:ConfirmMobile_URL parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

- (void) GetDriverReviewListWithDriverID:(NSString *)driverID andRouteId:(NSString *)routeId WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{
    NSDictionary *parameters = @{DriverId_KEY:driverID,
                                 RouteId_KEY:routeId};
    [self.operationManager POST:DriverReviewList_URL parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

- (void) GetPassengerReviewListWithPassengerId:(NSString *)passengerId andRouteId:(NSString *)routeId WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{
    NSDictionary *parameters = @{PassengerId_KEY:passengerId,
                                 RouteId_KEY:routeId};
    [self.operationManager POST:PassengerReviewList_URL parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

- (void) editProfileWithFirstName:(NSString *)firstName lastName:(NSString *)lastName gender:(NSString *)gender birthDate:(NSString *)birthDate nationalityID:(NSString *)nationalityId PreferredLanguageId:(NSString *)langID imagePath:(NSString *)photoName WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{
    
    NSDictionary *parameters = @{ID_KEY:@"",
                                 FirstName_KEY:firstName,
                                 LastName_KEY:lastName,
                                 Gender_KEY:gender,
                                 NewPhotoName_KEY:photoName,
                                 BirthDate_KEY:birthDate,
                                 NationalityId_KEY:nationalityId,
                                 PreferredLanguageId_KEY:langID};
    
    
    [self.operationManager POST:EditProfile_URL parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

- (void) forgotPasswordWithMobile:(NSString *)mobile email:(NSString *)email WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{
    NSDictionary *parameters = @{Mobile_KEY:mobile,
                                 Email_KEY:email};
    
    [self.operationManager POST:ForgotPassword_URL parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

- (void) GetCalculatedRatingsForAccountID:(NSString *)accountID WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{
    NSDictionary *parameters = @{AccountID_KEY:accountID};
    [self.operationManager POST:GetCalculatedRating_URL parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}










SYNTHESIZE_SINGLETON_FOR_CLASS(MobAccountManager);
@end
