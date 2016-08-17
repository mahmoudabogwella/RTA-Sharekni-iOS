//
//  Header.h
//  HappinessWebView
//
//  Created by Sayeed Adeel Mahmood on 3/24/16.
//  Copyright © 2016 Sayeed Adeel Mahmood. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, REQUEST_TYPE) {
    
    REQUEST_TYPE_NONE = 0,
    REQUEST_APP_WITH_MICROAPP    =1,
    REQUEST_APP_WITHOUT_MICROAPP =2,
    REQUEST_TRANSACTION_WITHOUT_MICROAPP=3,
};

@interface Header : NSObject

/**
 * Set UTC timestamp with format : dd/MM/yyyy HH:mm:ss
 * @param timeStamp
 * Required
 */
@property(nonatomic, strong)NSString *timestamp;


/**
 * Set service provider e.g: DSG
 * @param serviceProvider
 * Required
 */
@property(nonatomic, strong)NSString *serviceProvider;


/**
 * Set the service name
 * @param microApp
 * Optional
 */@property(nonatomic, strong)NSString *microApp;

/**
 * Set the service name for display only. English or Arabic according to user language
 * @param microApp
 * Optional
 */@property(nonatomic, strong)NSString *microAppDisplay;


/**
 * Modify the theme color. Both hex and color values are acceptable e.g: red or #FFFFFF
 * @param themeColor
 * Optional
 */
@property(nonatomic, strong)NSString *themeColor;


/**
 * Select the request type from one of the defined enum
 * @param request_type
 * Optional
 */
@property(nonatomic, assign)REQUEST_TYPE request_type;


- (instancetype)initWithPrams:(NSString *)timestamp serviceProvider:(NSString *)serviceProvider request_type:(REQUEST_TYPE)request_type microApp:(NSString *)microApp microAppDisplay:(NSString *)microAppDisplay themeColor:(NSString *)themeColor;

-(NSMutableDictionary *)getDictionary;
    
@end
