//
//  Languages.m
//  KaizenCare
//
//  Created by Askar on 3/25/12.
//  Copyright (c) 2012 Askar. All rights reserved.
//

#import "Languages.h"

#define LANGUAGE_KEY @"language_key"
#define LANGUAGE_CHANGE_NOTIFICATION @"language_change_notification"

@interface Languages()

@end

@implementation Languages
{
    NSBundle *currentBundle;
}

@synthesize language ;

#pragma mark - Initialization

- (id)init{
	self = [super init];
	if (self) {
		NSNumber *userLang = [[NSUserDefaults standardUserDefaults] objectForKey:LANGUAGE_KEY];
		if (userLang == nil) {
			NSString *deviceLang = [[NSLocale preferredLanguages] objectAtIndex:0];
            if ([deviceLang isEqualToString:@"ar"]) {
                language = Arabic;
            } else if ([deviceLang isEqualToString:@"en"]) {
                language = English;
            }else if ([deviceLang isEqualToString:@"zh-Hans"]) {
                language = Chines;
            }else if ([deviceLang isEqualToString:@"fil-PH"]) {
                language = Philippine;
            }else if ([deviceLang isEqualToString:@"pa-Arab-PK"]) {
                language = Urdu;
            }
			[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:language] forKey:LANGUAGE_KEY];
            [[NSUserDefaults standardUserDefaults] synchronize];
		} else {
			language = [userLang intValue];
		}
		
		[self adjustBundle];
	}
	return self;
}

+ (Languages *)sharedLanguageInstance
{
    static Languages *_sharedInstance = nil ;
    
    static dispatch_once_t oncePredict ;
    
    dispatch_once(&oncePredict, ^{
        _sharedInstance = [[Languages alloc] init];
    });

    return _sharedInstance ;
}

#pragma mark - Adujusting Language

- (void)setLanguage:(LanguageType)newLanguage{
	if (language != newLanguage) {
		language = newLanguage;
		[self adjustBundle];
	}
}

- (void)adjustBundle
{    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:language] forKey:LANGUAGE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    switch (language) {
        case Arabic:
            currentBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"ar" ofType:@"lproj"]];
            break;
        case English:
            currentBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]];
            break;
        case Chines :
            currentBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"]];
            break;
        case Indian :
            currentBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"hi" ofType:@"lproj"]];
            break;
        case Philippine :
            currentBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"fil-PH" ofType:@"lproj"]];
            break;
        case Urdu :
            currentBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"pa-Arab-PK" ofType:@"lproj"]];
            break;
    }
}

#pragma mark - Getting Strings

- (NSString *)getStringForKey:(NSString *)key{
	return [currentBundle localizedStringForKey:key value:@"key not found" table:nil];
}

@end
