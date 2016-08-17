//
//  Transaction.h
//  HappinessWebView
//
//  Created by Sayeed Adeel Mahmood on 3/24/16.
//  Copyright © 2016 Sayeed Adeel Mahmood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject

/**
 * Service Provider unique Transaction ID
 * @param transactionID
 * Required
 */
@property(nonatomic, strong)NSString *transactionID;

/**
 * true or false based on if the Service is registered in the GESS System.
 * @param gessEnabled
 * Required
 */
@property(nonatomic, strong)NSString *gessEnabled;

/**
 * Service code (as registered in GESS System)
 * @param serviceCode
 * Optional
 */
@property(nonatomic, strong)NSString *serviceCode;

/**
 * Service Description
 * @param serviceDescription
 * Required
 */
@property(nonatomic, strong)NSString *serviceDescription;

/**
 * Any of
 * WEB|SMARTAPP|KIOSK|IVR|SMS
 * @param channel
 * Required
 */
@property(nonatomic, strong)NSString *channel;


- (instancetype)initWithPrams:(NSString *)transactionID gessEnabled:(NSString *)gessEnabled serviceCode:(NSString *)serviceCode serviceDescription:(NSString *)serviceDescription channel:(NSString *)channel;

-(NSMutableDictionary *)getDictionary;

@end
