//
//  SavedSearchViewController.m
//  sharekni
//
//  Created by Ahmed Askar on 11/20/15.
//
//

#import "SavedSearchViewController.h"
#import "MessageUI/MessageUI.h"
#import "MostRideDetailsCell.h"
#import "MostRideDetails.h"
#import "DriverDetailsViewController.h"
#import "Constants.h"
#import <KVNProgress/KVNProgress.h>
#import "NSObject+Blocks.h"
#import <UIColor+Additions.h>
#import "MasterDataManager.h"

@interface SavedSearchViewController ()

@property (nonatomic ,weak) IBOutlet UITableView *driverList ;
@property (nonatomic ,strong) NSMutableArray *savedData ;

@end

@implementation SavedSearchViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = NSLocalizedString(@"savedSearch", nil);
    
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
  
    [self getRideDetails];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getRideDetails
{
    __block SavedSearchViewController *blockSelf = self;
    [KVNProgress showWithStatus:NSLocalizedString(@"loading", nil)];
    [[MasterDataManager sharedMasterDataManager] getSavedSearch:@"" withSuccess:^(NSMutableArray *array) {
        
        blockSelf.savedData = array;
        [KVNProgress dismiss];
        [self.driverList reloadData];
        
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
    return self.savedData.count;
}

- (MostRideDetailsCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MostRideDetailsCell *rideCell = (MostRideDetailsCell *)[tableView dequeueReusableCellWithIdentifier:MOST_RIDE_DETAILS_CELLID];
    
    if (rideCell == nil)
    {
        rideCell = [[MostRideDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MOST_RIDE_DETAILS_CELLID];
    }
    
    MostRideDetails *ride = self.savedData[indexPath.row];
    [rideCell setMostRide:ride];
    
    return rideCell ;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MostRideDetails *ride = self.savedData[indexPath.row];
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
