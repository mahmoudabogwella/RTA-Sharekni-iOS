//
//  User.h
//  HappinessWebView
//
//  Created by Sayeed Adeel Mahmood on 3/24/16.
//  Copyright © 2016 Sayeed Adeel Mahmood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserH : NSObject

/**
 * Any of
 *LOCAL | MYID | ANONYMOUS
 *Where LOCAL to be used with Departments Local User Profile.
 * @param source
 * Required
 */
@property(nonatomic, strong)NSString *source;

/**
 * Username in case available
 * @param userName
 * Conditional - username is required when source is LOCAL
 */
@property(nonatomic, strong)NSString *username;

/**
 * User Email in case available.
 * @param email
 * Optional
 */
@property(nonatomic, strong)NSString *email;


/**
 * User Mobile in case available
 *Format “9715X XXXXXXX”
 * @param mobile
 * Optional
 */
@property(nonatomic, strong)NSString *mobile;

- (instancetype)initWithPrams:(NSString *)source username:(NSString *)username email:(NSString *)email mobile:(NSString *)mobile;
-(NSMutableDictionary *)getDictionary;
    
@end
