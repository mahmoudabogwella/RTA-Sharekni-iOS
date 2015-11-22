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
#import "MapLookUp.h"
#import "Constants.h"   
#import "MobAccountManager.h"
@implementation MobDriverManager

- (void) findRidesFromEmirate:(Emirate *)fromemirate andFromRegion:(Region *)fromRegion toEmirate:(Emirate *)toEmirate andToRegion:(Region *)toRegion PerfferedLanguage:(Language *)language nationality:(Nationality *)nationality ageRange:(AgeRange *)ageRange date:(NSDate *)date isPeriodic:(BOOL)isPeriodic saveSearch:(BOOL)saveSearch WithSuccess:(void (^)(NSArray *searchResults))success Failure:(void (^)(NSString *error))failure{
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
    NSString *nationalityId  = nationality  ? nationality.ID : @"0";
    NSString *saveSearchString = saveSearch ? @"1":@"0";
    NSString *isPeriodicString = isPeriodic ? @"1":@"0";
    
    NSString *requestBody = [NSString stringWithFormat:@"cls_mobios.asmx/Passenger_FindRide?AccountID=%@&PreferredGender=%@&Time=%@&FromEmirateID=%@&FromRegionID=%@&ToEmirateID=%@&ToRegionID=%@&PrefferedLanguageId=%@&PrefferedNationlaities=%@&AgeRangeId=%@&StartDate=%@&SaveFind=%@&IsPeriodic=%@",accountID,@"N",timeString,fromemirate.EmirateId,fromRegion.ID,toEmirateID,toRegionID,languageId,nationalityId,ageRange ? ageRange.RangeId : @"0" ,dateString,saveSearchString,isPeriodicString];

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

- (void) findRidesFromEmirateID:(NSString *)fromEmirateID andFromRegionID:(NSString *)fromRegionID toEmirateID:(NSString *)toEmirateID andToRegionID:(NSString *)toRegionID PerfferedLanguageID:(NSString *)languageID nationalityID:(NSString *)nationalityID ageRangeID:(NSString *)ageRangeID date:(NSDate *)date isPeriodic:(BOOL)isPeriodic saveSearch:(BOOL)saveSearch WithSuccess:(void (^)(NSArray *searchResults))success Failure:(void (^)(NSString *error))failure{
    
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

    
    NSString *saveSearchString = saveSearch ? @"1":@"0";
    NSString *isPeriodicString = isPeriodic ? @"1":@"0";
    
    NSString *accountID = [[MobAccountManager sharedMobAccountManager] applicationUserID];
    if (accountID.length == 0) {
        accountID = @"0";
    }
    
    NSString *requestBody = [NSString stringWithFormat:@"cls_mobios.asmx/Passenger_FindRide?AccountID=%@&PreferredGender=%@&Time=%@&FromEmirateID=%@&FromRegionID=%@&ToEmirateID=%@&ToRegionID=%@&PrefferedLanguageId=%@&PrefferedNationlaities=%@&AgeRangeId=%@&StartDate=%@&SaveFind=%@&IsPeriodic=%@",accountID,@"N",timeString,fromEmirateID,fromRegionID,toEmirateID,toRegionID,languageID,nationalityID,ageRangeID ,dateString,saveSearchString,isPeriodicString];
    
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
    [self.operationManager POST:@"cls_mobios.asmx/GetMapLookup" parameters:nil success:^(AFHTTPRequestOperation *  operation, id responseObject) {
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

//GET /_mobfiles/cls_mobios.asmx/Driver_CreateCarpool?AccountID=string&EnName=string&FromEmirateID=string&ToEmirateID=string&FromRegionID=string&ToRegionID=string&IsRounded=string&Time=string&Saturday=string&Sunday=string&Monday=string&Tuesday=string&Wednesday=string&Thursday=string&Friday=string&PreferredGender=string&VehicleID=string&NoOfSeats=string&StartLat=string&StartLng=string&EndLat=string&EndLng=string&PrefferedLanguageId=string&PrefferedNationlaities=string&AgeRangeId=string&StartDate=string HTTP/1.1

- (void) createRideWithName:(NSString *)name fromEmirate:(Emirate *)fromEmirate fromRegion:(Region *)fromRegion toEmirate:(Emirate *)toEmirate toRegion:(Region *)toRegion isRounded:(BOOL)isRounded  date:(NSDate *)date saturday:(BOOL) saturday sunday:(BOOL) sunday  monday:(BOOL) monday  tuesday:(BOOL) tuesday  wednesday:(BOOL) wednesday  thursday:(BOOL) thursday friday:(BOOL) friday PreferredGender:(NSString *)gender vehicle:(Vehicle *)vehicle noOfSeats:(NSInteger)noOfSeats language:(Language *)language nationality:(Nationality *)nationality ageRange:(AgeRange *)ageRange  WithSuccess:(void (^)(NSString *response))success Failure:(void (^)(NSString *error))failure;{
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
    
    NSString *toEmirateID    = toEmirate ? toEmirate.EmirateId : @"0";
    NSString *toRegionID     = toRegion  ? toRegion.ID : @"0";
    NSString *languageId     = language  ? language.LanguageId : @"0";
    NSString *nationalityId  = nationality  ? nationality.ID : @"0";
    NSString *ageRangeId  =   ageRange  ? ageRange.RangeId : @"0";
    
    NSString *sat = saturday  ? @"1":@"0";
    NSString *sun = sunday    ? @"1":@"0";
    NSString *mon = monday    ? @"1":@"0";
    NSString *tue = tuesday   ? @"1":@"0";
    NSString *wed = wednesday ? @"1":@"0";
    NSString *thu = thursday  ? @"1":@"0";
    NSString *fri = friday    ? @"1":@"0";
    
    
    NSString *requestBody = [NSString stringWithFormat:@"cls_mobios.asmx/Driver_CreateCarpool?AccountID=%@&EnName=%@&FromEmirateID=%@&ToEmirateID=%@&FromRegionID=%@&ToRegionID=%@&IsRounded=%@&Time=%@&Saturday=%@&Sunday=%@&Monday=%@&Tuesday=%@&Wednesday=%@&Thursday=%@&Friday=%@&PreferredGender=%@&VehicleID=%@&NoOfSeats=%@&StartLat=&StartLng=&EndLat=&EndLng=&PrefferedLanguageId=%@&PrefferedNationlaities=%@&AgeRangeId=%@&StartDate=%@",accountID,name,fromEmirate.EmirateId,toEmirateID,fromRegion.ID,toRegionID,_isRounded,timeString,sat,sun,mon,tue,wed,thu,fri,gender,vehicle.ID.stringValue,_noOfSeats,languageId,nationalityId,ageRangeId,dateString];
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

SYNTHESIZE_SINGLETON_FOR_CLASS(MobDriverManager);
@end

//CLS_MobDriver.asmx/Passenger_FindRide?AccountID=0&PreferredGender=N&Time=&FromEmirateID=1&FromRegionID=184&ToEmirateID=1&ToRegionID=193&PrefferedLanguageId=&PrefferedNationlaities=&AgeRangeId=&StartDate=&SaveFind=&IsPeriodic=

//CLS_MobDriver.asmx/Passenger_FindRide?AccountID=0&PreferredGender=N&Time=&FromEmirateID=1&FromRegionID=184&ToEmirateID=1&ToRegionID=193&PrefferedLanguageId=&PrefferedNationlaities=0&AgeRangeId=0&StartDate=&SaveFind=&IsPeriodic=



