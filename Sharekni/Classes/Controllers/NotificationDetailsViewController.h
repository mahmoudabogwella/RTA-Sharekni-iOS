//
//  NotificationDetailsViewController.h
//  sharekni
//
//  Created by Ahmed Askar on 11/22/15.
//
//

#import <UIKit/UIKit.h>
#import "Notification.h"

@protocol ReloadNotificationsDelegate <NSObject>

- (void)reloadNotifications ;

@end

@interface NotificationDetailsViewController : UIViewController

@property (nonatomic ,weak) id <ReloadNotificationsDelegate> delegate ;

@property (nonatomic ,strong) Notification *notification ;
@property (nonatomic,strong) NSString *IsItPorDHuH;

@end
