//
//  AddRemarksViewControllerForMap.m
//  sharekni
//
//  Created by killvak on 2/21/16.
//
//


#import "AddRemarksViewControllerForMap.h"
#import "MobAccountManager.h"
#import "Constants.h"
#import <KVNProgress/KVNProgress.h>
#import "User.h"
#import "MobDriverManager.h"
#import "MostRideDetailsDataForPassenger.h"


@interface AddRemarksViewControllerForMap ()

@end

@implementation AddRemarksViewControllerForMap

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [viewText becomeFirstResponder];
    viewText.text = GET_STRING(@"I’d like to invite you to my ride");
    
    if (KIS_ARABIC)
    {
        viewText.textAlignment = NSTextAlignmentRight ;
        self.headerTitle2.textAlignment = NSTextAlignmentRight;
    }
    
    [self.headerTitle setText:GET_STRING(@"Write Your Remarks")];
    [self.headerTitle2 setText:GET_STRING(@"Your Remarks")];
    [self.submitBtn setTitle:GET_STRING(@"Submit") forState:UIControlStateNormal];
}

- (void)HideKeyboard
{
    [viewText resignFirstResponder];
}

- (IBAction)closePopup:(id)sender
{
    if (viewText.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:GET_STRING(@"Attention") message:GET_STRING(@"You must write your remark first") delegate:nil cancelButtonTitle:GET_STRING(@"Ok") otherButtonTitles:nil, nil];
        [alert show];
        return ;
    }
    
    [KVNProgress showWithStatus:GET_STRING(@"Loading...")];
    
    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
    
    
    //    [[MobAccountManager sharedMobAccountManager] joinRidePassenger:[NSString stringWithFormat:@"%@",user.ID] RouteID:self.driverDetails.RouteId DriverID:self.driverDetails.AccountId Remark:viewText.text WithSuccess:^(NSString *user) {
    //
    //        [KVNProgress dismiss];
    //
    //        if (self.delegate && [self.delegate respondsToSelector:@selector(dismissButtonClicked:)]) {
    //            [self.delegate dismissButtonClicked:self];
    //        }
    //        if (self.delegate && [self.delegate respondsToSelector:@selector(didJoinToRideSuccesfully)]) {
    //            [self.delegate didJoinToRideSuccesfully];
    //        }
    //        NSLog(user);
    //        NSLog(@"Succes Sent");
    //        //                        NSLog(@" did enter succes in driversend invition");
    //
    //    } Failure:^(NSString *error) {
    //        [KVNProgress dismiss];
    //        NSLog(error);
    //        NSLog(@"Failed");
    //    }];
    ;
    //    NSLog(_routeDetails.ID.stringValue);
    NSLog(@"There there there ");
    NSLog(_RouteID);
    NSLog(_accountID);
    NSLog(viewText.text);
    ////    NSLog(_routeDetails.AccountId.stringValue);
    //
    //    [[MobDriverManager sharedMobDriverManager] DriverSendInvitation:First RouteID:sec DriverID:thi Remark:tshi WithSuccess:^(NSString *user) {
    //        NSLog(@" did enter succes in driversend invition");
    //        [KVNProgress dismiss];
    //
    //
    //        if (self.delegate && [self.delegate respondsToSelector:@selector(dismissButtonClickedToInvite:)]) {
    //            [self.delegate dismissButtonClickedToInvite:self];
    //        }
    //        if (self.delegate && [self.delegate respondsToSelector:@selector(DidInvitedToTheRide)]) {
    //            [self.delegate DidInvitedToTheRide];
    //        }
    //
    //
    //        NSLog(@"Succes Sent");
    //    } Failure:^(NSString *error) {
    //        NSLog(@"error with the driver send invition");
    //        NSLog(error);
    //        [KVNProgress dismiss];
    //        //        NSLog(error);
    //        NSLog(@"Failed");
    //    }];
    [[MobAccountManager sharedMobAccountManager] DriverSendInvitation:_accountID RouteID:_RouteID DriverID:[NSString stringWithFormat:@"%@",user.ID] Remark:viewText.text WithSuccess:^(NSString *user) {
        NSLog(@" Entering the send AddremarkFormap dialog");
        [KVNProgress dismiss];
        
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(dismissButtonClicked:)]) {
            [self.delegate dismissButtonClicked:self];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(DidInvitedToTheRide)]) {
            [self.delegate DidInvitedToTheRide];
        }
        
        
        NSLog(@"Succes Sent");
    } Failure:^(NSString *error) {
        NSLog(@"error with the driver send invition");
        NSLog(error);
        [KVNProgress dismiss];
        //        NSLog(error);
        NSLog(@"Failed");
    }];
    /*
     [[MobAccountManager sharedMobAccountManager] joinRidePassenger:[NSString stringWithFormat:@"%@",user.ID] RouteID:self.driverDetails.RouteId DriverID:self.driverDetails.AccountId Remark:viewText.text WithSuccess:^(NSString *user) {
     
     NSLog(@" did enter succes in driversend invition");
     [KVNProgress dismiss];
     
     
     if (self.delegate && [self.delegate respondsToSelector:@selector(dismissButtonClickedToInvite:)]) {
     [self.delegate dismissButtonClickedToInvite:self];
     }
     if (self.delegate && [self.delegate respondsToSelector:@selector(DidInvitedToTheRide)]) {
     [self.delegate DidInvitedToTheRide];
     }
     
     
     NSLog(@"Succes Sent");
     } Failure:^(NSString *error) {
     NSLog(@"error with the driver send invition");
     NSLog(error);
     [KVNProgress dismiss];
     //        NSLog(error);
     NSLog(@"Failed");
     }];
     */
    /*    [[MobAccountManager sharedMobAccountManager] DriverSendInvitation:self.driverDetails.AccountId RouteID:PassengerID DriverID:[NSString stringWithFormat:@"%@",user.ID] Remark:tshi WithSuccess:^(NSString *user) {
     */
    
    /*
     [[MobDriverManager sharedMobDriverManager] DriverSendInvitation: [NSString stringWithFormat:@"%@" , user.ID] RouteID:RouteId DriverID:_driverDetails.AccountId Remark:tshi WithSuccess:^(NSString *user) {
     NSLog(@" did enter succes in driversend invition");
     [KVNProgress dismiss];
     
     
     if (self.delegate && [self.delegate respondsToSelector:@selector(dismissButtonClickedToInvite:)]) {
     [self.delegate dismissButtonClickedToInvite:self];
     }
     if (self.delegate && [self.delegate respondsToSelector:@selector(DidInvitedToTheRide)]) {
     [self.delegate DidInvitedToTheRide];
     }
     
     
     NSLog(@"Succes Sent");
     } Failure:^(NSString *error) {
     NSLog(@"error with the driver send invition");
     NSLog(error);
     [KVNProgress dismiss];
     //        NSLog(error);
     NSLog(@"Failed");
     }];*/
    
    //    [[MobDriverManager sharedMobDriverManager] findRidesFromEmirateID:_routeDetails.FromEmirateId.stringValue  andFromRegionID: @"4"/*_routeDetails.FromRegionId.stringValue*/ toEmirateID:@"0" andToRegionID:@"0" PerfferedLanguageID:@"0" nationalityID:@"" ageRangeID:@"0" date:nil isPeriodic:nil saveSearch:nil WithSuccess:^(NSArray *searchResults) {
    //
    //        [KVNProgress dismiss];
    //        NSLog(_routeDetails.FromEmirateId.stringValue);
    //
    //    } Failure:^(NSString *error) {
    //        [KVNProgress dismiss];
    //        NSLog(_routeDetails.FromEmirateId.stringValue);
    //
    //        NSLog(@"Failed with webServe in matching Result");
    //    }];
    
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

@end
