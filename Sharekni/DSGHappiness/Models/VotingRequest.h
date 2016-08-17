//
//  VotingRequest.h
//  HappinessWebView
//
//  Created by Sayeed Adeel Mahmood on 3/24/16.
//  Copyright © 2016 Sayeed Adeel Mahmood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserH.h"
#import "Header.h"
#import "Transaction.h"
#import "Application.h"

@interface VotingRequest : NSObject

/**
 *
 * @param user {@link User}
 */
@property(nonatomic, strong)UserH         *user;

/**
 *
 * @param header
 */
@property(nonatomic, strong)Header       *header;

/**
 *
 * @param user {@link User}
 */
@property(nonatomic, strong)Application  *application;

/**
 *
 * @param transaction {@link Transaction}}
 */
@property(nonatomic, strong)Transaction  *transaction;

/**
 * Set additional parameters
 * @param additionalParams
 * Optional
 */
@property(nonatomic, strong)NSDictionary *additionalParams;

-(NSMutableDictionary *)getDictionary;
- (instancetype)initWithPrams:(UserH *)user header:(Header *)Header application:(Application *)application transaction:(Transaction *)transaction;

    
@end
