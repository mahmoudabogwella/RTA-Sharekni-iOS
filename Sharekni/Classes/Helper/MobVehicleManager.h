//
//  MobVehicleManager.h
//  sharekni
//
//  Created by Mohamed Abd El-latef on 10/24/15.
//
//

#import "BaseAPIManager.h"
#import "Constants.h"
#import "SynthesizeSingleton.h"

@interface MobVehicleManager : BaseAPIManager
- (void) getVehiclesWithSuccess:(void (^)(NSArray *vehicles))success Failure:(void (^)(NSString *error))failure;

- (void) getVehiclesByDriverID:(NSString *)driverID Success:(void (^)(NSArray *vehicles))success Failure:(void (^)(NSString *error))failure;

+(MobVehicleManager *) sharedMobVehicleManager;

@end
