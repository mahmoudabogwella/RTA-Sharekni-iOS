//
//  MostRideDetailsViewController.m
//  sharekni
//
//  Created by Ahmed Askar on 10/31/15.
//
//

#import "MostRideDetailsViewControllerForPassenger.h"
#import "MessageUI/MessageUI.h"
#import "MostRideDetailsForMap.h"
//#import "MostRideDetails.h"
#import "MostRideDetailsDataForPassenger.h"

#import "DriverDetailsViewController.h"
#import "Constants.h"
#import <KVNProgress/KVNProgress.h>
#import "NSObject+Blocks.h"
#import <UIColor+Additions.h>
#import "MasterDataManager.h"
#import "DriverDetailsViewController.h"
#import "MobAccountManager.h"
#import "User.h"
#import "LoginViewController.h"
#import "AddRemarksViewControllerForMap.h"
#import "UIViewController+MJPopupViewController.h"

#import "HappyMeter.h"


@interface MostRideDetailsViewControllerForPassenger ()<SendMSGDelegate/*,MJDetailPopupDelegate*/,MJAddRemarkPopupDelegate,MFMessageComposeViewControllerDelegate ,UIActionSheetDelegate ,UIAlertViewDelegate>

@property (nonatomic ,weak) IBOutlet UILabel *FromRegionName ;
@property (nonatomic ,weak) IBOutlet UILabel *ToRegionName ;
@property (nonatomic ,weak) IBOutlet UITableView *ridesList ;
@property (nonatomic ,strong) NSMutableArray *rides ;

@end

@implementation MostRideDetailsViewControllerForPassenger

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"AccountID %@: ",_WebAccountID);
    NSLog(@"FromRegion %@: ",_FromRegionID);
    NSLog(@"FromEmirate %@: ",_FromEmirateID);
    NSLog(@"TO EmirateID %@ :",_ToEmirateID);
    NSLog(@"TOREgion %@: " ,_ToRegionID);
    NSLog(@"RouteIdString %@: ",_RouteIDString);
    
   
    
    switch ([[Languages sharedLanguageInstance] language]) {
            
            
        case Arabic:
            //
            _LanguageIs = @"Arabic";
            break;
        case English:
            //
            _LanguageIs = @"English";
            //        self.HindiButtonSelector.hidden = NO;
            
            break;
        default:
            NSLog(@"eror with the Language Picker in ShareForPassenger");
            break;
    }
    
    self.title = GET_STRING(@"rideDetails");
    
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    if ([_TheFlag isEqual:@"MapLookUp"]) {
        
        _toLbl.hidden = YES;
    }
//        if ([[Languages sharedLanguageInstance] language] == Philippine) {
//            self.fromLbl.text = GET_STRING(@"From");
//            self.toLbl.text = GET_STRING(@"To");
//        }
    self.fromLbl.text = GET_STRING(@"From");
    self.toLbl.text = GET_STRING(@"To");
    
    if (KIS_ARABIC)
    {
        _FromRegionName.text = _toEmirate;/*[NSString stringWithFormat:@"%@ : %@",_fromEmirate,_ride.FromRegionNameAr] ;*/
        _ToRegionName.text = _fromEmirate; /*[NSString stringWithFormat:@"%@ : %@",_toEmirate,_ride.ToRegionNameAr] ;*/
        self.fromLbl.textAlignment = NSTextAlignmentRight ;
        self.toLbl.textAlignment = NSTextAlignmentRight ;
        _FromRegionName.textAlignment = NSTextAlignmentRight ;
        _ToRegionName.textAlignment = NSTextAlignmentRight ;
    }
    else
    {
        _FromRegionName.text = _toEmirate; /*[NSString stringWithFormat:@"%@ : %@",_ride.FromEmirateNameEn,_ride.FromRegionNameEn] ;*/
        _ToRegionName.text = _fromEmirate; /*[NSString stringWithFormat:@"%@ : %@",_ride.ToEmirateNameEn,_ride.ToRegionNameEn] ;*/
    }
    
    [self getRideDetails];
    

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

-(void) viewWillDisappear:(BOOL)animated {
    if ([_CheckIfCreatRide isEqual:@"CreatedRide"]) {
        NSLog(@" comming from CreatedRide");
        
    
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        [self.navigationController popToRootViewControllerAnimated:YES]; 
    }
        [super viewWillDisappear:animated];}
}



- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getRideDetails
{
    __block MostRideDetailsViewControllerForPassenger *blockSelf = self;
    [KVNProgress showWithStatus:GET_STRING(@"loading")];
    
    [[MasterDataManager sharedMasterDataManager] getRideDetailsFORPASSENGER:_WebAccountID FromEmirateID:_FromEmirateID FromRegionID:_FromRegionID ToEmirateID:_ToEmirateID ToRegionID:_ToRegionID RouteID:_RouteIDString WithSuccess:^(NSMutableArray *array) {
        
        
        //    [[MasterDataManager sharedMasterDataManager] getRideDetails:@"0" FromEmirateID:_ride.FromEmirateId FromRegionID:_ride.FromRegionId ToEmirateID:_ride.ToEmirateId ToRegionID:_ride.ToRegionId WithSuccess:^(NSMutableArray *array) {
        
        blockSelf.rides = array;
        [KVNProgress dismiss];
        [self.ridesList reloadData];
        
    } Failure:^(NSString *error) {
        
        NSLog(@"Error in Best Drivers");
        [KVNProgress dismiss];
        [KVNProgress showErrorWithStatus:@"Error"];
        [blockSelf performBlock:^{
            [KVNProgress dismiss];
        } afterDelay:3];
        
    }];
}

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.rides.count;
}

- (MostRideDetailsForMap *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MostRideDetailsForMap *rideCell = (MostRideDetailsForMap *)[tableView dequeueReusableCellWithIdentifier:MOST_RIDE_DETAILS_CELLID];
    
    if (rideCell == nil)
    {
        rideCell = [[MostRideDetailsForMap alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MOST_RIDE_DETAILS_CELLID];
    }
    
    MostRideDetailsDataForPassenger *ride = self.rides[indexPath.row];
    rideCell.delegate = self ;
    [rideCell setMostRide:ride];
 
    rideCell.InviteButton.tag = indexPath.row;
    [rideCell.InviteButton addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
  
  
    if ( [rideCell.country.text isEqualToString:@"1"]) {
        // add your button
        rideCell.InviteButton.hidden = YES;
//        [self.ridesList reloadData];
    }else if (  [rideCell.country.text isEqualToString:@"0"]) {
        // add your button
        rideCell.InviteButton.hidden = NO;
    }
//    if ([_TheFlag isEqual:@"MapLookUp"]) {
//        NSLog(@"MaplookUp hidden");
//        rideCell.InviteButton.hidden = YES;
//    }
    //    _AccountID = rideCell.startingTime.text;
    __block MostRideDetailsViewControllerForPassenger *blockSelf = self;
    [rideCell setReloadHandler:^{
        [blockSelf.ridesList reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    return rideCell ;
}


#pragma mark -
#pragma mark UITableView Delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //    MostRideDetails *ride = self.rides[indexPath.row];
//    //    DriverDetailsViewController *driverDetails = [[DriverDetailsViewController alloc] initWithNibName:(KIS_ARABIC)?@"DriverDetailsViewController_ar":@"DriverDetailsViewController" bundle:nil];
//    //    driverDetails.mostRideDetails = ride ;
//    //    [self.navigationController pushViewController:driverDetails animated:YES];
//    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

-(void)yourButtonClicked:(UIButton*)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
    MostRideDetailsForMap *selectedCell = [self.ridesList cellForRowAtIndexPath:indexPath];
    _AccountID = selectedCell.startingTime.text;
    NSString *Country = selectedCell.country.text;
    NSLog(@"Account ID :%@",_AccountID);
    NSLog(@"O apear or 1 Hide %@ ",Country);
    [self sendSMSFromPhone];
}





-(MostRideDetailsForMap *)parentCellForView:(id)theView
{
    id viewSuperView = [theView superview];
    while (viewSuperView != nil) {
        if ([viewSuperView isKindOfClass:[UITableViewCell class]]) {
            return (MostRideDetailsForMap *)viewSuperView;
        }
        else {
            viewSuperView = [viewSuperView superview];
        }
    }
    return nil;
}

#pragma mark - Message Delegate
- (void)callPhone:(NSString *)phone
{
    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
    if (user)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"tel:%@",phone]]];
    }
    else
    {
        LoginViewController *loginView =  [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navg = [[UINavigationController alloc] initWithRootViewController:loginView];
        loginView.isLogged = YES ;
        [self presentViewController:navg animated:YES completion:nil];
    }
}

- (void)sendSMSFromPhone
{
    NSLog(@"don't Forget to make the getString Arabic ");
    /*
     UIActionSheet *actioSheet = [[UIActionSheet alloc] initWithTitle:@"Select a Route" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Route 1" otherButtonTitles:@"Route 2", nil];
     actioSheet.actionSheetStyle = UIActionSheetStyleDefault;
     [actioSheet showInView:self.view];*/
    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
    if (user == nil)
    {
        
        
        if ( IDIOM == IPAD ) {
            /* do something specifically for iPad. */
           
            if (  [_LanguageIs isEqual: @"Arabic"]) {
                LoginViewController *loginView =  [[LoginViewController alloc] initWithNibName:@"LoginViewController_ar_Ipad" bundle:nil];
                UINavigationController *navg = [[UINavigationController alloc] initWithRootViewController:loginView];
                loginView.isLogged = YES ;
                [self presentViewController:navg animated:YES completion:nil];
            }else {
                LoginViewController *loginView =  [[LoginViewController alloc] initWithNibName:@"LoginViewController_Ipad" bundle:nil];
                UINavigationController *navg = [[UINavigationController alloc] initWithRootViewController:loginView];
                loginView.isLogged = YES ;
                [self presentViewController:navg animated:YES completion:nil];
            }
            
        } else {
            /* do something specifically for iPhone or iPod touch. */
       
            if (  [_LanguageIs isEqual: @"Arabic"]) {
                LoginViewController *loginView =  [[LoginViewController alloc] initWithNibName:@"LoginViewController_ar" bundle:nil];
                UINavigationController *navg = [[UINavigationController alloc] initWithRootViewController:loginView];
                loginView.isLogged = YES ;
                [self presentViewController:navg animated:YES completion:nil];
            }else {
                LoginViewController *loginView =  [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                UINavigationController *navg = [[UINavigationController alloc] initWithRootViewController:loginView];
                loginView.isLogged = YES ;
                [self presentViewController:navg animated:YES completion:nil];
            }
            
        }
        
        
      
        
    }else {
        [self Comments];
        
    }}

-(void) Comments {
    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
    if (user != nil)
    {
        AddRemarksViewControllerForMap *addRemark = [[AddRemarksViewControllerForMap alloc] initWithNibName:@"AddRemarksViewControllerForMap" bundle:nil];
        addRemark.driverDetails = self.driverDetails ;
        addRemark.delegate = self;
        addRemark.RouteID = _RouteIDString;
        addRemark.accountID = _AccountID;
        [self presentPopupViewController:addRemark animationType:MJPopupViewAnimationSlideBottomBottom];
        
    }
    else
    {
        
        
        if ( IDIOM == IPAD ) {
            /* do something specifically for iPad. */
            
            if (  [_LanguageIs isEqual: @"Arabic"]) {
                LoginViewController *loginView =  [[LoginViewController alloc] initWithNibName:@"LoginViewController_ar_Ipad" bundle:nil];
                UINavigationController *navg = [[UINavigationController alloc] initWithRootViewController:loginView];
                loginView.isLogged = YES ;
                [self presentViewController:navg animated:YES completion:nil];
            }else {
                LoginViewController *loginView =  [[LoginViewController alloc] initWithNibName:@"LoginViewController_Ipad" bundle:nil];
                UINavigationController *navg = [[UINavigationController alloc] initWithRootViewController:loginView];
                loginView.isLogged = YES ;
                [self presentViewController:navg animated:YES completion:nil];
            }
            
        } else {
            /* do something specifically for iPhone or iPod touch. */
            
            if (  [_LanguageIs isEqual: @"Arabic"]) {
                LoginViewController *loginView =  [[LoginViewController alloc] initWithNibName:@"LoginViewController_ar" bundle:nil];
                UINavigationController *navg = [[UINavigationController alloc] initWithRootViewController:loginView];
                loginView.isLogged = YES ;
                [self presentViewController:navg animated:YES completion:nil];
            }else {
                LoginViewController *loginView =  [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                UINavigationController *navg = [[UINavigationController alloc] initWithRootViewController:loginView];
                loginView.isLogged = YES ;
                [self presentViewController:navg animated:YES completion:nil];
            }
            
        }

        
    }
}

- (void) dismissButtonClicked:(AddRemarksViewControllerForMap *)addRemarksViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}


- (void)DidInvitedToTheRide
{
    //    joinRideBtn.alpha = 0;
    //GonHint
    
    //    for (UIViewController *controller in self.navigationController.viewControllers)
    //    {
    //        if ([controller isKindOfClass:[MostRidesViewController class]])
    //        {
    //            [self.navigationController popToViewController:controller animated:YES];
    //    if (self.alreadyJoined == NO) {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:GET_STRING(@"Request had been sent Successfully , Wait for driver Approval.") preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:GET_STRING(@"Ok") style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    //    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:true];
        
    });
    //            break;
    //        }
    //    }
    
}

- (void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch(result)
    {
        case MessageComposeResultCancelled: break; //handle cancelled event
        case MessageComposeResultFailed: break; //handle failed event
        case MessageComposeResultSent: break; //handle sent event
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
