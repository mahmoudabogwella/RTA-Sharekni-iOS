//
//  MostRideDetailsViewController.m
//  sharekni
//
//  Created by Ahmed Askar on 10/31/15.
//
//

#import "MostRideDetailsViewController.h"
#import "MessageUI/MessageUI.h"
#import "MostRideDetailsCell.h"
#import "MostRideDetails.h"
#import "DriverDetailsViewController.h"
#import "Constants.h"
#import <KVNProgress/KVNProgress.h>
#import "NSObject+Blocks.h"
#import <UIColor+Additions.h>
#import "MasterDataManager.h"
#import "DriverDetailsViewController.h"

@interface MostRideDetailsViewController ()<SendMSGDelegate,MFMessageComposeViewControllerDelegate>

@property (nonatomic ,weak) IBOutlet UILabel *FromRegionName ;
@property (nonatomic ,weak) IBOutlet UILabel *ToRegionName ;
@property (nonatomic ,weak) IBOutlet UITableView *ridesList ;
@property (nonatomic ,strong) NSMutableArray *rides ;

@end

@implementation MostRideDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = NSLocalizedString(@"driversrides", nil);
    
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];

    _FromRegionName.text = [NSString stringWithFormat:@"From : %@",_ride.FromRegionNameEn] ;
    _ToRegionName.text = [NSString stringWithFormat:@"From : %@",_ride.ToRegionNameEn] ;;
    
    [self getRideDetails];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getRideDetails
{
    __block MostRideDetailsViewController *blockSelf = self;
    [KVNProgress showWithStatus:NSLocalizedString(@"loading", nil)];
    [[MasterDataManager sharedMasterDataManager] getRideDetails:@"20051" FromEmirateID:_ride.FromEmirateId FromRegionID:_ride.FromRegionId ToEmirateID:_ride.ToEmirateId ToRegionID:_ride.ToRegionId WithSuccess:^(NSMutableArray *array) {
        
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

- (MostRideDetailsCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier  = @"MostRideDetailsCell";
    
    MostRideDetailsCell *rideCell = (MostRideDetailsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (rideCell == nil)
    {
        rideCell = (MostRideDetailsCell *)[[[NSBundle mainBundle] loadNibNamed:@"MostRideDetailsCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    MostRideDetails *ride = self.rides[indexPath.row];
    [rideCell setMostRide:ride];
    
    return rideCell ;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MostRideDetails *ride = self.rides[indexPath.row];
    DriverDetailsViewController *driverDetails = [[DriverDetailsViewController alloc] initWithNibName:@"DriverDetailsViewController" bundle:nil];
    driverDetails.mostRideDetails = ride ;
    [self.navigationController pushViewController:driverDetails animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
