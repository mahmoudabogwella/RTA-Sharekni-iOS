//
//  MasterDataManager.m
//  Sharekni
//
//  Created by Mohamed Abd El-latef on 9/27/15.
//
//

#import "MasterDataManager.h"
#import "Constants.h"
#import "AgeRange.h"
#import "Nationality.h"
#import "TermsAndCondition.h"
#import <Genome.h>
#import "Language.h"
#import "Employer.h"
#import "Emirate.h"
#import "BestDriver.h"
#import "MostRide.h"
#import "Region.h"
#import "HelpManager.h"
#import "Base64.h"
#import "Constants.h"

@interface MasterDataManager ()
@property (strong,nonatomic) NSArray *nationalties;
@property (strong,nonatomic) NSArray *languages;
@property (strong,nonatomic) NSArray *ageRanges;
@property (strong,nonatomic) NSArray *emirates;
@property (strong,nonatomic) TermsAndCondition *termsAndCondition;
@end

@implementation MasterDataManager

- (instancetype)init{
    if (self = [super init]) {

    }
    return self;
}

- (void) GetAgeRangesWithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{
    if (self.ageRanges) {
        success([self.ageRanges mutableCopy]);
    }
    else{
        __block MasterDataManager *blockSelf = self;
        [self.operationManager GET:GetAgeRanges_URL parameters:nil success:^void(AFHTTPRequestOperation * operation, id responseObject) {
            NSLog(@"%@",responseObject);
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            responseString = [self jsonStringFromResponse:responseString];
            NSError *jsonError;
            NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *resultDictionaries = [NSJSONSerialization JSONObjectWithData:objectData
                                                                          options:NSJSONReadingMutableContainers
                                                                            error:&jsonError];
            NSMutableArray *ageRanges = [NSMutableArray array];
            for (NSDictionary *dictionary in resultDictionaries) {
                AgeRange *range= [AgeRange gm_mappedObjectWithJsonRepresentation:dictionary];
                [ageRanges addObject:range];
            }
            blockSelf.ageRanges = ageRanges;
            if (success) {
                success(ageRanges);
            }
        } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
            NSLog(@"Error %@",error.description);
            failure(error.description);
        }];
    }
}

- (void) GetNationalitiesByID:(NSString *)ID WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{
    if (self.nationalties) {
        success([self.nationalties mutableCopy]);
    }
    else{
        __block MasterDataManager *blockSelf = self;
        NSDictionary *parameters = @{id_KEY:ID};
        [self.operationManager GET:GetNationalities_URL parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject) {
            
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            responseString = [self jsonStringFromResponse:responseString];
            NSError *jsonError;
            NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *resultDictionaries = [NSJSONSerialization JSONObjectWithData:objectData
                                                                          options:NSJSONReadingMutableContainers
                                                                            error:&jsonError];
            NSMutableArray *nationalities = [NSMutableArray array];
            for (NSDictionary *dictionary in resultDictionaries) {
                Nationality *nationality= [Nationality gm_mappedObjectWithJsonRepresentation:dictionary];
                [nationalities addObject:nationality];
            }
            blockSelf.nationalties = nationalities;
            if (success) {
                success(nationalities);
            }

        } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
            NSLog(@"Error %@",error.description);
            failure(error.description);
        }];
    }
}

- (void) GetTermsAndConditionsWithSuccess:(void (^) (TermsAndCondition *termsAndCondition))success Failure:(void (^)(NSString *error))failure{
    if (self.termsAndCondition) {
        success(self.termsAndCondition);
    }
    else{
        __block MasterDataManager *blockSelf = self;
        [self.operationManager GET:GetTermsAndConditions_URL parameters:nil success:^void(AFHTTPRequestOperation * operation, id responseObject) {
            NSLog(@"%@",responseObject);
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            responseString = [self jsonStringFromResponse:responseString];
            NSError *jsonError;
            NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:objectData
                                                                             options:NSJSONReadingMutableContainers
                                                                               error:&jsonError];
            
            TermsAndCondition *termsAndCondition = [TermsAndCondition gm_mappedObjectWithJsonRepresentation:resultDictionary];
            blockSelf.termsAndCondition = termsAndCondition;
            if (success) {
                success(termsAndCondition);
            }
        } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
            NSLog(@"Error %@",error.description);
            failure(error.description);
        }];
        
    }
}

- (void) GetPrefferedLanguagesWithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{
    if (self.languages) {
        success([self.languages mutableCopy]);
    }
    else{
        __block MasterDataManager *blockSelf = self;
        [self.operationManager GET:GetPrefferedLanguages_URL parameters:nil success:^void(AFHTTPRequestOperation * operation, id responseObject) {
            NSLog(@"%@",responseObject);
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            responseString = [self jsonStringFromResponse:responseString];
            NSError *jsonError;
            NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *resultDictionaries = [NSJSONSerialization JSONObjectWithData:objectData
                                                                          options:NSJSONReadingMutableContainers
                                                                            error:&jsonError];
            
            NSMutableArray *languages = [NSMutableArray array];
            for (NSDictionary *dictionary in resultDictionaries) {
                Language *language= [Language gm_mappedObjectWithJsonRepresentation:dictionary];
                [languages addObject:language];
            }
            blockSelf.languages = languages;
            if (success) {
                success(languages);
            }

        } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
            NSLog(@"Error %@",error.description);
            failure(error.description);
        }];
        
    }
}

- (void) GetEmployersWithID:(NSString *)ID WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{
    NSDictionary *parameters = @{id_KEY:ID};
    [self.operationManager GET:GetEmployers_URL parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        NSError *jsonError;
        NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *resultDictionaries = [NSJSONSerialization JSONObjectWithData:objectData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&jsonError];
        
        NSMutableArray *employers = [NSMutableArray array];
        for (NSDictionary *dictionary in resultDictionaries) {
            Employer *employer= [Employer gm_mappedObjectWithJsonRepresentation:dictionary];
            [employers addObject:employer];
        }
        success(employers);
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"Error %@",error.description);
        failure(error.description);
    }];
}

- (void) GetEmiratesWithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{
    if(self.emirates){
        success([self.emirates mutableCopy]);
    }
    else{
        [self.operationManager GET:GetEmirates_URL parameters:nil success:^void(AFHTTPRequestOperation * operation, id responseObject) {
            NSLog(@"%@",responseObject);
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            responseString = [self jsonStringFromResponse:responseString];
            NSError *jsonError;
            NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *resultDictionaries = [NSJSONSerialization JSONObjectWithData:objectData
                                                                          options:NSJSONReadingMutableContainers
                                                                            error:&jsonError];
            NSMutableArray *emirates = [NSMutableArray array];
            for (NSDictionary *dictionary in resultDictionaries) {
                Emirate *emirtae= [Emirate gm_mappedObjectWithJsonRepresentation:dictionary];
                [emirates addObject:emirtae];
            }

            self.emirates = emirates;
            success(emirates);
        } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
            NSLog(@"Error %@",error.description);
            failure(error.description);
        }];
    }
}

- (void) GetBestDrivers:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure
{
    [self.operationManager GET:GetBestDrivers_URL parameters:nil success:^void(AFHTTPRequestOperation * operation, id responseObject) {
     
        NSLog(@"%@",responseObject);
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        NSError *jsonError;
        NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *resultDictionaries = [NSJSONSerialization JSONObjectWithData:objectData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&jsonError];
        NSMutableArray *bestDrivers = [NSMutableArray array];
        for (NSDictionary *dictionary in resultDictionaries) {
            BestDriver *driver= [BestDriver gm_mappedObjectWithJsonRepresentation:dictionary];
            [bestDrivers addObject:driver];
        }
        success(bestDrivers);
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"Error %@",error.description);
        failure(error.description);
    }];
}

- (void) GetMostRides:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure
{
    [self.operationManager GET:GetMostRides_URL parameters:nil success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        NSError *jsonError;
        NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *resultDictionaries = [NSJSONSerialization JSONObjectWithData:objectData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&jsonError];
        NSMutableArray *mostRides = [NSMutableArray array];
        for (NSDictionary *dictionary in resultDictionaries) {
            MostRide *driver= [MostRide gm_mappedObjectWithJsonRepresentation:dictionary];
            [mostRides addObject:driver];
        }
        success(mostRides);
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"Error %@",error.description);
        failure(error.description);
    }];
}


- (void) GetRegionsByID:(NSString *)ID withSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{
    NSDictionary *parameters = @{id_KEY:ID};
    [self.operationManager GET:GetRegionById_URL parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        NSError *jsonError;
        NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *resultDictionaries = [NSJSONSerialization JSONObjectWithData:objectData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&jsonError];
        NSMutableArray *regions = [NSMutableArray array];
        for (NSDictionary *dictionary in resultDictionaries) {
            Region *region= [Region gm_mappedObjectWithJsonRepresentation:dictionary];
            [regions addObject:region];
        }
        success(regions);
        
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"Error %@",error.description);
        failure(error.description);
    }];
}

- (void) GetRegionsByEmirateID:(NSString *)emirateID withSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure{
    NSDictionary *parameters = @{id_KEY:emirateID};
    [self.operationManager GET:GetRegionsByEmirateId_URL parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        NSError *jsonError;
        NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *resultDictionaries = [NSJSONSerialization JSONObjectWithData:objectData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&jsonError];
        NSMutableArray *regions = [NSMutableArray array];
        for (NSDictionary *dictionary in resultDictionaries) {
            Region *region= [Region gm_mappedObjectWithJsonRepresentation:dictionary];
            [regions addObject:region];
        }
        success(regions);
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"Error %@",error.description);
        failure(error.description);
    }];
}

- (void) GetPhotoWithName:(NSString *)name withSuccess:(void (^)(UIImage *image,NSString *filePath))success
Failure:(void (^)(NSString *error))failure{
    if([name isEqualToString:@"NoImage.png"]){
        success(nil,nil);
    }
    else{
        NSString *imagesDirectory = [[HelpManager sharedHelpManager] imagesDirectory];
        NSString *path = [imagesDirectory stringByAppendingPathComponent:name];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
            success(image,path);
        }
        else{
            NSDictionary *parameters = @{fileName_KEY:name};
            [self.operationManager GET:GetPhoto_URL parameters:parameters success:^void(AFHTTPRequestOperation * operation, id responseObject) {
                NSLog(@"%@",responseObject);
                NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSString *base64Tag1 = @"<?xml version=\"1.0\" encoding=\"utf-8\"?>";
                NSString *base64Tag2 = @"<base64Binary xmlns=\"http://MobAccount.org/\">";
                NSString *base64Tag3 = @"</base64Binary>";
                
                responseString = [responseString stringByReplacingOccurrencesOfString:base64Tag1 withString:@""];
                responseString = [responseString stringByReplacingOccurrencesOfString:base64Tag2 withString:@""];
                responseString = [responseString stringByReplacingOccurrencesOfString:base64Tag3 withString:@""];
                responseString = [responseString stringByReplacingOccurrencesOfString:@"\r" withString:@" "];
                NSLog(@"string %@",responseString);
                responseString = [self encodeStringTo64:responseString];
                NSData* data = [Base64 decode:responseString];
                UIImage *image = [UIImage imageWithData:data];
                NSData *pngData = UIImagePNGRepresentation(image);
                [pngData writeToFile:path atomically:YES];
                success(image,path);
            } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
                NSLog(@"Error %@",error.description);
                failure(error.description);
            }];
        }
    }
}

- (NSString*)encodeStringTo64:(NSString*)fromString
{
    NSData *plainData = [fromString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String;
    if ([plainData respondsToSelector:@selector(base64EncodedStringWithOptions:)]) {
        base64String = [plainData base64EncodedStringWithOptions:kNilOptions];  // iOS 7+
    } else {
        base64String = [plainData base64Encoding];                              // pre iOS7
    }
    
    return base64String;
}

SYNTHESIZE_SINGLETON_FOR_CLASS(MasterDataManager);
@end
