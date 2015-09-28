//
//  AuthenticationManager.h
//  Sharekni
//
//  Created by Mohamed Abd El-latef on 9/26/15.
//
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "BaseAPIManager.h"
#import "User.h"

@interface MobAccountManager : BaseAPIManager

- (void) checkLoginWithUserName:(NSString *)userName andPassword:(NSString *)password WithSuccess:(void (^)(User *user))success Failure:(void (^)(NSString *error))failure;
+(MobAccountManager *)sharedMobAccountManager;

@end
