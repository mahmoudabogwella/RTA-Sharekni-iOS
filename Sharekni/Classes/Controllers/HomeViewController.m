//
//  HomeViewController.m
//  sharekni
//
//  Created by ITWORX on 10/28/15.
//
//

#import "HomeViewController.h"
#import "MobAccountManager.h"
#import "User.h"
#import "CreateRideViewController.h"
#import <UIColor+Additions.h>
#import "Constants.h"
#import "SearchViewController.h"
#import "VehiclesViewController.h"
#import "SavedSearchViewController.h"
#import "CreatedRidesViewController.h"
#import "Constants.h"
#import <KVNProgress/KVNProgress.h>
#import "MasterDataManager.h"
#import "NSObject+Blocks.h"
#import "NotificationsViewController.h"
#import "RidesJoinedViewController.h"
#import "PermitsViewController.h"
#import "HistoryViewController.h"

@interface HomeViewController ()

#pragma Outlets
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *ridesCreatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *ridesJoinedLabel;
@property (weak, nonatomic) IBOutlet UILabel *vehiclesLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nationalityLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingIcon;
@property (weak, nonatomic) IBOutlet UILabel *notificationCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;


@property (weak, nonatomic) IBOutlet UIImageView *topLeftIcon;
@property (weak, nonatomic) IBOutlet UILabel *topLeftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bottomLeftIcon;
@property (weak, nonatomic) IBOutlet UILabel *bottomLeftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *topRightIcon;
@property (weak, nonatomic) IBOutlet UILabel *topRightLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bottomRightIcon;
@property (weak, nonatomic) IBOutlet UILabel *bottomRightLabel;

@property (weak, nonatomic) IBOutlet UIView *topLeftView;
@property (weak, nonatomic) IBOutlet UIView *topRightView;
@property (weak, nonatomic) IBOutlet UIView *bottomRightView;
@property (weak, nonatomic) IBOutlet UIView *bottomLeftView;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *driverViews;
@property (weak, nonatomic) IBOutlet UIView *ridesCreatedView;
@property (weak, nonatomic) IBOutlet UIView *ridesJoinedView;

@property (weak, nonatomic) IBOutlet UIView *vehiclesView;

//Notifications
@property (nonatomic ,strong) NSMutableArray *notifications ;

@property (nonatomic,strong) User *sharedUser;
@end

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;

    [self configureData];
    [self configureUI];
    [self configureActionsUI];
    [self getNotifications];
}

#pragma Data
- (void) configureData{
    self.sharedUser = [[MobAccountManager sharedMobAccountManager] applicationUser];
    if(!self.sharedUser){
        //handle open home without user
    }
    
}
#pragma UI

- (void) configureActionsUI{
    self.topLeftView.backgroundColor = Red_UIColor;
    self.topRightView.backgroundColor = Red_UIColor;
    self.bottomLeftView.backgroundColor = Red_UIColor;
    self.bottomRightView.backgroundColor = Red_UIColor;
    
    if (self.sharedUser.AccountTypeId.integerValue == 1) {      //Driver
        self.topLeftIcon.image = [UIImage imageNamed:@"search-icon"];
        self.topLeftLabel.text = NSLocalizedString(@"Search", nil);
        UITapGestureRecognizer *topLeftGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAction)];
        [self.topLeftView addGestureRecognizer:topLeftGesture];
        
        self.topRightIcon.image = [UIImage imageNamed:@"create-ride"];
        self.topRightLabel.text = NSLocalizedString(@"Create Ride", nil);
        UITapGestureRecognizer *topRightGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createRideAction)];
        [self.topRightView addGestureRecognizer:topRightGesture];
        
        self.bottomLeftIcon.image = [UIImage imageNamed:@"history"];
        self.bottomLeftLabel.text = NSLocalizedString(@"History", nil);
        UITapGestureRecognizer *bottomLeftGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(historyAction)];
        [self.bottomLeftView addGestureRecognizer:bottomLeftGesture];
        
        self.bottomRightIcon.image = [UIImage imageNamed:@"permit"];
        self.bottomRightLabel.text = NSLocalizedString(@"Permit", nil);
        UITapGestureRecognizer *bottomRightGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(permitAction)];
        [self.bottomRightView addGestureRecognizer:bottomRightGesture];
        
        UITapGestureRecognizer *vechilesGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVeichles:)];
        [self.vehiclesView addGestureRecognizer:vechilesGesture];
        
        UITapGestureRecognizer *createdRidesGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCreatedRides)];
        [self.ridesCreatedView addGestureRecognizer:createdRidesGesture];
        
        UITapGestureRecognizer *joinedRidesGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showJoinedRides)];
        [self.ridesJoinedView addGestureRecognizer:joinedRidesGesture];
    
    }else{
        //passenger
        self.ridesCreatedView.alpha = 0;
        self.vehiclesView.alpha = 0;
        self.ridesJoinedView.alpha = 0;
        self.topLeftIcon.image = [UIImage imageNamed:@""];
        self.topLeftLabel.text = NSLocalizedString(@"Search", nil);
        UITapGestureRecognizer *topLeftGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAction)];
        [self.topLeftView addGestureRecognizer:topLeftGesture];
        
        self.topRightIcon.image = [UIImage imageNamed:@"create-ride"];
        self.topRightLabel.text = NSLocalizedString(@"Create Ride", nil);
        UITapGestureRecognizer *topRightGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createRideAction)];
        [self.topRightView addGestureRecognizer:topRightGesture];
        
        self.bottomLeftIcon.image = [UIImage imageNamed:@"history"];
        self.bottomLeftLabel.text = NSLocalizedString(@"History", nil);
        UITapGestureRecognizer *bottomLeftGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(historyAction)];
        [self.bottomLeftView addGestureRecognizer:bottomLeftGesture];
        
        self.bottomRightIcon.image = [UIImage imageNamed:@"permit"];
        self.bottomRightLabel.text = NSLocalizedString(@"Permit", nil);
        UITapGestureRecognizer *bottomRightGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(permitAction)];
        [self.bottomRightView addGestureRecognizer:bottomRightGesture];
    }
    
    
    
    
}

- (void) configureUI{
    self.navigationItem.title = NSLocalizedString(@"Home Page", nil);
    self.notificationCountLabel.text = [NSString stringWithFormat:@"%@",self.sharedUser.DriverMyAlertsCount];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",self.sharedUser.FirstName,self.sharedUser.LastName];
    self.nationalityLabel.text = self.sharedUser.NationalityEnName;

    NSString *ridesCreatedText = [NSString stringWithFormat:@"%@ (%@)",NSLocalizedString(@"Rides Created", nil),self.sharedUser.DriverMyRidesCount];
    NSString *ridesJoinedText = [NSString stringWithFormat:@"%@ (%@)",NSLocalizedString(@"Rides Joined", nil),self.sharedUser.PassengerJoinedRidesCount];
    NSString *vehiclesCountText = [NSString stringWithFormat:@"%@ (%@)",NSLocalizedString(@"Vehicles", nil),@"0"];
    
    
    self.profileImageView.image = self.sharedUser.userImage ? self.sharedUser.userImage : [UIImage imageNamed:@"thumbnail"];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileImageView.layer.borderWidth = 0.5f;
    self.profileImageView.clipsToBounds = YES;
    
    
    self.ridesCreatedLabel.text = ridesCreatedText;
    self.ridesJoinedLabel.text = ridesJoinedText;
    self.vehiclesLabel.text = vehiclesCountText;
}

- (void) configureNavigationBar{
    
}

#pragma Gestures & Actions
- (void) searchAction{
    SearchViewController *searchView = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    searchView.enableBackButton = YES;
    [self.navigationController pushViewController:searchView animated:YES];
}

- (void) createRideAction{
    CreateRideViewController *createRideViewController = [[CreateRideViewController alloc] initWithNibName:@"CreateRideViewController" bundle:nil];
    [self.navigationController pushViewController:createRideViewController animated:YES];
}

- (void) historyAction{
    HistoryViewController *historyView = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
    [self.navigationController pushViewController:historyView animated:YES];
}

- (void) permitAction{
    PermitsViewController *permitsView = [[PermitsViewController alloc] initWithNibName:@"PermitsViewController" bundle:nil];
    [self.navigationController pushViewController:permitsView animated:YES];
}

- (IBAction)editAction:(id)sender {
    
}


- (IBAction)openNotifications:(id)sender
{
    NotificationsViewController *notificationsView = [[NotificationsViewController alloc] initWithNibName:@"NotificationsViewController" bundle:nil];
    notificationsView.notifications = self.notifications ;
    [self.navigationController pushViewController:notificationsView animated:YES];
}

- (void)getNotifications
{
    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
    
    __block HomeViewController *blockSelf = self;
    [KVNProgress showWithStatus:NSLocalizedString(@"loading", nil)];
    
    [[MasterDataManager sharedMasterDataManager] getRequestNotifications:[NSString stringWithFormat:@"%@",user.ID] isDriver:YES WithSuccess:^(NSMutableArray *array) {
        
        blockSelf.notifications = array;
        
        self.notificationCountLabel.text = [NSString stringWithFormat:@"%d",(unsigned int)self.notifications.count];
       
        [self getAcceptedNotifications];
        
        [KVNProgress dismiss];
        
    } Failure:^(NSString *error) {
        NSLog(@"Error in Notifications");
        [KVNProgress dismiss];
        [KVNProgress showErrorWithStatus:@"Error"];
        [blockSelf performBlock:^{
            [KVNProgress dismiss];
        } afterDelay:3];
    }];
}

- (void)getAcceptedNotifications
{
    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
    
    __block HomeViewController *blockSelf = self;
    [KVNProgress showWithStatus:NSLocalizedString(@"loading", nil)];
    
    [[MasterDataManager sharedMasterDataManager] getRequestNotifications:[NSString stringWithFormat:@"%@",user.ID] isDriver:NO WithSuccess:^(NSMutableArray *array) {
        
        [self.notifications addObjectsFromArray:array];
     
        self.notificationCountLabel.text = [NSString stringWithFormat:@"%d",(unsigned int)self.notifications.count];
        
        [KVNProgress dismiss];
        
    } Failure:^(NSString *error) {
        NSLog(@"Error in Notifications");
        [KVNProgress dismiss];
        [KVNProgress showErrorWithStatus:@"Error"];
        [blockSelf performBlock:^{
            [KVNProgress dismiss];
        } afterDelay:3];
    }];
}

- (void)showVeichles:(id)sender
{
//    SavedSearchViewController *savedView = [[SavedSearchViewController alloc] initWithNibName:@"SavedSearchViewController" bundle:nil];
//    [self.navigationController pushViewController:savedView animated:YES];
    
    VehiclesViewController *registerVehicle = [[VehiclesViewController alloc] initWithNibName:@"VehiclesViewController" bundle:nil];
    [self.navigationController pushViewController:registerVehicle animated:YES];
}

- (void) showCreatedRides{
    CreatedRidesViewController *createdRideViewController = [[CreatedRidesViewController alloc] initWithNibName:@"CreatedRidesViewController" bundle:nil];
    [self.navigationController pushViewController:createdRideViewController animated:YES];
}
- (void) showJoinedRides{
    RidesJoinedViewController *joinedRidesViewController =  [[RidesJoinedViewController alloc] initWithNibName:@"RidesJoinedViewController" bundle:nil];
    [self.navigationController pushViewController:joinedRidesViewController animated:YES];
}

@end
