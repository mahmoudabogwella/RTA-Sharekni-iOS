//
//  SplashViewController.h
//  sharekni
//
//  Created by ITWORX on 11/25/15.
//
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface SplashViewController : UIViewController
@property (nonatomic, copy) void (^finishedCallBack)(User *user);
@end
