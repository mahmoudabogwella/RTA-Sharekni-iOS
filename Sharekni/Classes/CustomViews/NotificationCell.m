//
//  NotificationCell.m
//  sharekni
//
//  Created by Ahmed Askar on 11/22/15.
//
//

#import "NotificationCell.h"

@implementation NotificationCell

- (void)awakeFromNib {
    // Initialization code
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2.0f ;
    self.userImage.clipsToBounds = YES ;
}

- (void)setNotification:(Notification *)notification
{
    if ([notification.DriverAccept boolValue]) {
        if (notification.PassengerName) {
            self.notificationLbl.text = [NSString stringWithFormat:@"%@ Has Accepted your request",notification.PassengerName] ;
        }else{
            self.notificationLbl.text = [NSString stringWithFormat:@"Has Accepted your request"] ;
        }
    }else{
        if (notification.PassengerName) {
            self.notificationLbl.text = [NSString stringWithFormat:@"%@ Send you a join request",notification.PassengerName] ;
        }else{
            self.notificationLbl.text = [NSString stringWithFormat:@"Send you a join request"] ;
        }
    }
    self.nationality.text = notification.NationalityEnName ;
    if (notification.image) {
        self.userImage.image = notification.image ;
    }else{
        self.userImage.image = [UIImage imageNamed:@"thumbnail.png"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
