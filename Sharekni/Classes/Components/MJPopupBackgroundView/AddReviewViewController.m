//
//  MJDetailViewController.m
//  MJPopupViewControllerDemo
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import "AddReviewViewController.h"
#import "MobAccountManager.h"
#import "Constants.h"
#import <KVNProgress/KVNProgress.h>

@implementation AddReviewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [viewText becomeFirstResponder];
}

- (void)HideKeyboard
{
    [viewText resignFirstResponder];
}

- (IBAction)closePopup:(id)sender
{
    if (viewText.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warining" message:@"You must write your review first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return ;
    }
    
    [KVNProgress showWithStatus:@"Loading...."];
    [[MobAccountManager sharedMobAccountManager] reviewDriver:_driverDetails.AccountId PassengerId:self.accountID RouteId:_driverDetails.RouteId ReviewText:viewText.text WithSuccess:^(NSString *user) {
    
        [KVNProgress dismiss];

        if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
            [self.delegate cancelButtonClicked:self];
        }
    
    } Failure:^(NSString *error) {
        [KVNProgress dismiss];
    }];
}

@end