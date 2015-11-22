//
//  AddRemarksViewController.m
//  sharekni
//
//  Created by Ahmed Askar on 11/20/15.
//
//

#import "AddRemarksViewController.h"
#import "MobAccountManager.h"
#import "Constants.h"
#import <KVNProgress/KVNProgress.h>

@interface AddRemarksViewController ()

@end

@implementation AddRemarksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [viewText becomeFirstResponder];

}

- (void)HideKeyboard
{
    [viewText resignFirstResponder];
}

- (IBAction)closePopup:(id)sender
{
    if (viewText.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warining" message:@"You must write your remark first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return ;
    }
    
    [KVNProgress showWithStatus:@"Loading...."];
    [[MobAccountManager sharedMobAccountManager] reviewDriver:_driverDetails.AccountId PassengerId:self.accountID RouteId:_driverDetails.RouteId ReviewText:viewText.text WithSuccess:^(NSString *user) {
        
        [KVNProgress dismiss];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(dismissButtonClicked:)]) {
            [self.delegate dismissButtonClicked:self];
        }
        
    } Failure:^(NSString *error) {
        [KVNProgress dismiss];
    }];
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
