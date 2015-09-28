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
@interface MobAccountManager : BaseAPIManager

+(MobAccountManager *)sharedMobAccountManager;

@end
