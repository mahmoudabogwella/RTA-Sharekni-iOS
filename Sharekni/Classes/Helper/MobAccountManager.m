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
#import "Ride.h"
#import "Sharekni.pch"

#define ID_KEY @"id"

#define FirstName_KEY @"firstName"
#define LastName_KEY  @"lastName"
#define Mobile_KEY    @"mobile"
#define UserName_KEY  @"username"
#define Password_KEY  @"password"
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

- (NSString *) applicationUserID{
    return self.applicationUser.ID.stringValue;
}

- (void) registerPassengerWithFirstName:(NSString *)firstName lastName:(NSString *)lastName mobile:(NSString *)mobile username:(NSString *)username password:(NSString *)password gender:(NSString *)gender imagePath:(NSString *)photoName birthDate:(NSString *)birthDate nationalityID:(NSString *)nationalityId PreferredLanguageId:(NSString *)langID WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{

    NSString *body = [NSString stringWithFormat:@"cls_mobios.asmx/RegisterPassenger?firstName=%@&lastName=%@&mobile=%@&username=%@&password=%@&gender=%@&photoName=%@&BirthDate=%@&NationalityId=%@&PreferredLanguageId=%@",firstName,lastName,mobile,username,password,gender,@"",birthDate,nationalityId,langID];
    
    [self.operationManager GET:body parameters:nil success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];

        if([responseString containsString:@"-2"]){
            failure(@"Failed");
        }
        else if ([responseString containsString:@"-1"]){
            failure(@"Failed");
        }
        else{
            success(nil);
        }
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

- (void) registerDriverWithFirstName:(NSString *)firstName lastName:(NSString *)lastName mobile:(NSString *)mobile username:(NSString *)username password:(NSString *)password gender:(NSString *)gender imagePath:(NSString *)photoName birthDate:(NSString *)birthDate nationalityID:(NSString *)nationalityId PreferredLanguageId:(NSString *)langID WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{
    
    NSString *body = [NSString stringWithFormat:@"cls_mobios.asmx/RegisterDriver?firstName=%@&lastName=%@&mobile=%@&username=%@&password=%@&gender=%@&photoName=%@&licenseScannedFileName=%@&TrafficFileNo=%@&BirthDate=%@&NationalityId=%@&PreferredLanguageId=%@",firstName,lastName,mobile,username,password,gender,@"",@"",@"",birthDate,nationalityId,langID];
    
    [self.operationManager GET:body parameters:nil success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        if ([responseString containsString:@"-2"]){
            failure(@"Mobile number already exists");
        }
        else if ([responseString containsString:@"-1"]){
            failure(@"Email already exists");
        }
        else{
            success(nil);
        }
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        failure(error.localizedDescription);
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
   
    NSString *path = [NSString stringWithFormat:@"cls_mobios.asmx/CheckLogin?username=%@&password=%@",userName,password];
    [self.operationManager GET:path parameters:nil success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        if ([responseString containsString:@"ID"]) {
            NSError *jsonError;
            NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:objectData
                                                                             options:NSJSONReadingMutableContainers
                                                                               error:&jsonError];
            User *user = [User gm_mappedObjectWithJsonRepresentation:resultDictionary];
            self.applicationUser = user;
            __block MobAccountManager *blockSelf = self;
            [self GetPhotoWithName:user.PhotoPath withSuccess:^(UIImage *image, NSString *filePath) {
                blockSelf.applicationUser.userImage = image;
                blockSelf.applicationUser.imageLocalPath = filePath;
                success(user);
            } Failure:^(NSString *error) {
                blockSelf.applicationUser.userImage = [UIImage imageNamed:@"Man"];
                blockSelf.applicationUser.imageLocalPath = nil;
                success(user);
            }];
        }
        else if ([responseString containsString:@"-2"]){
            failure(@"Mobile number already exists");
        }
        else if ([responseString containsString:@"-1"]){
            failure(@"Email already exists");
        }
        else if ([responseString containsString:@"0"]){
            failure(@"Email already exists");
        }
        else{
            success(nil);           
        }
        
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        failure(@"incorrect");
    }];
}

- (void) forgetPassword:(NSString *)number andEmail:(NSString *)email WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure
{
    NSString *path = [NSString stringWithFormat:@"cls_mobios.asmx/ForgetPassword?mobile=%@&email=%@",number,email];
    
    [self.operationManager GET:path parameters:nil success:^void(AFHTTPRequestOperation * operation, id responseObject) {
       
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        responseString = [self jsonStringFromResponse:responseString];
        
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        failure(@"incorrect");
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

- (void) getJoinedRidesWithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{
    NSString *path;
    if(self.applicationUser.AccountTypeId.integerValue == 1){
        path = [NSString stringWithFormat:@"cls_mobios.asmx/Driver_GetJoinedRides?AccountId=%@",self.applicationUser.ID.stringValue];
    }
    else{
        path = [NSString stringWithFormat:@"cls_mobios.asmx/Driver_GetJoinedRides?AccountId=%@",self.applicationUser.ID.stringValue];
    }
    
    [self.operationManager GET:path parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        NSError *jsonError;
        NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *resultDictionaries = [NSJSONSerialization JSONObjectWithData:objectData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&jsonError];
        NSMutableArray *rides = [NSMutableArray array];
        for (NSDictionary *dictionary in resultDictionaries) {
            Ride *ride= [Ride gm_mappedObjectWithJsonRepresentation:dictionary];
            [rides addObject:ride];
        }
        success(rides);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failure(error.localizedDescription);
    }];
}

- (void) reviewDriver:(NSString *)driverId PassengerId:(NSString *)passengerId RouteId:(NSString *)routeId ReviewText:(NSString *)reviewText WithSuccess:(void (^)(NSString *user))success Failure:(void (^)(NSString *error))failure
{
    NSDictionary *parameters = @{@"DriverId":driverId,
                                 @"PassengerId":passengerId,
                                 @"RouteId":routeId,
                                 @"ReviewText":reviewText
                                 };

    [self.operationManager POST:Passenger_ReviewDriver parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject)
    {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        
        if (![responseString containsString:@"1"]){
            failure(@"Error");
        }
        success(responseString);
        
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        failure(@"incorrect");
    }];
}

- (void) joinRidePassenger:(NSString *)PassengerID RouteID:(NSString *)RouteID DriverID:(NSString *)DriverID Remark:(NSString *)remark WithSuccess:(void (^)(NSString *user))success Failure:(void (^)(NSString *error))failure
{
    NSDictionary *parameters = @{@"DriverId":DriverID,
                                 @"PassengerId":PassengerID,
                                 @"RouteId":RouteID,
                                 @"s_Remarks":remark
                                 };
    
    [self.operationManager POST:Passenger_SendAlert parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject)
     {
         NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         responseString = [self jsonStringFromResponse:responseString];
         
         if (![responseString containsString:@"1"]){
             failure(@"Error");
         }
         success(responseString);
         
     } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
         failure(@"incorrect");
     }];

}

- (void) registerVehicle:(NSString *)AccountId TrafficFileNo:(NSString *)TrafficFileNo BirthDate:(NSString *)BirthDate WithSuccess:(void (^)(NSString *user))success Failure:(void (^)(NSString *error))failure
{
    NSDictionary *parameters = @{@"AccountId":AccountId,
                                 @"TrafficFileNo":TrafficFileNo,
                                 @"BirthDate":BirthDate
                                 };
    
    [self.operationManager POST:RegisterVehicleWithETService parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject)
     {
         NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         responseString = [self jsonStringFromResponse:responseString];
         
         if ([responseString containsString:@"1"])
         {
             [[NSUserDefaults standardUserDefaults] setValue:TrafficFileNo forKey:@"TrafficFileNo"];
             [[NSUserDefaults standardUserDefaults] setValue:AccountId forKey:@"AccountId"];
             [[NSUserDefaults standardUserDefaults] setValue:BirthDate forKey:@"BirthDate"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             success(responseString);
         }
         else if ([responseString containsString:@"-2"]){
             failure(@"You can't use this file number");
         }
         else if ([responseString containsString:@"-3"]){
             failure(@"Date birth invalid");
         }
         else if ([responseString containsString:@"-4"]){
             failure(@"License verified, but no cars found");
         }
         else if ([responseString containsString:@"-5"]){
             failure(@"Invalid data please check again");
         }
         else if ([responseString containsString:@"-6"]){
//             failure(@"Invalid data please check again");
             [[NSUserDefaults standardUserDefaults] setValue:TrafficFileNo forKey:@"TrafficFileNo"];
             [[NSUserDefaults standardUserDefaults] setValue:AccountId forKey:@"AccountId"];
             [[NSUserDefaults standardUserDefaults] setValue:BirthDate forKey:@"BirthDate"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             success(responseString);
         }
     } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
         failure(@"incorrect");
     }];
}

SYNTHESIZE_SINGLETON_FOR_CLASS(MobAccountManager);
@end
