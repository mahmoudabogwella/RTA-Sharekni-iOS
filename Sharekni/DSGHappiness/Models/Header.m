//
//  Header.m
//  HappinessWebView
//
//  Created by Sayeed Adeel Mahmood on 3/24/16.
//  Copyright © 2016 Sayeed Adeel Mahmood. All rights reserved.
//

#import "Header.h"

@implementation Header

- (instancetype)initWithPrams:(NSString *)timestamp serviceProvider:(NSString *)serviceProvider request_type:(REQUEST_TYPE)request_type microApp:(NSString *)microApp microAppDisplay:(NSString *)microAppDisplay themeColor:(NSString *)themeColor{
    
    if (!self) {
        self = [super init];
    }
    
    self.timestamp       = timestamp;
    self.serviceProvider = serviceProvider;
    self.microApp        = microApp;
    self.microAppDisplay = microAppDisplay;
    self.themeColor      = themeColor;
    self.request_type    = request_type;
    
    return self;
}

-(NSMutableDictionary *)getDictionary {
    
    NSMutableDictionary *dictHeader = [[NSMutableDictionary alloc] init];
    [dictHeader setValue:self.timestamp       forKey:@"timestamp"];
    [dictHeader setValue:self.serviceProvider forKey:@"serviceProvider"];
    [dictHeader setValue:self.themeColor      forKey:@"themeColor"];

    
    switch (self.request_type) {
            
        case REQUEST_TRANSACTION_WITHOUT_MICROAPP: {
            [dictHeader setValue:@"" forKey:@"microApp"];
            [dictHeader setValue:@"" forKey:@"microAppDisplay"];
        }
            break;
            
        case REQUEST_APP_WITH_MICROAPP: {
            
            [dictHeader setValue:self.microApp forKey:@"microApp"];
            [dictHeader setValue:self.microAppDisplay forKey:@"microAppDisplay"];
        }
            break;
        case REQUEST_APP_WITHOUT_MICROAPP: {
            
            [dictHeader setValue:@"" forKey:@"microApp"];
            [dictHeader setValue:@"" forKey:@"microAppDisplay"];
        }
            break;
            
        default: {
        }
            break;
    }

    return dictHeader;
}

@end
