//
//  Application.h
//  HappinessWebView
//
//  Created by Sayeed Adeel Mahmood on 3/24/16.
//  Copyright © 2016 Sayeed Adeel Mahmood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Application : NSObject

/**
 * Application ID, DSG to provide to Entity during Application Registration.
 * @param applicationID
 * Required
 */
@property(nonatomic, strong)NSString *applicationID;


/**
 * Any of
 WEBAPP|SMARTAPP|DESKTOP
 * @param type
 * Required
 */
@property(nonatomic, strong)NSString *type;

/**
 * Any of
 IOS|ANDROID|BLACKBERRY|WINDOWS |OTHERS
 * @param platform
 * Conditional - Filed Required when type is SMARTAPP
 */
@property(nonatomic, strong)NSString *platform;

/**
 * Web application URL or Mobile Application Store URL.
 *Field is required when type is WEBAPP or SMARTAPP
 * @param url
 * Conditional - *Field is required when type is WEBAPP or SMARTAPP
 */
@property(nonatomic, strong)NSString *url;

/**
 * Customer Notes if Present
 * @param notes
 * Optional
 */
@property(nonatomic, strong)NSString *notes;

/**
 * Application version
 * @param applicationVersion
 * Required
 */
@property(nonatomic, strong)NSString *version;

- (instancetype)initWithPrams:(NSString *)applicationID type:(NSString *)type platform:(NSString *)platform url:(NSString *)url notes:(NSString *)notes;

-(NSMutableDictionary *)getDictionary;

@end
