//
//  Transaction.m
//  HappinessWebView
//
//  Created by Sayeed Adeel Mahmood on 3/24/16.
//  Copyright © 2016 Sayeed Adeel Mahmood. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction


- (instancetype)initWithPrams:(NSString *)transactionID gessEnabled:(NSString *)gessEnabled serviceCode:(NSString *)serviceCode serviceDescription:(NSString *)serviceDescription channel:(NSString *)channel{
    
    if (!self) {
        self = [super init];
    }
    
    self.transactionID      = transactionID;
    self.gessEnabled        = gessEnabled;
    self.serviceCode        = serviceCode;
    self.serviceDescription = serviceDescription;
    self.channel            = channel;
    
    return self;
}

-(NSMutableDictionary *)getDictionary {
    
    NSMutableDictionary *dictTransaction = [[NSMutableDictionary alloc] init];
    [dictTransaction setValue:self.transactionID      forKey:@"transactionID"];
    [dictTransaction setValue:self.gessEnabled        forKey:@"gessEnabled"];
    [dictTransaction setValue:self.serviceCode        forKey:@"serviceCode"];
    [dictTransaction setValue:self.serviceDescription forKey:@"serviceDescription"];
    [dictTransaction setValue:self.channel            forKey:@"channel"];
    return dictTransaction;
}

@end

