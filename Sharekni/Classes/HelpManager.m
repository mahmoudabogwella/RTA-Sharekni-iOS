//
//  HelpManager.m
//  Sharekni
//
//  Created by ITWORX on 9/28/15.
//
//

#import "HelpManager.h"
#import <UIColor+Additions.h>
#import <CRToast.h>
#import "Constants.h"
#import "NSObject+Blocks.h"

@implementation HelpManager

- (void) showAlertWithMessage:(NSString *)message{
//    NSDictionary *options = @{
//                              kCRToastTextKey :message,
//                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
//                              kCRToastBackgroundColorKey : [UIColor whiteColor],
//                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeSpring),
//                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeSpring),
//                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionBottom),
//                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop),
//                              kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),
//                              kCRToastTextColorKey : [UIColor add_colorWithRGBHexString:Red_HEX]
//                              
////                              kCRToastImageKey : [UIImage imageNamed:@""],
////                              kCRToastImageAlignmentKey :NSTextAlignmentLeft,
//                              };
//    [CRToastManager showNotificationWithOptions:options
//                                completionBlock:^{
//                                    NSLog(@"Completed");
//                                    
//                                }];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"", nil) message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:nil, nil];
    [alertView show];
}

- (NSString *)imagesDirectory{
    if (!_imagesDirectory) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *basePath = paths.firstObject;
        _imagesDirectory = [basePath stringByAppendingPathComponent:@"CahcedImages"];
        if(![[NSFileManager defaultManager] fileExistsAtPath:_imagesDirectory]){
            [[NSFileManager defaultManager] createDirectoryAtPath:_imagesDirectory withIntermediateDirectories:NO attributes:0 error:nil];
        }
    }
    return _imagesDirectory;
}


- (NSInteger) yearsBetweenDate:(NSDate *)date1 andDate:(NSDate *)date2{
    NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
    double secondsInyear = 60 * 60 * 24 * 365;
    NSInteger yearsBetweenDates = distanceBetweenDates / secondsInyear;
    return yearsBetweenDates;
}


SYNTHESIZE_SINGLETON_FOR_CLASS(HelpManager);
@end