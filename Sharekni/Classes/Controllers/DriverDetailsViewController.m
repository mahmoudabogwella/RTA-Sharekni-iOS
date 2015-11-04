//
//  DriverDetailsViewController.m
//  sharekni
//
//  Created by Ahmed Askar on 11/3/15.
//
//

#import "DriverDetailsViewController.h"
#import "MessageUI/MessageUI.h"
#import "DriverDetails.h"
#import "DriverRideCell.h"
#import "Constants.h"
#import <KVNProgress/KVNProgress.h>
#import "NSObject+Blocks.h"
#import <UIColor+Additions.h>
#import "MasterDataManager.h"
#import "RideDetailsViewController.h"

@interface DriverDetailsViewController () <MFMessageComposeViewControllerDelegate>

@property (nonatomic ,weak) IBOutlet UIImageView *driverImage ;
@property (nonatomic ,weak) IBOutlet UILabel *driverName ;
@property (nonatomic ,weak) IBOutlet UILabel *country ;
@property (nonatomic ,weak) IBOutlet UILabel *rate ;
@property (nonatomic ,weak) IBOutlet UITableView *ridesList ;
@property (nonatomic ,strong) NSMutableArray *driverRides ;

@end

@implementation DriverDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = NSLocalizedString(@"driverDetails", nil);
    
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    
    self.driverImage.layer.cornerRadius = self.driverImage.frame.size.width / 2.0f ;
    self.driverImage.clipsToBounds = YES ;
    
    self.driverName.text = _mostRideDetails.DriverName ;
    self.country.text = _mostRideDetails.NationalityArName ;
    self.driverImage.image = [UIImage imageNamed:@"BestDriverImage"];
    self.rate.text = [NSString stringWithFormat:@"%ld",_mostRideDetails.Rating];
    
    [self getDriverRides];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getDriverRides
{
    __block DriverDetailsViewController *blockSelf = self;
    [KVNProgress showWithStatus:NSLocalizedString(@"loading", nil)];
    [[MasterDataManager sharedMasterDataManager] getDriverRideDetails:_mostRideDetails.AccountId WithSuccess:^(NSMutableArray *array) {
        
        blockSelf.driverRides = array;
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


#pragma mark - Event Handler
- (IBAction)sendMail:(id)sender
{
    [self sendSMSFromPhone:_mostRideDetails.DriverMobile];
}

- (IBAction)call:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"tel:%@",_mostRideDetails.DriverMobile]]];
}


#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.driverRides.count;
}

- (DriverRideCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier  = @"DriverRideCell";
    
    DriverRideCell *rideCell = (DriverRideCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (rideCell == nil)
    {
        rideCell = (DriverRideCell *)[[[NSBundle mainBundle] loadNibNamed:@"DriverRideCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    DriverDetails *ride = self.driverRides[indexPath.row];
    
    return rideCell ;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RideDetailsViewController *rideDetails = [[RideDetailsViewController alloc] initWithNibName:@"RideDetailsViewController" bundle:nil];
    [self.navigationController pushViewController:rideDetails animated:YES];
}

#pragma mark - Message Delegate
- (void)sendSMSFromPhone:(NSString *)phone
{
    if(![MFMessageComposeViewController canSendText])
    {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
