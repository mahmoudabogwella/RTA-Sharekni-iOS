//
//  VotingRequest.m
//  HappinessWebView
//
//  Created by Sayeed Adeel Mahmood on 3/24/16.
//  Copyright © 2016 Sayeed Adeel Mahmood. All rights reserved.
//

#import "VotingRequest.h"
#import "Util.h"

@implementation VotingRequest


- (instancetype)initWithPrams:(UserH *)user header:(Header *)Header application:(Application *)application transaction:(Transaction *)transaction{
    
    if (!self) {
        self = [super init];
    }
   
    self.user   = user;
    self.header = Header;
    self.transaction = transaction;
    self.application = application;
    
    return self;
}

-(NSMutableDictionary *)getDictionary {
    
    NSMutableDictionary *dictJSONPayload =    [[NSMutableDictionary alloc] init];
    
    switch (self.header.request_type) {
            
        case REQUEST_TRANSACTION_WITHOUT_MICROAPP: {
            
            [dictJSONPayload setValue:[self.header getDictionary]      forKey:@"header"];
            [dictJSONPayload setValue:[self.transaction getDictionary] forKey:@"transaction"];
            [dictJSONPayload setValue:[self.user getDictionary]        forKey:@"user"];
        }
            break;
            
        case REQUEST_APP_WITH_MICROAPP:
        case REQUEST_APP_WITHOUT_MICROAPP: {
            
            [dictJSONPayload setValue:[self.header getDictionary]      forKey:@"header"];
            [dictJSONPayload setValue:[self.application getDictionary] forKey:@"application"];
            [dictJSONPayload setValue:[self.user getDictionary]        forKey:@"user"];

        }
            break;
            
        default: {
        }
            break;
    }
    
    return dictJSONPayload;

}


@end
