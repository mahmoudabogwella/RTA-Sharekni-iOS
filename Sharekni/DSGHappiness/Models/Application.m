//
//  Application.m
//  HappinessWebView
//
//  Created by Sayeed Adeel Mahmood on 3/24/16.
//  Copyright © 2016 Sayeed Adeel Mahmood. All rights reserved.
//

#import "Application.h"

@implementation Application

- (instancetype)initWithPrams:(NSString *)applicationID type:(NSString *)type platform:(NSString *)platform url:(NSString *)url notes:(NSString *)notes{
    
    if (!self) {
        self = [super init];
    }
    
    self.applicationID  = applicationID;
    self.type           = type;
    self.platform       = platform;
    self.url            = url;
    self.notes          = notes;
    
    return self;
}


-(NSMutableDictionary *)getDictionary {
    
    NSMutableDictionary *dictApplication = [[NSMutableDictionary alloc] init];
    [dictApplication setValue:self.applicationID forKey:@"applicationID"];
    [dictApplication setValue:self.type          forKey:@"type"];
    [dictApplication setValue:self.platform      forKey:@"platform"];
    [dictApplication setValue:self.url           forKey:@"url"];
    [dictApplication setValue:self.notes         forKey:@"notes"];
    if(self.version != nil)
        [dictApplication setValue:self.version         forKey:@"version"];
    return dictApplication;
}

@end
