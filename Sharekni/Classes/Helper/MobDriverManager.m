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

@implementation MobDriverManager

- (void) findRidesFromEmirate:(Emirate *)fromemirate andFromRegion:(Region *)fromRegion toEmirate:(Emirate *)toEmirate andToRegion:(Region *)toRegion PerfferedLanguage:(Language *)language nationality:(Nationality *)nationality ageRange:(AgeRange *)ageRange date:(NSDate *)date isPeriodic:(BOOL)isPeriodic WithSuccess:(void (^)(NSArray *searchResults))success Failure:(void (^)(NSString *error))failure{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm";
    NSString *timeString = [dateFormatter stringFromDate:date];
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSString *requestBody = [NSString stringWithFormat:@"cls_mobios.asmx/Passenger_FindRide?AccountID=%@&PreferredGender=%@&Time=%@&FromEmirateID=%@&FromRegionID=%@&ToEmirateID=%@&ToRegionID=%@&PrefferedLanguageId=%@&PrefferedNationlaities=%@&AgeRangeId=%@&StartDate=%@&SaveFind=&IsPeriodic=%@",@"0",@"N",timeString,fromemirate.EmirateId,fromRegion.ID,toEmirate.EmirateId,toRegion.ID,language ? language.LanguageId:@"0",nationality ? nationality.ID : @"0",ageRange ? ageRange.RangeId : @"0" ,dateString,@""];
    
    
//  requestBody = @"CLS_MobDriver.asmx/Passenger_FindRide?AccountID=0&PreferredGender=N&Time=&FromEmirateID=2&FromRegionID=5&ToEmirateID=3&ToRegionID=8&PrefferedLanguageId=0&PrefferedNationlaities=&AgeRangeId=0&StartDate=&SaveFind=0&IsPeriodic=";
    
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

SYNTHESIZE_SINGLETON_FOR_CLASS(MobDriverManager);
@end

//CLS_MobDriver.asmx/Passenger_FindRide?AccountID=0&PreferredGender=N&Time=&FromEmirateID=1&FromRegionID=184&ToEmirateID=1&ToRegionID=193&PrefferedLanguageId=&PrefferedNationlaities=&AgeRangeId=&StartDate=&SaveFind=&IsPeriodic=

//CLS_MobDriver.asmx/Passenger_FindRide?AccountID=0&PreferredGender=N&Time=&FromEmirateID=1&FromRegionID=184&ToEmirateID=1&ToRegionID=193&PrefferedLanguageId=&PrefferedNationlaities=0&AgeRangeId=0&StartDate=&SaveFind=&IsPeriodic=



