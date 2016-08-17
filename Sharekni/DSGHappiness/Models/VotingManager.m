//
//  VotingManager.m
//  HappinessWebView
//
//  Created by Sayeed Adeel Mahmood on 3/24/16.
//  Copyright © 2016 Sayeed Adeel Mahmood. All rights reserved.
//

#import "VotingManager.h"


@implementation VotingManager

- (instancetype)initWithPrams:(NSString *)serviceProviderSecret clientID:(NSString *)clientID lang:(NSString *)lang{
    
    if (!self) {
        self = [super init];
    }
    
    self.serviceProviderSecret = serviceProviderSecret;
    self.clientID = clientID;
    self.lang = lang;
    self.random = [Util getRandomString];
    //set requestUrl if required to be set explicitly.
    self.requestUrl = @"https://happinessmeterqa.dubai.gov.ae/MobileSubmitFeedback";
    
    return self;
}

-(void)loadRequestWithWebView:(UIWebView *)webView usingVotignRequest:(VotingRequest *)votingRequest {
    
    NSString *strJSONPayload =  [Util getJSONString:[votingRequest getDictionary]];
    
    NSString *strSignatureRaw = [NSString stringWithFormat:@"%@|%@", strJSONPayload, self.serviceProviderSecret];
    
    NSString *signature = [strSignatureRaw getSHA512];
    
    NSString *strNonceRaw = [NSString stringWithFormat:@"%@|%@|%@", self.random, votingRequest.header.timestamp, self.serviceProviderSecret];
    
    NSString *nonce = [strNonceRaw getSHA512];
    
    [self loadHappinessForWebview:webView
                  withJsonPayLoad:strJSONPayload
                    withSignature:signature
                     withClientId:self.clientID
                     withLanguage:self.lang
                       withRandom:self.random
                    withTimestamp:votingRequest.header.timestamp
                        withNonce:nonce
         withAdditionalParameters:nil];

    
}

- (void) loadHappinessForWebview:(UIWebView *) webView
                 withJsonPayLoad:(NSString *) jsonPayLoad
                   withSignature:(NSString *) signature
                    withClientId:(NSString *) clientId
                    withLanguage:(NSString *) language
                      withRandom:(NSString *) randomStr
                   withTimestamp:(NSString *) timestamp
                       withNonce:(NSString *) nonce
        withAdditionalParameters:(NSDictionary *) additionalParams{
    
    
    NSString *addParams = @"";
    if (additionalParams != nil) {
        for(NSString *key in additionalParams)
        {
            NSString *value = [additionalParams objectForKey: key];
            addParams = [NSString stringWithFormat:@"%@&%@=%@", addParams, key, [Util encodeForString:value]];
        }
    }
    
    NSString *params = [[NSString alloc] initWithFormat:@"json_payload=%@&signature=%@&client_id=%@&lang=%@&random=%@&timestamp=%@&nonce=%@%@",
                        [Util encodeForString:jsonPayLoad],
                        [Util encodeForString:signature],
                        [Util encodeForString:clientId],
                        [Util encodeForString:language],
                        [Util encodeForString:randomStr],
                        [Util encodeForString:timestamp],
                        [Util encodeForString:nonce], addParams];
    
    
    NSURL *url = [NSURL URLWithString: self.requestUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPBody: [NSData dataWithBytes:params.UTF8String length:params.length]];
    [webView loadRequest: request];
}

@end
