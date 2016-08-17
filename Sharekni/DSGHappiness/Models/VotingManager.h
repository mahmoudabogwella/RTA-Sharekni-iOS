//
//  VotingManager.h
//  HappinessWebView
//
//  Created by Sayeed Adeel Mahmood on 3/24/16.
//  Copyright © 2016 Sayeed Adeel Mahmood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "VotingRequest.h"
#import "Util.h"
#import "NSString+DSGHappinessCrypto.h"

@interface VotingManager : NSObject

/**
 *
 * @param serviceProviderSecret {@link serviceProviderSecret}
 */
@property(nonatomic, strong)NSString *serviceProviderSecret;

/**
 *
 * @param lang {@link lang}
 */
@property(nonatomic, strong)NSString *lang;


/**
 *
 * @param clientID {@link clientID}
 */
@property(nonatomic, strong)NSString *clientID;

/**
 *
 * @param requestUrl {@link requestUrl}
 */
@property(nonatomic, strong)NSString *requestUrl;

/**
 *
 * @param random {@link random}
 */
@property(nonatomic, strong)NSString *random;

- (instancetype)initWithPrams:(NSString *)serviceProviderSecret clientID:(NSString *)clientID lang:(NSString *)lang;

-(void)loadRequestWithWebView:(UIWebView *)webView usingVotignRequest:(VotingRequest *)votingRequest;

@end
