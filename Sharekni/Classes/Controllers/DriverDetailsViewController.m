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
#import "MobAccountManager.h"

@interface DriverDetailsViewController () <MFMessageComposeViewControllerDelegate>

@property (nonatomic ,weak) IBOutlet UIImageView *driverImage ;
@property (nonatomic ,weak) IBOutlet UILabel *driverName ;
@property (nonatomic ,weak) IBOutlet UILabel *country ;
@property (nonatomic ,weak) IBOutlet UILabel *rate ;
@property (nonatomic ,weak) IBOutlet UITableView *ridesList ;
@property (nonatomic ,strong) NSMutableArray *driverRides ;
@property (nonatomic ,strong) User *driver ;

@end

@implementation DriverDetailsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)viewDidLoad
{
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
    
    [self.ridesList registerClass:[DriverRideCell class] forCellReuseIdentifier:RIDE_CELLID];
    [self configureData];
//  [self.ridesList registerNib:[UINib nibWithNibName:@"DriverRideCell" bundle:nil] forCellReuseIdentifier:RIDE_CELLID];
}

- (void) configureData{
    
    //configure Image
    NSString *driverID;
    if (self.bestDriver) {
        driverID = self.bestDriver.AccountId;
    }
    else if (self.mostRideDetails){
        driverID = self.mostRideDetails.AccountId;
    }
    else if (self.driverSearchResult){
        driverID = self.driverSearchResult.DriverId;
    }
    else if (self.joinedRide){
        driverID = self.joinedRide.Account.stringValue;
    }
    [self configureDriverData:driverID];
}

- (void) configureUIData{
    self.driverName.text = self.driver.Username ;
    self.country.text = self.driver.NationalityEnName;
    if (self.driver.userImage) {
        self.driverImage.image = self.driver.userImage;
    }
    else{
        self.driverImage.image = [UIImage imageNamed:@"thumbnail.png"];
    }
    self.rate.text = self.driver.AccountRating;
}


- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configureDriverData:(NSString *)driverID
{
    __block DriverDetailsViewController *blockSelf = self;

    NSString *accountID = driverID;
    [KVNProgress showWithStatus:NSLocalizedString(@"loading", nil)];
    [[MobAccountManager sharedMobAccountManager] getUser:driverID WithSuccess:^(User *user) {
        blockSelf.driver = user;
        [blockSelf configureUIData];
        [[MasterDataManager sharedMasterDataManager] getDriverRideDetails:accountID WithSuccess:^(NSMutableArray *array)
         {
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
    } Failure:^(NSString *error) {
        [[MasterDataManager sharedMasterDataManager] getDriverRideDetails:accountID WithSuccess:^(NSMutableArray *array)
         {
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
        
        if (blockSelf.bestDriver) {
            blockSelf.driverName.text = blockSelf.bestDriver.AccountName ;
            blockSelf.country.text = blockSelf.bestDriver.NationalityArName ;
            if (blockSelf.bestDriver.image) {
                blockSelf.driverImage.image = blockSelf.bestDriver.image;
            }else{
                blockSelf.driverImage.image = [UIImage imageNamed:@"thumbnail.png"];
            }
            blockSelf.rate.text = [NSString stringWithFormat:@"%ld",_bestDriver.Rating];
        }else if (blockSelf.mostRideDetails){
            blockSelf.driverName.text = _mostRideDetails.DriverName ;
            blockSelf.country.text = _mostRideDetails.NationalityEnName ;
            blockSelf.driverImage.image = [UIImage imageNamed:@"thumbnail.png"];
            blockSelf.rate.text = _mostRideDetails.Rating;
        }else if (blockSelf.driverSearchResult){
            blockSelf.driverName.text = self.driverSearchResult.AccountName ;
            blockSelf.country.text = self.driverSearchResult.Nationality_en ;
            blockSelf.driverImage.image = [UIImage imageNamed:@"thumbnail.png"];
            blockSelf.rate.text = [NSString stringWithFormat:@"%@",self.driverSearchResult.Rating];
        }else if (blockSelf.joinedRide){
            blockSelf.driverName.text = self.joinedRide.DriverName ;
            blockSelf.country.text = self.joinedRide.DriverNationalityEnName ;
            blockSelf.driverImage.image = [UIImage imageNamed:@"thumbnail.png"];
            blockSelf.rate.text = self.joinedRide.DriverRating;        }
    }];
}


#pragma mark - Event Handler
- (IBAction)sendMail:(id)sender
{
    [self sendSMSFromPhone:_mostRideDetails.DriverMobile];
}

- (IBAction)call:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"tel:%@",(_isBestDriver)?_bestDriver.AccountMobile:_mostRideDetails.DriverMobile]]];
}

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.driverRides.count;
}

- (DriverRideCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DriverRideCell *driverCell = (DriverRideCell *)[tableView dequeueReusableCellWithIdentifier:RIDE_CELLID];
    
    if (driverCell == nil)
    {
        driverCell = [[DriverRideCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RIDE_CELLID];
    }
    
    DriverDetails *driverDetails = self.driverRides[indexPath.row];
    [driverCell setDriverRideDetails:driverDetails];
    
    return driverCell ;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DriverDetails *driver = self.driverRides[indexPath.row];
    RideDetailsViewController *rideDetails = [[RideDetailsViewController alloc] initWithNibName:@"RideDetailsViewController" bundle:nil];
    rideDetails.driverDetails = driver ;
    [self.navigationController pushViewController:rideDetails animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Driver_Ride_CELLHEIGHT;
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

@end
