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


@implementation MobDriverManager

- (void) findRidesFromEmirate:(Emirate *)fromemirate andFromRegion:(Region *)fromRegion toEmirate:(Emirate *)toEmirate andToRegion:(Region *)toRegion PerfferedLanguage:(Language *)language nationality:(Nationality *)nationality ageRange:(AgeRange *)ageRange date:(NSDate *)date isPeriodic:(BOOL)isPeriodic WithSuccess:(void (^)(NSArray *searchResults))success Failure:(void (^)(NSString *error))failure{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm";
    NSString *timeString = [dateFormatter stringFromDate:date];
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSString *requestBody = [NSString stringWithFormat:@"CLS_MobDriver.asmx/Passenger_FindRide?AccountID=%@&PreferredGender=%@&Time=%@&FromEmirateID=%@&FromRegionID=%@&ToEmirateID=%@&ToRegionID=%@&PrefferedLanguageId=%@&PrefferedNationlaities=%@&AgeRangeId=%@&StartDate=%@&SaveFind=&IsPeriodic=%@",@"0",@"N",timeString,fromemirate.EmirateId,fromRegion.ID,toEmirate.EmirateId,toRegion.ID,language ? language.LanguageId:@"0",nationality ? nationality.ID : @"0",ageRange ? ageRange.RangeId : @"0" ,dateString,@""];
    
    requestBody = @"CLS_MobDriver.asmx/Passenger_FindRide?AccountID=0&PreferredGender=N&Time=&FromEmirateID=2&FromRegionID=5&ToEmirateID=3&ToRegionID=8&PrefferedLanguageId=0&PrefferedNationlaities=&AgeRangeId=0&StartDate=&SaveFind=0&IsPeriodic=";
    
    [self.operationManager GET:requestBody parameters:nil success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];

        if ([responseString containsString:@"0"]) {
            success(nil);
            return;
        }
        else if ([responseString containsString:@"AccountEmail"]){
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
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"Error %@",error.description);
        failure(error.description);
    }];
    
}

SYNTHESIZE_SINGLETON_FOR_CLASS(MobDriverManager);
@end

//CLS_MobDriver.asmx/Passenger_FindRide?AccountID=0&PreferredGender=N&Time=&FromEmirateID=1&FromRegionID=184&ToEmirateID=1&ToRegionID=193&PrefferedLanguageId=&PrefferedNationlaities=&AgeRangeId=&StartDate=&SaveFind=&IsPeriodic=

//CLS_MobDriver.asmx/Passenger_FindRide?AccountID=0&PreferredGender=N&Time=&FromEmirateID=1&FromRegionID=184&ToEmirateID=1&ToRegionID=193&PrefferedLanguageId=&PrefferedNationlaities=0&AgeRangeId=0&StartDate=&SaveFind=&IsPeriodic=



