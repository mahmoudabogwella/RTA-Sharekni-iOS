//
//  NotificationsViewController.m
//  sharekni
//
//  Created by Ahmed Askar on 11/20/15.
//
//

#import "NotificationsViewController.h"
#import "MessageUI/MessageUI.h"
#import "Constants.h"
#import <KVNProgress/KVNProgress.h>
#import "NSObject+Blocks.h"
#import <UIColor+Additions.h>
#import "MasterDataManager.h"
#import "HelpManager.h"
#import "MasterDataManager.h"
#import "MobAccountManager.h"
#import "User.h"
#import "NotificationCell.h"
#import "NotificationDetailsViewController.h"
#import "Constants.h"
#import "Notification.h"

@interface NotificationsViewController () <ReloadNotificationsDelegate>

@property (weak, nonatomic) IBOutlet UILabel *emptyLabel;
@property (nonatomic ,weak) IBOutlet UITableView *notificationsList ;
@property (nonatomic ,strong) NSMutableArray *notifications;
@property (nonatomic ,strong) Notification *toBeDeletedNotification;
@end

@implementation NotificationsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _IsItPorDHuH = @"Driver";
    _NotificationNameVC = @"";
    self.title = GET_STRING(@"Notifications");
    self.emptyLabel.text = GET_STRING(@"You don't have any notifications");
    self.notificationsList.tableFooterView = [[UIView alloc] initWithFrame:CGRectNull];
    self.notifications = [NSMutableArray new];
    [self getNotifications2];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotate
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait){
        // your code for portrait mode
        return NO ;
    }else{
        return YES ;
    }
}

//- (void)getNotifications
//{
//    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
//
//    __block NotificationsViewController *blockSelf = self;
//    [KVNProgress showWithStatus:GET_STRING(@"loading")];
//
//    [[MasterDataManager sharedMasterDataManager] getRequestNotifications:[NSString stringWithFormat:@"%@",user.ID] notificationType:NotificationTypeAlert WithSuccess:^(NSMutableArray *array) {
//
//        blockSelf.notifications = array;
//
//        [self.notificationsList reloadData];
//
//        [self getAcceptedNotifications];
//
//    } Failure:^(NSString *error) {
//        NSLog(@"Error in Notifications");
//        [KVNProgress dismiss];
//        [KVNProgress showErrorWithStatus:GET_STRING(@"Error")];
//        [blockSelf performBlock:^{
//            [KVNProgress dismiss];
//        } afterDelay:3];
//    }];
//}
//
//- (void)getAcceptedNotifications{
//    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
//
//    __block NotificationsViewController *blockSelf = self;
//    [KVNProgress showWithStatus:GET_STRING(@"loading")];
//
//    [[MasterDataManager sharedMasterDataManager] getRequestNotifications:[NSString stringWithFormat:@"%@",user.ID] notificationType:NotificationTypeAccepted WithSuccess:^(NSMutableArray *array) {
//
//        [self.notifications addObjectsFromArray:array];
//
//
//
//        [self.notificationsList reloadData];
//
//    } Failure:^(NSString *error) {
//        NSLog(@"Error in Notifications");
//        [KVNProgress dismiss];
//        [KVNProgress showErrorWithStatus:@"Error"];
//        [blockSelf performBlock:^{
//            [KVNProgress dismiss];
//        } afterDelay:3];
//    }];
//}

- (void) getNotifications2{
    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
    
    __block NotificationsViewController *blockSelf = self;
    [KVNProgress showWithStatus:GET_STRING(@"loading")];
    
    [[MasterDataManager sharedMasterDataManager] getRequestNotifications:user.ID.stringValue notificationType:NotificationTypeAlert WithSuccess:^(NSMutableArray *array) {
        
        blockSelf.notifications = array;
        [blockSelf.notificationsList reloadData];
        
        [[MasterDataManager sharedMasterDataManager] getRequestNotifications:user.ID.stringValue notificationType:NotificationTypeAlertForPassenger WithSuccess:^(NSMutableArray *array) {
            
            [blockSelf.notifications addObjectsFromArray:array];
            [blockSelf.notificationsList reloadData];
            
            [[MasterDataManager sharedMasterDataManager] getRequestNotifications:user.ID.stringValue notificationType:NotificationTypeAccepted WithSuccess:^(NSMutableArray *array) {
                
                [blockSelf.notifications addObjectsFromArray:array];
                [blockSelf.notificationsList reloadData];
                [[MasterDataManager sharedMasterDataManager] getRequestNotifications:user.ID.stringValue notificationType:Driver_GetAcceptedInvitationsFromPassenger WithSuccess:^(NSMutableArray *array) {
                    
                    [blockSelf.notifications addObjectsFromArray:array];
                    [blockSelf.notificationsList reloadData];
                    
                    [[MasterDataManager sharedMasterDataManager] getRequestNotifications:user.ID.stringValue notificationType:NotificationTypePending WithSuccess:^(NSMutableArray *array) {
                        [blockSelf.notifications addObjectsFromArray:array];
                        if (blockSelf.notifications.count > 0)
                        {
                            self.emptyLabel.hidden = YES ;
                            self.notificationsList.hidden = NO ;
                        }
                        else
                        {
                            self.emptyLabel.hidden = NO ;
                            self.notificationsList.hidden = YES ;
                        }
                        [[MasterDataManager sharedMasterDataManager] getRequestNotifications:user.ID.stringValue notificationType:Driver_GetPendingInvitationsFromPassenger WithSuccess:^(NSMutableArray *array) {
                            [blockSelf.notifications addObjectsFromArray:array];
                            if (blockSelf.notifications.count > 0)
                            {
                                self.emptyLabel.hidden = YES ;
                                self.notificationsList.hidden = NO ;
                            }
                            else
                            {
                                self.emptyLabel.hidden = NO ;
                                self.notificationsList.hidden = YES ;
                            }
                            [KVNProgress dismiss];
                            [blockSelf.notificationsList reloadData];
                        }/*NotificationTypePending*/ Failure:^(NSString *error) {
                            [blockSelf handleNetworkFailure];
                        }];
                    }/*NotificationTypeAccepted*/ Failure:^(NSString *error) {
                        [blockSelf handleNetworkFailure];
                    }];
                } /*NotificationTypeAlert*/Failure:^(NSString *error) {
                    [blockSelf handleNetworkFailure];
                }];
            } /*NotificationTypeAlert*/Failure:^(NSString *error) {
                [blockSelf handleNetworkFailure];
            }];
        } /*NotificationTypeAlert*/Failure:^(NSString *error) {
            [blockSelf handleNetworkFailure];
        }];
        
        
        
        //
        
        //                [KVNProgress dismiss];
        //                [blockSelf.notificationsList reloadData];
        //            }/*NotificationTypePending*/ Failure:^(NSString *error) {
        //                [blockSelf handleNetworkFailure];
        //            }];
        //        }/*NotificationTypeAccepted*/ Failure:^(NSString *error) {
        //            [blockSelf handleNetworkFailure];
        //        }];
    } /*NotificationTypeAlert*/Failure:^(NSString *error) {
        [blockSelf handleNetworkFailure];
    }];
}

- (void) handleNetworkFailure{
    __block NotificationsViewController *blockSelf = self;
    NSLog(@"Error in Notifications");
    [KVNProgress dismiss];
    [KVNProgress showErrorWithStatus:GET_STRING(@"Error")];
    [blockSelf performBlock:^{
        [KVNProgress dismiss];
    } afterDelay:3];
}

- (void)reloadNotifications
{
    [self getNotifications2];
}

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.notifications.count;
}

- (NotificationCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier  = @"NotificationCell";
    
    NotificationCell *notificationCell = (NotificationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (notificationCell == nil)
    {
        notificationCell = (NotificationCell *)[[[NSBundle mainBundle] loadNibNamed:@"NotificationCell" owner:nil options:nil] objectAtIndex:(KIS_ARABIC)?1:0];
    }
    
    Notification *notification = self.notifications[indexPath.row];
    notificationCell.NotificationName = notification.NotificationName;
    NSLog(@"cellForRowAtIndexPath %@",notification.NotificationName);
    
    
    
    [notificationCell setNotification:notification];
    
    return notificationCell ;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Notification *notification = self.notifications[indexPath.row];
    NSString *NotificationName = [NSString stringWithFormat:@"%@",notification.NotificationName];
    //    NSString *DriverNameValue = [NSString stringWithFormat:@"%@",_notification.PassengerAccept];
    NSLog(@"didSelectRowAtIndexPath: %@",NotificationName);
    if ([NotificationName containsString:@"2"] || [NotificationName containsString:@"4"] || [NotificationName containsString:@"5"]) {
        
        _NotificationNameVC =@"PassengerVC";
        NSLog(@"didSelectRowAtIndexPath in 2,4,5 if: %@",NotificationName);
        
        if (notification.isPending || [NotificationName containsString:@"5"]) {
            if (notification.isPending ) {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:GET_STRING(@"DeleteNotifcationHeaderNot") message:GET_STRING(@"Do you want to delete this request ?") delegate:self cancelButtonTitle:GET_STRING(@"Cancel") otherButtonTitles:GET_STRING(@"Delete"), nil];
                alertView.tag = 1010;
                [alertView show];
                self.toBeDeletedNotification = notification;
            }else  if ([NotificationName containsString:@"5"] ) {
                NSLog(@" [NotificationName containsString:5]");
                
            }
        }
        else{
            NotificationDetailsViewController *notificationDetails = [[NotificationDetailsViewController alloc] initWithNibName:(KIS_ARABIC)?@"NotificationDetailsViewController_ar":@"NotificationDetailsViewController" bundle:nil];
            notificationDetails.delegate = self ;
            notificationDetails.notification = notification ;
            [self.navigationController pushViewController:notificationDetails animated:YES];
        }
    }//Passenger
    else {NSLog(@"Error in pending notifications Request");}
    
    if ([NotificationName containsString:@"1"] || [NotificationName containsString:@"3"] || [NotificationName containsString:@"6"]) {
        
        _NotificationNameVC =@"DriverVC";
        NSLog(@"didSelectRowAtIndexPath in 1,3,6 if: %@",NotificationName);
        if ( [NotificationName containsString:@"6"]) {
            
            NSLog(@" [NotificationName containsString:6]");
        }
        
        if (notification.isPending || [NotificationName containsString:@"6"]) {
            
            if (notification.isPending ) {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:GET_STRING(@"Confirm") message:GET_STRING(@"Do you want to delete this invitation ?") delegate:self cancelButtonTitle:GET_STRING(@"Cancel") otherButtonTitles:GET_STRING(@"Delete"), nil];
                alertView.tag = 1010;
                [alertView show];
                self.toBeDeletedNotification = notification;
            }else  if ([NotificationName containsString:@"6"] ) {
                NSLog(@" [NotificationName containsString:6]");
                
            }
        }
        else  {
            NotificationDetailsViewController *notificationDetails = [[NotificationDetailsViewController alloc] initWithNibName:(KIS_ARABIC)?@"NotificationDetailsViewController_ar":@"NotificationDetailsViewController" bundle:nil];
            notificationDetails.delegate = self ;
            notificationDetails.notification = notification ;
            [self.navigationController pushViewController:notificationDetails animated:YES];
        }
    }
    else {NSLog(@"Error in pending notifications invitation");
        
    }
    /*
     if ([NotificationName containsString:@"1"] || [NotificationName containsString:@"3"] || [NotificationName containsString:@"6"]) {
     _NotificationNameVC =@"DriverVC";
     NSLog(@"didSelectRowAtIndexPath in 1,3,6 if: %@",NotificationName);
     
     if (notification.isPending) {
     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:GET_STRING(@"Confirm") message:GET_STRING(@"Do you want to delete this invitation ?") delegate:self cancelButtonTitle:GET_STRING(@"Cancel") otherButtonTitles:GET_STRING(@"Delete"), nil];
     alertView.tag = 1010;
     [alertView show];
     self.toBeDeletedNotification = notification;
     }
     else{
     NotificationDetailsViewController *notificationDetails = [[NotificationDetailsViewController alloc] initWithNibName:(KIS_ARABIC)?@"NotificationDetailsViewController_ar":@"NotificationDetailsViewController" bundle:nil];
     notificationDetails.delegate = self ;
     notificationDetails.notification = notification ;
     [self.navigationController pushViewController:notificationDetails animated:YES];
     }
     }
     else {NSLog(@"Error in pending notifications invitation");
     
     }
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    if(alertView.tag == 1010){
        __block NotificationsViewController *blockSelf = self;
        //    NSString *DriverNameValue = [NSString stringWithFormat:@"%@",_notification.PassengerAccept];
        NSLog(@"clickedButtonAtIndex  : %@",_NotificationNameVC);
        
        if(self.toBeDeletedNotification && buttonIndex == 1){
            [KVNProgress showWithStatus:GET_STRING(@"loading")];
            
            //Double Checker if passenger or Driver
            
            
            if ([_NotificationNameVC isEqual:@"DriverVC"]) {
                //GonWillMake if for passenger or Driver delete request
                NSLog(@"We are in the Driver VC yep we are in clickedButtonAtIndex : %@",_NotificationNameVC);
                [[MasterDataManager sharedMasterDataManager] deleteRequestWithID:self.toBeDeletedNotification.RequestId.stringValue notificationType:Driver_RemoveInvitation WithSuccess:^(BOOL deleted) {
                    [KVNProgress dismiss];
                    if(deleted){
                        [KVNProgress showSuccessWithStatus:GET_STRING(@"Invitation deleted successfully")];
                        [blockSelf performBlock:^{
                            [KVNProgress dismiss];
                        } afterDelay:3];
                    }
                    else{
                        
                        __block NotificationsViewController *blockSelf = self;
                        [KVNProgress dismiss];
                        [KVNProgress showErrorWithStatus :GET_STRING(@"Cannot delete invitation")];
                        [blockSelf performBlock:^{
                            [KVNProgress dismiss];
                        } afterDelay:3];
                    }
                    [blockSelf getNotifications2];
                } Failure:^(NSString *error) {
                    __block NotificationsViewController *blockSelf = self;
                    [KVNProgress dismiss];
                    [KVNProgress showErrorWithStatus :GET_STRING(@"Cannot delete invitation")];
                    [blockSelf performBlock:^{
                        [KVNProgress dismiss];
                    } afterDelay:3];
                }];
            }
            if ([_NotificationNameVC isEqual:@"PassengerVC"]) {
                //GonWillMake if for passenger or Driver delete request
                NSLog(@"We are in the Passenger VC yep we are in clickedButtonAtIndex : %@",_NotificationNameVC);
                [[MasterDataManager sharedMasterDataManager] deleteRequestWithID:self.toBeDeletedNotification.RequestId.stringValue notificationType:Passenger_RemoveRequest WithSuccess:^(BOOL deleted) {
                    [KVNProgress dismiss];
                    if(deleted){
                        [KVNProgress showSuccessWithStatus:GET_STRING(@"Request deleted successfully")];
                        [blockSelf performBlock:^{
                            [KVNProgress dismiss];
                        } afterDelay:3];
                    }
                    else{
                        
                        __block NotificationsViewController *blockSelf = self;
                        [KVNProgress dismiss];
                        [KVNProgress showErrorWithStatus :GET_STRING(@"Cannot delete Request")];
                        [blockSelf performBlock:^{
                            [KVNProgress dismiss];
                        } afterDelay:3];
                    }
                    [blockSelf getNotifications2];
                } Failure:^(NSString *error) {
                    __block NotificationsViewController *blockSelf = self;
                    [KVNProgress dismiss];
                    [KVNProgress showErrorWithStatus :GET_STRING(@"Cannot delete Request")];
                    [blockSelf performBlock:^{
                        [KVNProgress dismiss];
                    } afterDelay:3];
                }];
            }
        }
    }
}

@end
