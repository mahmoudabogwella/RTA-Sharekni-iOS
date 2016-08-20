//
//  SearchResultsViewController.m
//  Sharekni
//
//  Created by ITWORX on 10/4/15.
//
//

#import "SearchResultsViewController.h"
#import "SearchResultCell.h"
#import "DriverSearchResult.h"
#import "MostRideDetailsCell.h"
#import "DriverDetailsViewController.h"
#import "MessageUI/MessageUI.h"
#import "Constants.h"
#import "User.h"
#import "LoginViewController.h"
#import "MobAccountManager.h"

#import "HappyMeter.h"
#import "UIViewController+MJPopupViewController.h"

@interface SearchResultsViewController () <SendMSGDelegate,MFMessageComposeViewControllerDelegate,MJAddRemarkPopupDelegate>
@property (weak, nonatomic) IBOutlet UILabel *FromLabelO;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@end

@implementation SearchResultsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureUI];
    
    self.FromLabelO.text = GET_STRING(@"From");
    self.toTitleLabel.text = GET_STRING(@"To");

   
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
    [self.tableView registerClass:[MostRideDetailsCell class] forCellReuseIdentifier:MOST_RIDE_DETAILS_CELLID];
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

- (MostRideDetailsCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   MostRideDetailsCell *cell = (MostRideDetailsCell*)[tableView dequeueReusableCellWithIdentifier:MOST_RIDE_DETAILS_CELLID];
    if (cell == nil) {
        
        if (IDIOM == IPAD) {
            cell = (MostRideDetailsCell *)[[[NSBundle mainBundle] loadNibNamed:@"MostRideDetailsCell" owner:nil options:nil] objectAtIndex:0];
            cell.contentView.backgroundColor = [UIColor clearColor];
        }else {
            cell = (MostRideDetailsCell *)[[[NSBundle mainBundle] loadNibNamed:@"MostRideDetailsCell" owner:nil options:nil] objectAtIndex:0];
            cell.contentView.backgroundColor = [UIColor clearColor];
        }

    }
    cell.delegate = self ;
    DriverSearchResult *driver = [self.results objectAtIndex:indexPath.row];
    [cell setDriver:driver];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __block SearchResultsViewController  *blockSelf = self;
    [cell setReloadHandler:^{
        [blockSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 223;
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
    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
    if (user)
    {
        if(![MFMessageComposeViewController canSendText])
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:GET_STRING(@"Ok") otherButtonTitles:nil];
            [warningAlert show];
            return;
        }
        
        NSArray *recipents = @[phone];
        
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
        messageController.messageComposeDelegate = self;
        [messageController setRecipients:recipents];
        
        // Present message view controller on screen
        [self presentViewController:messageController animated:YES completion:nil];
        
    }
    else
    {
        LoginViewController *loginView =  [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navg = [[UINavigationController alloc] initWithRootViewController:loginView];
        loginView.isLogged = YES ;
        [self presentViewController:navg animated:YES completion:nil];
    }
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

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DriverDetailsViewController *driverDetails = [[DriverDetailsViewController alloc] initWithNibName:(KIS_ARABIC)?@"DriverDetailsViewController_ar":@"DriverDetailsViewController" bundle:nil];
    DriverSearchResult *driver = [self.results objectAtIndex:indexPath.row];
    driverDetails.driverSearchResult = driver;
    [self.navigationController pushViewController:driverDetails animated:YES];
}




@end
