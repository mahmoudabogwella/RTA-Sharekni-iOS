//
//  User.m
//  HappinessWebView
//
//  Created by Sayeed Adeel Mahmood on 3/24/16.
//  Copyright © 2016 Sayeed Adeel Mahmood. All rights reserved.
//

#import "UserH.h"

@implementation UserH

- (instancetype)initWithPrams:(NSString *)source username:(NSString *)username email:(NSString *)email mobile:(NSString *)mobile{
    
    if (!self) {
        self = [super init];
    }
    
    self.source     = source;
    self.username   = username;
    self.email      = email;
    self.mobile     = mobile;
    
    return self;
    
}

-(NSMutableDictionary *)getDictionary {
    
    NSMutableDictionary *dictUser = [[NSMutableDictionary alloc] init];
    [dictUser setValue:self.source   forKey:@"source"];
    [dictUser setValue:self.username forKey:@"username"];
    [dictUser setValue:self.email    forKey:@"email"];
    [dictUser setValue:self.mobile   forKey:@"mobile"];
    return dictUser;
}

/*
 
 

 */


@end
