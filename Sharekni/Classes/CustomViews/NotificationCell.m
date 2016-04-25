//
//  NotificationCell.m
//  sharekni
//
//  Created by Ahmed Askar on 11/22/15.
//
//

#import "NotificationCell.h"
#import "Constants.h"

@implementation NotificationCell

- (void)awakeFromNib{
    // Initialization code
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2.0f ;
    self.userImage.clipsToBounds = YES ;
    self.notificationLbl.textAlignment = NSTextAlignmentNatural ;
    self.deleteRequestBtn.hidden = YES;
    NSLog(@"The notificationName is : %@",_NotificationName);
}

- (void)setNotification:(Notification *)notification{
    NSLog(@"The notificationName is : %@",_NotificationName);
    
    if ([_NotificationName containsString:@"1"]) {
        _NotificationNameVC =@"DriverVC";
        
        if  (notification.isPending && notification.PassengerName){
            self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.PassengerName,GET_STRING(@"Received your invitation and waiting for approval")] ;
        }
        else if (notification.PassengerName) {
            self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.PassengerName,GET_STRING(@"Send you a invitation request")] ;
        }else if (notification.DriverName.length > 0){
            self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.DriverName,GET_STRING(@"Send you a invitation request")] ;;
        }
        
    }
    
    if ( [_NotificationName containsString:@"6"]) {
        _NotificationNameVC =@"DriverVC";
        NSLog(@"WE are in This VC BABy %@",_NotificationNameVC);
        NSLog(@"WE are in This VC BABy %@",_NotificationNameVC);
        NSLog(@"Notification.PassengerAccept : %@",notification.PassengerAccept);
        NSString *PassengerAccepts = [NSString stringWithFormat:@"%@",notification.PassengerAccept];
        
        if ([notification.PassengerAccept isEqual:@"true"] || [ notification.PassengerAccept isEqual:@"1"] || [ PassengerAccepts containsString:@"1"]) {//main
            //
            NSLog(@"Passenger name in cell:  %@",notification.PassengerName);
            if (notification.PassengerName) {
                self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.PassengerName,GET_STRING(@"Has Accepted your invitation")] ;
            }else  if (!notification.PassengerName){
                self.notificationLbl.text = GET_STRING(@"Has Accepted your invitation") ;
            }
            
        }else {
            if (notification.PassengerName) {
                self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.PassengerName,GET_STRING(@"Has Rejected your invitation")] ;
            }else  if (!notification.PassengerName){
                self.notificationLbl.text = GET_STRING(@"Has Rejected your invitation") ;
            }
        }
    }
    
    if ([_NotificationName containsString:@"2"]) {
        _NotificationNameVC =@"DriverVC";
        
        self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.DriverName,GET_STRING(@"Received your request and waiting for approval")] ;
    }
    
    if ([_NotificationName containsString:@"3"] ) {
        _NotificationNameVC =@"DriverVC";
        
        if (notification.DriverName) {
            self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.DriverName,GET_STRING(@"Send you a join request")] ;
        }else if (notification.PassengerName.length > 0){
            self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.PassengerName,GET_STRING(@"Send you a join request")] ;
        }
        
    }
    
    if ([_NotificationName containsString:@"5"] ) {
        _NotificationNameVC =@"DriverVC";
        NSLog(@"WE are in This VC BABy %@",_NotificationNameVC);
        NSLog(@"WE are in This VC BABy %@",_NotificationNameVC);
        NSLog(@"Notification.PassengerAccept : %@",notification.PassengerAccept);
        NSString *PassengerAccepts = [NSString stringWithFormat:@"%@",notification.DriverAccept];
        
        if ([notification.DriverAccept isEqual:@"true"] || [ notification.DriverAccept isEqual:@"1"] || [ PassengerAccepts containsString:@"1"]) {//main
            //
            NSLog(@"Passenger name in cell:  %@",notification.DriverName);
            if (notification.DriverName) {
                self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.DriverName,GET_STRING(@"Has Accepted your request")] ;
            }else  if (!notification.DriverName){
                self.notificationLbl.text = GET_STRING(@"Has Accepted your request") ;
            }
            
        }else {
            if (notification.DriverName) {
                self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.DriverName,GET_STRING(@"Has Rejected your join Request")] ;
            }else  if (!notification.DriverName){
                self.notificationLbl.text = GET_STRING(@"Has Rejected your join Request") ;
            }
        }
    }
    
    if ([_NotificationName containsString:@"4"] ) {
        _NotificationNameVC =@"DriverVC";
        
        if (notification.DriverName) {
            self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.DriverName,GET_STRING(@"Send you a invitation request")] ;
        }else if (notification.PassengerName.length > 0){
            self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.PassengerName,GET_STRING(@"Send you a invitation request")] ;
        }
        
    }
    /*
     if ([_NotificationName containsString:@"1"] || [_NotificationName containsString:@"3"] || [_NotificationName containsString:@"6"]) {
     _NotificationNameVC =@"DriverVC";
     NSLog(@"WE are in This VC BABy %@",_NotificationNameVC);
     NSLog(@"WE are in This VC BABy %@",_NotificationNameVC);
     if ([notification.PassengerName boolValue]) {//main
     //
     NSLog(@"Passenger name in cell:  %@",notification.PassengerName);
     if (notification.PassengerName) {
     self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.PassengerName,GET_STRING(@"Has Accepted your invitation")] ;
     }else  if (!notification.PassengerName){
     self.notificationLbl.text = GET_STRING(@"Has Accepted your invitation") ;
     }
     
     }else{//main
     if  (notification.isPending && notification.PassengerName){
     self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.PassengerName,GET_STRING(@"Received your invitation and waiting for approval")] ;
     }
     else if (notification.PassengerName) {
     self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.PassengerName,GET_STRING(@"Send you a invitation request")] ;
     }else if (notification.DriverName.length > 0){
     self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.DriverName,GET_STRING(@"Send you a invitation request")] ;;
     }
     
     }}
     */
    
    
    //    if ([_NotificationName containsString:@"2"] || [_NotificationName containsString:@"4"] || [_NotificationName containsString:@"5"]) {
    //
    //        _NotificationNameVC =@"PassengerVC";
    //        NSLog(@"WE are in This VC BABy%@",_NotificationNameVC);
    //        NSLog(@"WE are in This VC BABy%@",_NotificationNameVC);
    //        if ([notification.DriverName boolValue]) {//main
    //        NSLog(@"DriverName name in cell:  %@",notification.DriverName);
    //
    //        if (notification.DriverName) {
    //            self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.DriverName,GET_STRING(@"Has Accepted your request")] ;
    //        }else  if (!notification.DriverName){
    //            self.notificationLbl.text = GET_STRING(@"Has Accepted your request") ;
    //        }
    //
    //    }else{//main
    //        if  (notification.isPending && notification.DriverName){
    //            self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.DriverName,GET_STRING(@"Received your request and waiting for approval")] ;
    //        }
    //        else if (notification.DriverName) {
    //            self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.DriverName,GET_STRING(@"Send you a join request")] ;
    //        }else if (notification.PassengerName.length > 0){
    //            self.notificationLbl.text = [NSString stringWithFormat:@"%@ %@",notification.PassengerName,GET_STRING(@"Send you a join request")] ;
    //        }
    //    }
    //
    //
    self.nationality.text = (KIS_ARABIC)?notification.NationalityArName:notification.NationalityEnName ;
    
    if (notification.image)
    {
        self.userImage.image = notification.image ;
    }else{
        self.userImage.image = [UIImage imageNamed:@"thumbnail.png"];
    }
    
    
    
    
    
    //    if(notification.isPending){
    //        self.deleteRequestBtn.alpha = 1;
    //    }
    //    else{
    //        self.deleteRequestBtn.alpha = 0;
    //    }
}
- (void)prepareForReuse{
    self.deleteRequestBtn.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)deleteHandler:(id)sender {
    if (self.deleteHandler) {
        self.deleteHandler();
    }
}

@end
