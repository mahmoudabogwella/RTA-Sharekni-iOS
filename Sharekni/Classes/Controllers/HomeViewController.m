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
@interface HomeViewController ()
#pragma Outlets
@property (weak, nonatomic) IBOutlet UIImageView *permitBG;
@property (weak, nonatomic) IBOutlet UIImageView *historyBG;
@property (weak, nonatomic) IBOutlet UILabel *permitLabel;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
@property (weak, nonatomic) IBOutlet UILabel *createRideLabel;
@property (weak, nonatomic) IBOutlet UILabel *findRides;
@property (weak, nonatomic) IBOutlet UILabel *ridesCreatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *ridesJoinedLabel;
@property (weak, nonatomic) IBOutlet UILabel *vehiclesLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nationalityLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingIcon;
@property (weak, nonatomic) IBOutlet UILabel *notificationCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *createRideBackground;
@property (weak, nonatomic) IBOutlet UIImageView *findRideBackground;
@property (weak, nonatomic) IBOutlet UIView *findRideView;
@property (weak, nonatomic) IBOutlet UIView *createRideView;
@property (weak, nonatomic) IBOutlet UIView *permitView;
@property (weak, nonatomic) IBOutlet UIView *historyView;


@property (nonatomic,strong) User *sharedUser;
@end

@implementation HomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureGestures];
    [self configureData];
    [self configureUI];
}


#pragma Data
- (void) configureData{
    self.sharedUser = [[MobAccountManager sharedMobAccountManager] applicationUser];
    if(!self.sharedUser){
        //handle open home without user
    }
    
}
#pragma UI
- (void) configureUI{
    self.notificationCountLabel.text = [NSString stringWithFormat:@"%@",self.sharedUser.DriverMyAlertsCount];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",self.sharedUser.FirstName,self.sharedUser.LastName];
    self.nationalityLabel.text = self.sharedUser.NationalityEnName;

    NSString *ridesCreatedText = [NSString stringWithFormat:@"%@ (%@)",NSLocalizedString(@"Rides Created", nil),self.sharedUser.DriverMyRidesCount];
    NSString *ridesJoinedText = [NSString stringWithFormat:@"%@ (%@)",NSLocalizedString(@"Rides Joined", nil),self.sharedUser.PassengerJoinedRidesCount];
    NSString *vehiclesCountText = [NSString stringWithFormat:@"%@ (%@)",NSLocalizedString(@"Vehicles", nil),@"0"];
    self.ridesCreatedLabel.text = ridesCreatedText;
    self.ridesJoinedLabel.text = ridesJoinedText;
    self.vehiclesLabel.text = vehiclesCountText;
}

- (void) configureNavigationBar{
    
}

#pragma Gestures & Actions

- (void) configureGestures{
    
    UITapGestureRecognizer *createRideTapGesture =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createRideTapped)];
    [self.findRideView addGestureRecognizer:createRideTapGesture];
    
    UITapGestureRecognizer *findRideTapGesture =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(findRideTapped)];
    [self.findRideView addGestureRecognizer:findRideTapGesture];
    
    UITapGestureRecognizer *historyTapGesture =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(historyTapped)];
    [self.findRideView addGestureRecognizer:historyTapGesture];
    
    UITapGestureRecognizer *permitTapGesture =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(permitTapped)];
    [self.findRideView addGestureRecognizer:permitTapGesture];
    
    UITapGestureRecognizer *ridesCreatedTapGesture =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ridesCreatedTapped)];
    [self.findRideView addGestureRecognizer:ridesCreatedTapGesture];
    
    UITapGestureRecognizer *ridesJoinedTapGesture =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ridesJoinedTapped)];
    [self.findRideView addGestureRecognizer:ridesJoinedTapGesture];
    
    UITapGestureRecognizer *vehiclesTapGesture =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(vehiclesTapped)];
    [self.findRideView addGestureRecognizer:vehiclesTapGesture];
}

- (void) findRideTapped{

}

- (void) createRideTapped{
    CreateRideViewController *createRideViewController = [[CreateRideViewController alloc] initWithNibName:@"CreateRideViewController" bundle:nil];
    [self.navigationController pushViewController:createRideViewController animated:YES];
}

- (void) historyTapped{
    
}

- (void) permitTapped{
    
}

- (void) ridesCreatedTapped{
    
}

- (void) ridesJoinedTapped{
    
}

- (void) vehiclesTapped{
    
}

- (IBAction)editAction:(id)sender {
    
}

@end
