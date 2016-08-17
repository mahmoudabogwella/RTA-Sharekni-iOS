//
//  MobDriverManager.m
//  Sharekni
//
//  Created by ITWORX on 10/8/15.
//
//

#import "MobDriverManager.h"
#import "Constants.h"
#import <Genome.h>
#import "DriverSearchResult.h"
#import "MapLookupForPassenger.h"
#import "MapLookUp.h"
#import "Constants.h"
#import "MobAccountManager.h"
@implementation MobDriverManager

- (void) findRidesFromEmirate:(Emirate *)fromemirate andFromRegion:(Region *)fromRegion toEmirate:(Emirate *)toEmirate andToRegion:(Region *)toRegion PerfferedLanguage:(Language *)language nationality:(Nationality *)nationality ageRange:(AgeRange *)ageRange date:(NSDate *)date isPeriodic:(NSNumber *)isPeriodic saveSearch:(BOOL)saveSearch Gender:(NSString *)gender Smoke:(NSString *)smoke startLat:(NSString *)startLat startLng:(NSString *)startLng EndLat:(NSString *)EndLat EndLng:(NSString *)EndLng  WithSuccess:(void (^)(NSArray *searchResults))success Failure:(void (^)(NSString *error))failure{
    NSString *dateString;
    NSString *timeString;
    if(date){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"hh:mm";
        timeString = [dateFormatter stringFromDate:date];
        dateFormatter.dateFormat = @"dd/MM/yyyy";
        dateString = [dateFormatter stringFromDate:date];
    }
    else{
        dateString = @"";
        timeString = @"";
    }
    
    NSString *accountID = [[MobAccountManager sharedMobAccountManager] applicationUserID];
    if (accountID.length == 0) {
        accountID = @"0";
    }
    
    NSString *toEmirateID    = toEmirate ? toEmirate.EmirateId : @"0";
    NSString *toRegionID     = toRegion  ? toRegion.ID : @"0";
    NSString *languageId     = language  ? language.LanguageId : @"0";
    NSString *nationalityId  = nationality  ? nationality.ID : @"";
    NSString *saveSearchString = saveSearch ? @"1":@"0";
    NSString *isPeriodicString = @"";
    



    if (isPeriodic) {
        isPeriodicString = [isPeriodic boolValue] ? @"1":@"0";
    }
    //cls_mobios.asmx/Passenger_FindRide?AccountID=string&PreferredGender=string&Time=string&FromEmirateID=string&FromRegionID=string&ToEmirateID=string&ToRegionID=string&PrefferedLanguageId=string&PrefferedNationlaities=string&AgeRangeId=string&StartDate=string&SaveFind=string&IsPeriodic=string&IsSmoking=string&Start_Lat=string&Start_Lng=string&End_Lat=string&End_Lng=string
    NSString *requestBody = [NSString stringWithFormat:@"cls_mobios.asmx/Passenger_FindRide?AccountID=%@&PreferredGender=%@&Time=%@&FromEmirateID=%@&FromRegionID=%@&ToEmirateID=%@&ToRegionID=%@&PrefferedLanguageId=%@&PrefferedNationlaities=%@&AgeRangeId=%@&StartDate=%@&SaveFind=%@&IsPeriodic=%@&IsSmoking=%@&Start_Lat=%@&Start_Lng=%@&End_Lat=%@&End_Lng=%@",accountID,gender,timeString,fromemirate.EmirateId,fromRegion.ID,toEmirateID,toRegionID,languageId,nationalityId,ageRange ? ageRange.RangeId : @"0" ,dateString,saveSearchString,isPeriodicString,smoke,startLat,startLng,EndLat,EndLng];
    NSLog(@"Passenger_FindRide : %@%@",Sharkeni_BASEURL,requestBody);
    [self.operationManager GET:requestBody parameters:nil success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        
        if ([responseString containsString:@"AccountEmail"]){
            NSError *jsonError;
            NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *resultDictionaries = [NSJSONSerialization JSONObjectWithData:objectData
                                                                          options:NSJSONReadingMutableContainers
                                                                            error:&jsonError];
            NSMutableArray *searchResults = [NSMutableArray array];
            for (NSDictionary *dictionary in resultDictionaries) {
                DriverSearchResult *result= [DriverSearchResult gm_mappedObjectWithJsonRepresentation:dictionary];
                [searchResults addObject:result];
            }
            if (success) {
                success(searchResults);
            }
        }
        else if ([responseString containsString:@"0"]){
            success(nil);
            return;
        }
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"Error %@",error.description);
        failure(error.description);
    }];
    
}

- (void) findRidesFromEmirateID:(NSString *)fromEmirateID andFromRegionID:(NSString *)fromRegionID toEmirateID:(NSString *)toEmirateID andToRegionID:(NSString *)toRegionID PerfferedLanguageID:(NSString *)languageID nationalityID:(NSString *)nationalityID ageRangeID:(NSString *)ageRangeID date:(NSDate *)date isPeriodic:(NSNumber *)isPeriodic saveSearch:(NSNumber *)saveSearch startLat:(NSString *)startLat startLng:(NSString *)startLng EndLat:(NSString *)EndLat EndLng:(NSString *)EndLng  WithSuccess:(void (^)(NSArray *searchResults))success Failure:(void (^)(NSString *error))failure{
    
    NSString *dateString;
    NSString *timeString;
    if(date){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"hh:mm";
        timeString = [dateFormatter stringFromDate:date];
        dateFormatter.dateFormat = @"dd/MM/yyyy";
        dateString = [dateFormatter stringFromDate:date];
    }
    else{
        dateString = @"";
        timeString = @"";
    }
    
    
    NSString *saveSearchString = saveSearch.boolValue ? @"1":@"0";
    NSString *isPeriodicString = isPeriodic ? isPeriodic.boolValue ? @"1":@"0" : @"";
    
    NSString *accountID = [[MobAccountManager sharedMobAccountManager] applicationUserID];
    if (accountID.length == 0) {
        accountID = @"0";
    }
    
    NSString *requestBody = [NSString stringWithFormat:@"cls_mobios.asmx/Passenger_FindRide?AccountID=%@&PreferredGender=%@&Time=%@&FromEmirateID=%@&FromRegionID=%@&ToEmirateID=%@&ToRegionID=%@&PrefferedLanguageId=%@&PrefferedNationlaities=%@&AgeRangeId=%@&StartDate=%@&SaveFind=%@&IsPeriodic=%@&IsSmoking=%@&Start_Lat=%@&Start_Lng=%@&End_Lat=%@&End_Lng=%@",accountID,@"N",timeString,fromEmirateID,fromRegionID,toEmirateID,toRegionID,languageID,nationalityID,ageRangeID ,dateString,saveSearchString,isPeriodicString,@"0",startLat,startLng,EndLat,EndLng];
    
    [self.operationManager GET:requestBody parameters:nil success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        
        if ([responseString containsString:@"AccountEmail"]){
            NSError *jsonError;
            NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *resultDictionaries = [NSJSONSerialization JSONObjectWithData:objectData
                                                                          options:NSJSONReadingMutableContainers
                                                                            error:&jsonError];
            NSMutableArray *searchResults = [NSMutableArray array];
            for (NSDictionary *dictionary in resultDictionaries) {
                DriverSearchResult *result= [DriverSearchResult gm_mappedObjectWithJsonRepresentation:dictionary];
                [searchResults addObject:result];
            }
            if (success) {
                success(searchResults);
            }
        }
        else if ([responseString containsString:@"0"]){
            success(nil);
            return;
        }
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"Error %@",error.description);
        failure(error.description);
    }];
}
//mapForDriver

- (void) GetFromOnlyMostDesiredRidesDetails:(NSString *)fromEmirateID andFromRegionID:(NSString *)fromRegionID WithSuccess:(void (^)(NSArray *searchResults))success Failure:(void (^)(NSString *error))failure{
    
    
    NSString *requestBody = [NSString stringWithFormat:@"cls_mobios.asmx/GetFromOnlyMostDesiredRidesDetails?FromEmirateId=%@&FromRegionId=%@",fromEmirateID,fromRegionID];
    
    [self.operationManager GET:requestBody parameters:nil success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        
        if ([responseString containsString:@"AccountEmail"]){
            NSError *jsonError;
            NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *resultDictionaries = [NSJSONSerialization JSONObjectWithData:objectData
                                                                          options:NSJSONReadingMutableContainers
                                                                            error:&jsonError];
            NSMutableArray *searchResults = [NSMutableArray array];
            for (NSDictionary *dictionary in resultDictionaries) {
                DriverSearchResult *result= [DriverSearchResult gm_mappedObjectWithJsonRepresentation:dictionary];
                [searchResults addObject:result];
            }
            if (success) {
                success(searchResults);
            }
        }
        else if ([responseString containsString:@"0"]){
            success(nil);
            return;
        }
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"Error %@",error.description);
        failure(error.description);
    }];
}


- (void) getMapLookupWithSuccess:(void (^)(NSArray *items))success Failure:(void (^)(NSString *error))failure{
    [self.operationManager GET:@"cls_mobios.asmx/GetFromOnlyMostDesiredRides?" parameters:nil success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        NSError *jsonError;
        NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *resultDictionaries = [NSJSONSerialization JSONObjectWithData:objectData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&jsonError];
        NSMutableArray *mapLookUps = [NSMutableArray array];
        for (NSDictionary *dictionary in resultDictionaries) {
            MapLookUp *item= [MapLookUp gm_mappedObjectWithJsonRepresentation:dictionary];
            [mapLookUps addObject:item];
        }
        success(mapLookUps);
    } failure:^(AFHTTPRequestOperation *  operation, NSError * error) {
        
    }];
}

//GonMade NewWepServ

- (void) getMapLookupForPassengerWithSuccess:(NSString *)accountID WithSuccess:(void (^)(NSArray *items))success Failure:(void (^)(NSString *error))failure{
    
    NSString *requestBody = [NSString stringWithFormat:@"cls_mobios.asmx/GetMatchedRoutesForPassengers?driverAccountId=%@",accountID];

    NSLog(@"getMapLookupForPassengerWithSuccess : %@%@",Sharkeni_BASEURL,requestBody);
    [self.operationManager GET:requestBody parameters:nil success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        NSError *jsonError;
        NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *resultDictionaries = [NSJSONSerialization JSONObjectWithData:objectData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&jsonError];
        NSMutableArray *mapLookUpsForPassenger = [NSMutableArray array];
        for (NSDictionary *dictionary in resultDictionaries) {
            MapLookupForPassenger *item= [MapLookupForPassenger gm_mappedObjectWithJsonRepresentation:dictionary];
            [mapLookUpsForPassenger addObject:item];
        }
        success(mapLookUpsForPassenger);
    } failure:^(AFHTTPRequestOperation *  operation, NSError * error) {
        
    }];
}

//GET /_mobfiles/cls_mobios.asmx/Driver_CreateCarpool?AccountID=string&EnName=string&FromEmirateID=string&ToEmirateID=string&FromRegionID=string&ToRegionID=string&IsRounded=string&Time=string&Saturday=string&Sunday=string&Monday=string&Tuesday=string&Wednesday=string&Thursday=string&Friday=string&PreferredGender=string&VehicleID=string&NoOfSeats=string&StartLat=string&StartLng=string&EndLat=string&EndLng=string&PrefferedLanguageId=string&PrefferedNationlaities=string&AgeRangeId=string&StartDate=string HTTP/1.1

- (void) createEditRideWithName:(NSString *)name fromEmirateID:(NSString *)fromEmirateID fromRegionID:(NSString *)fromRegionID toEmirateID:(NSString *)toEmirateID toRegionID:(NSString *)toRegionID isRounded:(BOOL)isRounded  date:(NSDate *)date saturday:(BOOL) saturday sunday:(BOOL) sunday  monday:(BOOL) monday  tuesday:(BOOL) tuesday  wednesday:(BOOL) wednesday  thursday:(BOOL) thursday friday:(BOOL) friday PreferredGender:(NSString *)gender vehicleID:(NSString *)vehicleID noOfSeats:(NSInteger)noOfSeats language:(Language *)language nationality:(Nationality *)nationality ageRange:(AgeRange *)ageRange  isEdit:(BOOL) isEdit routeID:(NSString *)routeID startLat:(NSString *)startLat startLng:(NSString *)startLng endLat:(NSString *)endLat endLng:(NSString *)endLng Smoke:(NSString *)smoke Distance:(NSString *)distance Duration:(NSString *)duration WithSuccess:(void (^)(NSString *response))success Failure:(void (^)(NSString *error))failure{
    
    NSString *dateString;
    NSString *timeString;
    if(date){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"hh:mm";
        timeString = [dateFormatter stringFromDate:date];
        dateFormatter.dateFormat = @"dd/MM/yyyy";
        dateString = [dateFormatter stringFromDate:date];
    }
    else{
        dateString = @"";
        timeString = @"";
    }
    
    
    NSString *accountID = [[MobAccountManager sharedMobAccountManager] applicationUserID];
    if (accountID.length == 0) {
        accountID = @"0";
    }
    
    NSString *_isRounded = isRounded ? @"1":@"0";
    NSString *_noOfSeats = [NSString  stringWithFormat:@"%li",(long)noOfSeats];
    
    NSString *languageId     = language  ? language.LanguageId : @"0";
    NSString *nationalityId  = nationality  ? nationality.ID : @"";
    NSString *ageRangeId  =   ageRange  ? ageRange.RangeId.stringValue: @"0";
    
    NSString *sat = saturday  ? @"1":@"0";
    NSString *sun = sunday    ? @"1":@"0";
    NSString *mon = monday    ? @"1":@"0";
    NSString *tue = tuesday   ? @"1":@"0";
    NSString *wed = wednesday ? @"1":@"0";
    NSString *thu = thursday  ? @"1":@"0";
    NSString *fri = friday    ? @"1":@"0";
    NSString *path;
    if (isEdit) {
        path = [NSString stringWithFormat:@"cls_mobios.asmx/Driver_EditCarpool?RouteID=%@",routeID];
    }
    else{
        path =[NSString stringWithFormat:@"cls_mobios.asmx/Driver_CreateCarpool?AccountID=%@",accountID];
    }
    NSString *requestBody = [NSString stringWithFormat:@"%@&EnName=%@&FromEmirateID=%@&ToEmirateID=%@&FromRegionID=%@&ToRegionID=%@&IsRounded=%@&Time=%@&Saturday=%@&Sunday=%@&Monday=%@&Tuesday=%@&Wednesday=%@&Thursday=%@&Friday=%@&PreferredGender=%@&VehicleID=%@&NoOfSeats=%@&StartLat=%@&StartLng=%@&EndLat=%@&EndLng=%@&PrefferedLanguageId=%@&PrefferedNationlaities=%@&AgeRangeId=%@&StartDate=%@&IsSmoking=%@&Distance=%@&Duration=%@",path,name,fromEmirateID,toEmirateID,fromRegionID,toRegionID,_isRounded,timeString,sat,sun,mon,tue,wed,thu,fri,gender,vehicleID,_noOfSeats,startLat,startLng,endLat,endLng,languageId,nationalityId,ageRangeId,dateString,smoke,distance,duration];
    NSLog(@" createEditRideWithName :  %@%@",Sharkeni_BASEURL,requestBody);

    requestBody = [requestBody stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.operationManager GET:requestBody parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response create ride %@",responseObject);
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        success(responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error.localizedDescription);
    }];
}
- (void) DestinationAndDuration:(NSString *)StartLnglang andEndL:(NSString *)EndLngLang WithSuccess:(void (^)(NSArray *items))success Failure:(void (^)(NSString *error))failure{
    
        NSString *requestBody = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/distancematrix/json?origins=%@&destinations=%@&key=AIzaSyDjDfEe3c7xfwpLqVhktVa9Nkoh2fB9Z_I",StartLnglang,EndLngLang];
        
        NSLog(@"getMapLookupForPassengerWithSuccess : %@",requestBody);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:requestBody parameters:nil success:^(AFHTTPRequestOperation *  operation, id responseObject) {
            
            NSArray *data = responseObject;
            NSLog(@" data : %@",data);
            NSArray *index1 = [data valueForKey:@"rows"];
            NSLog(@" index1 : %@",index1);
            NSArray *index  = index1 ;
            NSString *index2 = [index objectAtIndex:0];
            NSLog(@" index2 : %@",index2);
            NSArray *index3 = [index2 valueForKey:@"elements"];
            NSLog(@" index3 : %@",index3);
            NSArray *index4 = [index3 objectAtIndex:0];
            NSLog(@" index4 : %@",index4);
            NSArray *index5 = [index4 valueForKey:@"distance"];
            NSLog(@" index5 : %@",index5);
            NSString *valueForDistance = [index5 valueForKey:@"value"];
            NSLog(@" index6 : %@",valueForDistance);
            NSArray *index6 = [index4 valueForKey:@"duration"];
            NSLog(@" index5 : %@",index6);
            NSString *valueForDuration = [index6 valueForKey:@"value"];
            NSLog(@" index6 : %@",valueForDuration);

            
        } failure:^(AFHTTPRequestOperation *  operation, NSError * error) {
            
        }];
    }


SYNTHESIZE_SINGLETON_FOR_CLASS(MobDriverManager);
@end

//CLS_MobDriver.asmx/Passenger_FindRide?AccountID=0&PreferredGender=N&Time=&FromEmirateID=1&FromRegionID=184&ToEmirateID=1&ToRegionID=193&PrefferedLanguageId=&PrefferedNationlaities=&AgeRangeId=&StartDate=&SaveFind=&IsPeriodic=

//CLS_MobDriver.asmx/Passenger_FindRide?AccountID=0&PreferredGender=N&Time=&FromEmirateID=1&FromRegionID=184&ToEmirateID=1&ToRegionID=193&PrefferedLanguageId=&PrefferedNationlaities=0&AgeRangeId=0&StartDate=&SaveFind=&IsPeriodic=



