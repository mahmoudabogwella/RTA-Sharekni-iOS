//
//  MobVehicleManager.m
//  sharekni
//
//  Created by Mohamed Abd El-latef on 10/24/15.
//
//

#import "MobVehicleManager.h"
#import "Constants.h"
#import "Vehicle.h"
#import <Genome.h>
#import "MobAccountManager.h"

@implementation MobVehicleManager

- (void) getVehiclesWithSuccess:(void (^)(NSArray *vehicles))success Failure:(void (^)(NSString *error))failure{
//    self.operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://sharekni-web.sdg.ae/_mobfiles"]];
//    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
//    [requestSerializer setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
//    [requestSerializer setValue:@"application/xml" forHTTPHeaderField:@"Accept"];
//    self.operationManager.requestSerializer = requestSerializer;
//    
//    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
//    [responseSerializer.acceptableContentTypes setByAddingObject:@"application/xml"];
//    self.operationManager.responseSerializer = responseSerializer;
    NSString *path = [NSString stringWithFormat:GetVehicles_URL,[[MobAccountManager sharedMobAccountManager] applicationUserID]];
    [self.operationManager GET:path parameters:nil success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        NSError *jsonError;
        NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *resultDictionaries = [NSJSONSerialization JSONObjectWithData:objectData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&jsonError];
        NSMutableArray *Vehicles = [NSMutableArray array];
        for (NSDictionary *dictionary in resultDictionaries) {
            Vehicle *vehicle= [Vehicle gm_mappedObjectWithJsonRepresentation:dictionary];
            [Vehicles addObject:vehicle];
        }
        success(Vehicles);
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"Error %@",error.description);
        failure(error.description);
    }];
}

- (void) getVehiclesByDriverID:(NSString *)driverID Success:(void (^)(NSArray *items))success Failure:(void (^)(NSString *error))failure{
    NSString *path = [NSString stringWithFormat:GetVehiclesByDriveID_URL,[[MobAccountManager sharedMobAccountManager] applicationUserID]];
    [self.operationManager GET:path parameters:nil success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [self jsonStringFromResponse:responseString];
        NSError *jsonError;
        NSData *objectData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *resultDictionaries = [NSJSONSerialization JSONObjectWithData:objectData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&jsonError];
        NSMutableArray *Vehicles = [NSMutableArray array];
        for (NSDictionary *dictionary in resultDictionaries) {
            Vehicle *vehicle= [Vehicle gm_mappedObjectWithJsonRepresentation:dictionary];
            [Vehicles addObject:vehicle];
        }
        success(Vehicles);
        
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"Error %@",error.description);
        failure(error.description);
    }];
}

SYNTHESIZE_SINGLETON_FOR_CLASS(MobVehicleManager);
@end
