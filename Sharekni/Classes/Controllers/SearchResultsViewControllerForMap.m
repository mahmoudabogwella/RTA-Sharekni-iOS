//
//  SearchResultsViewControllerForMap.m
//  sharekni
//
//  Created by killvak on 2/20/16.
//
//


#import "SearchResultsViewControllerForMap.h"
#import "SearchResultCell.h"
#import "DriverSearchResult.h"
#import "MostRideDetailsForMap.h"
#import "DriverDetailsViewController.h"
#import "MessageUI/MessageUI.h"
#import "Constants.h"
#import "User.h"
#import "LoginViewController.h"
#import "MobAccountManager.h"
#import <KVNProgress/KVNProgress.h>
#import "AddRemarksViewControllerForMap.h"

#import "LoginViewController.h"
#import "UIViewController+MJPopupViewController.h"

#import "HappyMeter.h"
#import "UIViewController+MJPopupViewController.h"

//#import "AddReviewViewController.h"


@interface SearchResultsViewControllerForMap () <SendMSGDelegate/*,MJDetailPopupDelegate*/,MJAddRemarkPopupDelegate,MFMessageComposeViewControllerDelegate ,UIActionSheetDelegate ,UIAlertViewDelegate,MJAddRemarkPopupDelegate>


@property (weak, nonatomic) IBOutlet UILabel *FromLabel;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@end

@implementation SearchResultsViewControllerForMap

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.FromLabel.text = GET_STRING(@"From");
    self.toTitleLabel.text = GET_STRING(@"To");
    
    
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

    [self configureUI];
    
   
    
  }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (BOOL)shouldAutorotate
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait)
    {
        // your code for portrait mode
        return NO ;
    }else{
        return YES ;
    }
}

- (void) configureUI
{
    self.title = GET_STRING(@"Search Results");
    self.fromLabel.text = [NSString stringWithFormat:@"%@ : %@",self.fromEmirate , self.fromRegion];
    self.toLabel.text = (self.toEmirate&&self.toRegion) ? [NSString stringWithFormat:@"%@ : %@",self.toEmirate , self.toRegion] : @"Not specified";
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView registerClass:[MostRideDetailsForMap class] forCellReuseIdentifier:MOST_RIDE_DETAILS_CELLID];
    [self.tableView registerNib:[UINib nibWithNibName:MOST_RIDE_DETAILS_CELLID bundle:nil] forCellReuseIdentifier:SearchResultCell_ID];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    
    if (!self.toEmirate) {
        self.toLabel.alpha = 0;
        self.toTitleLabel.alpha = 0;
        int difference = self.tableView.frame.origin.y - self.toTitleLabel.frame.origin.y - 10;
        CGRect frame = self.tableView.frame;
        frame.origin.y = self.toTitleLabel.frame.origin.y + 10;
        frame.size.height = frame.size.height +difference;
        self.tableView.frame = frame;
    }
}

#pragma mark - Methods
- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    return self.results.count;
}

- (MostRideDetailsForMap *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MostRideDetailsForMap *cell = (MostRideDetailsForMap*)[tableView dequeueReusableCellWithIdentifier:MOST_RIDE_DETAILS_CELLID];
    if(IDIOM == IPAD) {
        
        if (cell == nil) {
            cell = (MostRideDetailsForMap *)[[[NSBundle mainBundle] loadNibNamed:@"MostRideDetailsForMap_Ipad" owner:nil options:nil] objectAtIndex:0];
            cell.contentView.backgroundColor = [UIColor clearColor];
        }
    }else {
    if (cell == nil) {
        cell = (MostRideDetailsForMap *)[[[NSBundle mainBundle] loadNibNamed:@"MostRideDetailsForMap" owner:nil options:nil] objectAtIndex:0];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    }
    cell.delegate = self ;
    DriverSearchResult *driver = [self.results objectAtIndex:indexPath.row];
    [cell setDriver:driver];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __block SearchResultsViewControllerForMap  *blockSelf = self;
    [cell setReloadHandler:^{
        [blockSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 147;
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

- (void)sendSMSFromPhone:(NSString *)phone
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
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select a Route:" delegate:self cancelButtonTitle:GET_STRING(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:
                            @"Route 1",
                            @"Route 2",
                            nil];
    
//    SEL selector = NSSelectorFromString(@"_alertController");
//    if ([popup respondsToSelector:selector])
//    {
//        UIAlertController *alertController = [popup valueForKey:@"_alertController"];
//        if ([alertController isKindOfClass:[UIAlertController class]])
//        {
//            alertController.view.tintColor = [UIColor redColor];
//        }
//    }
    popup.tag = 1;
    [popup showInView:self.view];
    }}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *First = @"120326" ;
    NSString *sec = @"190180" ;
    NSString *thi = @"160111" ;
    NSString *tshi = @"There" ;
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self Comments];
                    
//                    [KVNProgress showWithStatus:GET_STRING(@"Loading...")];
//                    
//                    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
//                    
           
//                    [[MobAccountManager sharedMobAccountManager] DriverSendInvitation:[NSString stringWithFormat:@"%@",user.ID] RouteID:self.driverDetails.RouteId DriverID:self.driverDetails.AccountId Remark:viewText.text WithSuccess:^(NSString *user) {
//                        
//                        [KVNProgress dismiss];
//                        
////                        if (self.delegate && [self.delegate respondsToSelector:@selector(dismissButtonClicked:)]) {
////                            [self.delegate dismissButtonClicked:self];
////                        }
////                        if (self.delegate && [self.delegate respondsToSelector:@selector(didJoinToRideSuccesfully)]) {
////                            [self.delegate didJoinToRideSuccesfully];
////                        }
//                        
//                    } Failure:^(NSString *error) {
//                        [KVNProgress dismiss];
//                    }];
                    
//                    [[MobAccountManager sharedMobAccountManager] DriverSendInvitation:First RouteID:sec DriverID:thi Remark:tshi WithSuccess:^(NSString *user) {
//                        NSLog(@" did enter succes in driversend invition");
//                    } Failure:^(NSString *error) {
//                        NSLog(@"error with the driver send invi.®tion");
//                        NSLog(error);
//                        
//                    }];
//                    [[MobAccountManager sharedMobAccountManager]joinRidePassenger:First RouteID:sec DriverID:thi Remark:tshi WithSuccess:^(NSString *user) {
//                        NSLog(@"succes");
//                    } Failure:^(NSString *error) {
//                        NSLog(@"error");
//                        NSLog(error);
//    
//                    }];
//                    [[MobAccountManager sharedMobAccountManager] DriverSendInvitation: First RouteID:sec DriverID:thi Remark:tshi WithSuccess:^(NSString *user){
//                        
//                        //        120326   190180   160111
////                        [KVNProgress dismiss];
//                        
//                        //        if (self.delegate && [self.delegate respondsToSelector:@selector(dismissButtonClicked:)]) {
//                        //            [self.delegate dismissButtonClicked:self];
//                        //        }
////                        if (self.delegate && [self.delegate respondsToSelector:@selector(didInviteToRideSuccesfully)]) {
////                            [self.delegate didJoinToRideSuccesfully];
////                        }
//                        NSLog(@"Did Join");
//                    } Failure:^(NSString *error) {
////                        [KVNProgress dismiss];
//                        NSLog(@"Error didn't join");
//                    }];
                    break;
                case 1:
                    [self Comments];
                    break;
                case 2:
                    break;
                default:
                    NSLog(@"Defauly");
                    break;
            }
            break;
        }
        default:
            break;
    }
}


- (void) dismissButtonClicked:(AddRemarksViewControllerForMap *)addRemarksViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}






-(void) Comments {
    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
    if (user != nil)
    {
        AddRemarksViewControllerForMap *addRemark = [[AddRemarksViewControllerForMap alloc] initWithNibName:@"AddRemarksViewControllerForMap" bundle:nil];
        addRemark.driverDetails = self.driverDetails ;
        addRemark.delegate = self;
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


- (void)didInviteToRideSuccesfully
{
//    joinRideBtn.alpha = 0;
    //GonHint
    
    //    for (UIViewController *controller in self.navigationController.viewControllers)
    //    {
    //        if ([controller isKindOfClass:[MostRidesViewController class]])
    //        {
    //            [self.navigationController popToViewController:controller animated:YES];
 
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Request had been sent Successfully , Wait for passenger Approval." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:GET_STRING(@"Ok") style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    
    
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        //delete it
    }
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    DriverDetailsViewController *driverDetails = [[DriverDetailsViewController alloc] initWithNibName:(KIS_ARABIC)?@"DriverDetailsViewController_ar":@"DriverDetailsViewController" bundle:nil];
//    DriverSearchResult *driver = [self.results objectAtIndex:indexPath.row];
//    driverDetails.driverSearchResult = driver;
//    [self.navigationController pushViewController:driverDetails animated:YES];
}




@end
