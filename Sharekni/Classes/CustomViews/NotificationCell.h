//
//  NotificationCell.h
//  sharekni
//
//  Created by Ahmed Askar on 11/22/15.
//
//

#import <UIKit/UIKit.h>
#import "Notification.h"

@interface NotificationCell : UITableViewCell

@property (nonatomic ,weak) IBOutlet UIImageView *userImage ;
@property (nonatomic ,weak) IBOutlet UILabel *notificationLbl ;
@property (nonatomic ,weak) IBOutlet UILabel *nationality ;

- (void)setNotification:(Notification *)notification ;

@end
