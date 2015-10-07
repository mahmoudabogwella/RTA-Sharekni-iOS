//
//  MasterDataManager.h
//  Sharekni
//
//  Created by Mohamed Abd El-latef on 9/27/15.
//
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "BaseAPIManager.h"
#import "TermsAndCondition.h"
@interface MasterDataManager : BaseAPIManager

+(MasterDataManager *) sharedMasterDataManager;

- (void) GetAgeRangesWithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure;

- (void) GetNationalitiesByID:(NSString *)ID WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure;

- (void) GetTermsAndConditionsWithSuccess:(void (^)(TermsAndCondition *termsAndCondition))success Failure:(void (^)(NSString *error))failure;

- (void) GetPrefferedLanguagesWithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure;

- (void) GetEmployersWithID:(NSString *)ID WithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure;

- (void) GetEmiratesWithSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure;

- (void) GetRegionsByID:(NSString *)ID withSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure;

- (void) GetRegionsByEmirateID:(NSString *)emirateID withSuccess:(void (^)(NSMutableArray *array))success Failure:(void (^)(NSString *error))failure;
@end
