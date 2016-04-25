//
//  NotificationsViewController.h
//  sharekni
//
//  Created by Ahmed Askar on 11/20/15.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Notification.h"
@interface NotificationsViewController : BaseViewController

@property (nonatomic,strong) NSString *IsItPorDHuH;
@property (nonatomic ,strong) Notification *notification ;
@property (nonatomic,strong) NSString *NotificationNameVC;

@end