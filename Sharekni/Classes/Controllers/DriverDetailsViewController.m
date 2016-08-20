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
#import "RZDataBinding.h"   
#import "LoginViewController.h"
#import "User.h"
#import "HappyMeter.h"
#import "UIViewController+MJPopupViewController.h"

@interface DriverDetailsViewController () <MFMessageComposeViewControllerDelegate,MJAddRemarkPopupDelegate>

@property (nonatomic ,weak) IBOutlet UIImageView *driverImage ;
@property (nonatomic ,weak) IBOutlet UILabel *driverName ;
@property (nonatomic ,weak) IBOutlet UILabel *country ;
@property (nonatomic ,weak) IBOutlet UILabel *rate ;
@property (nonatomic ,weak) IBOutlet UITableView *ridesList ;
@property (nonatomic ,strong) NSMutableArray *driverRides ;
@property (nonatomic ,strong) User *driver ;

@end

@implementation DriverDetailsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = GET_STRING(@"driverDetails");
    self.CO2.text = GET_STRING(@"Co2 Saving");
    self.TPoints.text = GET_STRING(@"Points");
    self.TRoutes.text = GET_STRING(@"Routes");
    self.TVehicles.text = GET_STRING(@"Vehicles");
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

- (void) configureData
{
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
    [KVNProgress showWithStatus:GET_STRING(@"Loading...")];

    if (KIS_ARABIC) {
        self.driverName.textAlignment = NSTextAlignmentRight ;
        self.country.textAlignment = NSTextAlignmentRight ;
    }
   
    if (self.bestDriver) {
        
        self.driverName.text = self.bestDriver.AccountName ;
        self.country.text = (KIS_ARABIC)?self.bestDriver.NationalityArName:self.bestDriver.NationalityEnName ;
        if (self.bestDriver.image) {
            self.driverImage.image = self.bestDriver.image;
        }else{
            self.driverImage.image = [UIImage imageNamed:@"thumbnail.png"];
            [self.bestDriver rz_addTarget:self action:@selector(imageChanged) forKeyPathChange:@"image"];
        }
        [self.bestDriver rz_addTarget:self action:@selector(ratingChanged) forKeyPathChange:@"Rating" callImmediately:YES];
        
    } else if (self.mostRideDetails){
        
        self.driverName.text = _mostRideDetails.DriverName ;
        self.country.text = (KIS_ARABIC)?_mostRideDetails.NationalityArName:_mostRideDetails.NationlityEnName;
        if (self.mostRideDetails.driverImage) {
            self.driverImage.image = self.mostRideDetails.driverImage;
        }
        else{
            self.driverImage.image = [UIImage imageNamed:@"thumbnail.png"];
            [self.mostRideDetails rz_addTarget:self action:@selector(imageChanged) forKeyPathChange:@"driverImage"];
        }
        [self.mostRideDetails rz_addTarget:self action:@selector(ratingChanged) forKeyPathChange:@"Rating" callImmediately:YES];
        
    } else if (self.driverSearchResult){
        self.driverName.text = self.driverSearchResult.AccountName ;
        self.country.text = (KIS_ARABIC)?self.driverSearchResult.Nationality_ar:self.driverSearchResult.Nationality_en ;
        if (self.driverSearchResult.driverImage) {
            self.driverImage.image = self.driverSearchResult.driverImage;
        }else{
            self.driverImage.image = [UIImage imageNamed:@"thumbnail.png"];
            [self.driverSearchResult rz_addTarget:self action:@selector(imageChanged) forKeyPathChange:@"driverImage"];
        }
     [self.driverSearchResult rz_addTarget:self action:@selector(ratingChanged) forKeyPathChange:@"Rating" callImmediately:YES];
        
    } else if (self.joinedRide){
        self.driverName.text = self.joinedRide.DriverName ;
        self.country.text = (KIS_ARABIC)?self.joinedRide.DriverNationalityArName:self.joinedRide.DriverNationalityEnName ;
        if (self.joinedRide.driverImage) {
            self.driverImage.image = self.joinedRide.driverImage;
        }else{
            self.driverImage.image = [UIImage imageNamed:@"thumbnail.png"];
            [self.driverSearchResult rz_addTarget:self action:@selector(imageChanged) forKeyPathChange:@"driverImage"];
        }
        [self.joinedRide rz_addTarget:self action:@selector(ratingChanged) forKeyPathChange:@"DriverRating" callImmediately:YES];
    }
    [self configureDriverData:driverID];
}

- (void) ratingChanged{
    if (self.driver) {
        self.rate.text = self.driver.AccountRating;
    }
    else if(self.bestDriver){
        self.rate.text = _bestDriver.Rating;
    }
    else if (self.mostRideDetails){
        self.rate.text = _mostRideDetails.Rating;
    }
    else if (self.driverSearchResult){
        self.rate.text = self.driverSearchResult.Rating;
    }
    else if (self.joinedRide){
        self.rate.text = self.joinedRide.DriverRating;
    }
}

- (void) imageChanged{
    if(self.bestDriver){
        self.driverImage.image = self.bestDriver.image;
    }
    else if (self.mostRideDetails){
        self.driverImage.image = self.mostRideDetails.driverImage;
    }
    else if (self.driverSearchResult){
        self.driverImage.image = self.driverSearchResult.driverImage;
    }
    else if (self.joinedRide){
        self.driverImage.image = self.joinedRide.driverImage;
    }
}

- (void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configureDriverData:(NSString *)driverID
{
    __block DriverDetailsViewController *blockSelf = self;
        [KVNProgress showWithStatus:GET_STRING(@"Loading...")];
        NSString *accountID = driverID;
        [[MasterDataManager sharedMasterDataManager] getDriverRideDetails:accountID WithSuccess:^(NSMutableArray *array)
         {
             blockSelf.driverRides = array;
             [self.ridesList reloadData];
             //GreenPoint
             [[MobAccountManager sharedMobAccountManager] getUser:driverID WithSuccess:^(User *user) {
                 blockSelf.driver = user;
                 blockSelf.country.text = (KIS_ARABIC)?blockSelf.driver.NationalityArName:blockSelf.driver.NationalityEnName ;
                 //GreenPoint
                 NSNumber *test = blockSelf.driver.GreenPoints;
                 NSNumber *test1 = blockSelf.driver.TotalDistance;
                 NSNumber *test2 = blockSelf.driver.DriverMyRidesCount;
                 NSNumber *test3 = blockSelf.driver.VehiclesCount;
                 NSNumber *test4 = blockSelf.driver.CO2Saved;

                 int number = [test4 intValue];
                 NSLog(@"CO2 Saved BEfore : %d",number);
                 int Co2Saved = (number/1000);
                 NSLog(@"CO2 Saved BEfore : %d",Co2Saved);
                                
                 NSString *StringScorePlayer = [test stringValue];
                 NSString *StringScorePlayer1 = [test1 stringValue];
                 NSString *StringScorePlayer2 = [test2 stringValue];
                 NSString *StringScorePlayer3 = [test3 stringValue];
                 NSString *StringScorePlayer4 = [NSString stringWithFormat:@"%d",Co2Saved];

//                 NSString *myString = [NSNumber stringValue];
//                 NSString *myString = [NSNumber stringValue];
//                 NSString *myString = [NSNumber stringValue];
//                 NSString *myString = [NSNumber stringValue];
                 blockSelf.PointsOutLet.text = StringScorePlayer;
                 blockSelf.KmOutLet.text = StringScorePlayer1;
                 blockSelf.RoutesOutLet.text = StringScorePlayer2;
                 blockSelf.VehiclesOutLet.text = StringScorePlayer3;
                 blockSelf.GreenPointKmOutLets.text = StringScorePlayer4;

                 if (([self.KmOutLet.text length] > 5) ){
                     // User cannot type more than 15 characters
                     self.KmOutLet.text = [self.KmOutLet.text substringToIndex:5];
                 } else if (([self.PointsOutLet.text length] > 5) ){
                     // User cannot type more than 15 characters
                     self.PointsOutLet.text = [self.PointsOutLet.text substringToIndex:5];
                 }
//                 else if (([self.GreenPointKmOutLets.text length] > 5) ){
//                     // User cannot type more than 15 characters
//                     self.GreenPointKmOutLets.text = [self.GreenPointKmOutLets.text substringToIndex:5];
//                 } else if (([self.VehiclesOutLet.text length] > 5) ){
//                     // User cannot type more than 15 characters
//                     self.VehiclesOutLet.text = [self.VehiclesOutLet.text substringToIndex:5];
//                 }else if (([self.RoutesOutLet.text length] > 5) ){
//                     // User cannot type more than 15 characters
//                     self.RoutesOutLet.text = [self.RoutesOutLet.text substringToIndex:5];
//                 }
                 
//                 blockSelf.KmOutLet.text = blockSelf.driver.TotalDistance;
//                 blockSelf.RoutesOutLet.text = blockSelf.driver.DriverMyRidesCount;
//                 blockSelf.VehiclesOutLet.text = blockSelf.driver.VehiclesCount;
//                 blockSelf.GreenPointKmOutLets.text = blockSelf.driver.CO2Saved;
                 
                 
                 [blockSelf.driver rz_addTarget:self action:@selector(ratingChanged) forKeyPathChange:@"AccountRating"];
             [KVNProgress dismiss];

             } Failure:^(NSString *error) {
             [KVNProgress dismiss];
             }];
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
    NSString *driverMobile ;
    if(self.mostRideDetails)
    {
        driverMobile = self.mostRideDetails.DriverMobile;
    }
    else if (self.bestDriver)
    {
        driverMobile = self.bestDriver.AccountMobile;
    }
    else if (self.driverSearchResult)
    {
        driverMobile = self.driverSearchResult.AccountMobile;
    }
    else if (self.joinedRide)
    {
        driverMobile = self.joinedRide.DriverMobile;
    }
    
    [self sendSMSFromPhone:driverMobile];
}

- (IBAction)call:(id)sender
{
    NSString *driverMobile ;
    if(self.mostRideDetails){
        driverMobile = self.mostRideDetails.DriverMobile;
    }
    else if (self.bestDriver){
        driverMobile = self.bestDriver.AccountMobile;
    }
    else if (self.driverSearchResult){
        driverMobile = self.driverSearchResult.AccountMobile;
    }
    else if (self.joinedRide){
        driverMobile = self.joinedRide.DriverMobile;
    }
    
    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
    if (user)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"tel:%@",driverMobile]]];
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

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    return self.driverRides.count;
}

- (DriverRideCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DriverDetails *driver = self.driverRides[indexPath.row];
    RideDetailsViewController *rideDetails = [[RideDetailsViewController alloc] initWithNibName:(KIS_ARABIC)?@"RideDetailsViewController_ar":@"RideDetailsViewController" bundle:nil];
    rideDetails.driverDetails = driver ;
    [self.navigationController pushViewController:rideDetails animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Driver_Ride_CELLHEIGHT;
}

#pragma mark - Message Delegate

- (void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
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
