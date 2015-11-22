//
//  NotificationsViewController.h
//  sharekni
//
//  Created by Ahmed Askar on 11/20/15.
//
//

#import <UIKit/UIKit.h>

@protocol ReloadNotificationsDelegate <NSObject>

- (void)reloadNotifications ;

@end

@interface NotificationsViewController : UIViewController

@property (nonatomic ,strong) NSMutableArray *notifications;

@end