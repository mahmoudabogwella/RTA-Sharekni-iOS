//
//  HelpManager.h
//  Sharekni
//
//  Created by ITWORX on 9/28/15.
//
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

@interface HelpManager : NSObject

@property (nonatomic,strong) NSString *imagesDirectory;
- (void) showAlertWithMessage:(NSString *)message;
+ (HelpManager *) sharedHelpManager;
- (NSInteger) yearsBetweenDate:(NSDate *)date1 andDate:(NSDate *)date2;

@end
