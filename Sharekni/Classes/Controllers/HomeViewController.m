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
#import "VehiclesViewController.h"
#import "HelpManager.h"
#import "VerifyMobileViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "EditProfileViewController.h"
#import "Languages.h"
#import "AppDelegate.h"

#import "HappyMeter.h"
#import "UIViewController+MJPopupViewController.h"

@import MobileAppTracker;

@interface HomeViewController () <VerifyMobilePopupDelegate,MJAddRemarkPopupDelegate ,UIPickerViewDelegate ,UIPickerViewDataSource  >

#pragma Outlets
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *mobileNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *ridesCreatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *ridesJoinedLabel;
@property (weak, nonatomic) IBOutlet UILabel *vehiclesLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nationalityLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingIcon;
@property (weak, nonatomic) IBOutlet UILabel *notificationCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

//LanguageLabels

@property (weak, nonatomic) IBOutlet UITextField *TextViaPicker;

//
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

@property (weak, nonatomic) IBOutlet UIImageView *verifiedImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *verifiedImgTwo;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property (assign , nonatomic) int NotificationURLCount ;
@property (assign , nonatomic) int notificationCount ;
@property (strong , nonatomic) NSString * notificationCountTxt ;
@property (strong , nonatomic) NSNumber * notificationCountForUrl ;


@property (nonatomic,strong) User *sharedUser;
@end

@implementation HomeViewController
NSArray* language ;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [Tune measureSession];
    
    switch ([[Languages sharedLanguageInstance] language]) {
            
            
        case Arabic:
            //GET_STRING(@"Filipino") GET_STRING(@"Chinese") GET_STRING(@"Arabic") GET_STRING(@"English")
            
            hardCodedLanguages = @[ GET_STRING(@"English"),GET_STRING(@"Chinese"),GET_STRING(@"Filipino")];
            selected = @"English";
            break;
        case English:
            //
            
            //        self.HindiButtonSelector.hidden = NO;
            hardCodedLanguages = @[GET_STRING(@"Arabic") ,GET_STRING(@"Chinese"),GET_STRING(@"Filipino")];
            selected = @"Arabic";
            break;
        case Chines:
            //
            
            //        self.HindiButtonSelector.hidden = NO;
            hardCodedLanguages = @[GET_STRING(@"English") ,GET_STRING(@"Arabic"),GET_STRING(@"Filipino")];
            selected = @"English";
            break;
        case Philippine:
            //
            
            //        self.HindiButtonSelector.hidden = NO;
            hardCodedLanguages = @[GET_STRING(@"English") ,GET_STRING(@"Arabic"),GET_STRING(@"Chinese")];
            selected = @"English";
            break;
        default:
            NSLog(@"Error Picking Language");
            break;
    }
    
    //GonLang
    [_verifyBtn setTitle:GET_STRING(@"Verify") forState:UIControlStateNormal];
    self.ridesCreatedLabel.text = GET_STRING(@"Create Ride");
    if ([[Languages sharedLanguageInstance] language] == Philippine) {
        self.verifyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:11];
        
    }else{
        self.verifyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];

    }

    //
    [self configureData];
    //    [self configureUI];
    [self configureActionsUI];
    
    __block HomeViewController *blockSelf = self;
    [[MobAccountManager sharedMobAccountManager] getCalculatedRatingForAccount:self.sharedUser.ID.stringValue WithSuccess:^(NSString *rating) {
        blockSelf.ratingLabel.text = rating;
    } Failure:^(NSString *error) {
        blockSelf.ratingLabel.text = 0;
    }];
    
    [[MobAccountManager sharedMobAccountManager] getUser:self.sharedUser.ID.stringValue WithSuccess:^(User *user) {
        /*
         _sharedUser.PendingInvitationCount + _sharedUser.Passenger_Invitation_Count + _sharedUser.PassengerMyAlertsCount + _sharedUser.DriverMyAlertsCount + _sharedUser.PendingRequestsCount
         */
        self.NotificationURLCount = 0;
        self.notificationCount = 0;
        NSNumber *number1  = _sharedUser.PendingInvitationCount  ;
        NSLog(@"NSNUMBER1 is %@",number1);
        NSNumber *number2  = _sharedUser.Passenger_Invitation_Count ;
        NSLog(@"NSNUMBER2 is %@",number2);
        NSNumber *number3  = _sharedUser.PassengerMyAlertsCount ;
        NSLog(@"NSNUMBER3 is %@",number3);
        NSNumber *number4  = _sharedUser.DriverMyAlertsCount ;
        NSLog(@"NSNUMBER4 is %@",number4);
        NSNumber *number5  = _sharedUser.PendingRequestsCount ;
        NSLog(@"NSNUMBER5 is %@",number5);
        NSInteger value = ([number1 integerValue] + [number2 integerValue] + [number3 integerValue] + [number4 integerValue] + [number5 integerValue]);
        int myValue = (int) value;
        
        NSLog(@"My Value is :  %d",myValue);
        _NotificationURLCount = myValue  ;
        NSLog(@"Howa da 3ebo %d",_NotificationURLCount);
        blockSelf.sharedUser = user;
        [[MobAccountManager sharedMobAccountManager] setApplicationUser:user];
        [blockSelf configureUI];
        [KVNProgress dismiss];
    } Failure:^(NSString *error)
     {
         [KVNProgress dismiss];
     }];
    
    [self getNotifications];
    
   
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    
    [KVNProgress showWithStatus:GET_STRING(@"Loading...")];
    __block HomeViewController *blockSelf = self;
    [[MobAccountManager sharedMobAccountManager] getUser:self.sharedUser.ID.stringValue WithSuccess:^(User *user) {
        /*
         _sharedUser.PendingInvitationCount + _sharedUser.Passenger_Invitation_Count + _sharedUser.PassengerMyAlertsCount + _sharedUser.DriverMyAlertsCount + _sharedUser.PendingRequestsCount
         */
        self.NotificationURLCount = 0;
        self.notificationCount = 0;
        NSNumber *number1  = _sharedUser.PendingInvitationCount  ;
        NSLog(@"NSNUMBER1 is %@",number1);
        NSNumber *number2  = _sharedUser.Passenger_Invitation_Count ;
        NSLog(@"NSNUMBER2 is %@",number2);
        NSNumber *number3  = _sharedUser.PassengerMyAlertsCount ;
        NSLog(@"NSNUMBER3 is %@",number3);
        NSNumber *number4  = _sharedUser.DriverMyAlertsCount ;
        NSLog(@"NSNUMBER4 is %@",number4);
        NSNumber *number5  = _sharedUser.PendingRequestsCount ;
        NSLog(@"NSNUMBER5 is %@",number5);
        NSInteger value = ([number1 integerValue] + [number2 integerValue] + [number3 integerValue] + [number4 integerValue] + [number5 integerValue]);
        int myValue = (int) value;
        
        NSLog(@"My Value is :  %d",myValue);
        _NotificationURLCount = myValue  ;
        NSLog(@"Howa da 3ebo %d",_NotificationURLCount);
        blockSelf.sharedUser = user;
        [[MobAccountManager sharedMobAccountManager] setApplicationUser:user];
        [blockSelf configureUI];
        [KVNProgress dismiss];
    } Failure:^(NSString *error)
     {
         [KVNProgress dismiss];
     }];
    
    [self getNotifications];
}

#pragma Data
- (void) configureData
{
    self.sharedUser = [[MobAccountManager sharedMobAccountManager] applicationUser];
    if(!self.sharedUser){
        //handle open home without user
    }
}
#pragma UI

- (void) configureActionsUI
{
    self.
    self.topLeftView.backgroundColor = Red_UIColor;
    self.topRightView.backgroundColor = Red_UIColor;
    self.bottomLeftView.backgroundColor = Red_UIColor;
    self.bottomRightView.backgroundColor = Red_UIColor;
    
//    if ([self.sharedUser.AccountStatus containsString:@"D"] || [self.sharedUser.AccountStatus containsString:@"B"]) {      //Driver
    
        NSLog(@"that is passenger value :%@",self.sharedUser.IsPassenger);
        NSString *LOL = [NSString stringWithFormat:@"%@",self.sharedUser.IsPassenger];
        NSLog(@"that is LOL Value :%@",LOL);
        if ([LOL containsString:@"0"] || [LOL containsString:@"false"]) {
            
        self.topLeftIcon.image = [UIImage imageNamed:@"search-icon"];
        self.topLeftLabel.text = GET_STRING(@"Search");
        UITapGestureRecognizer *topLeftGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAction)];
        [self.topLeftView addGestureRecognizer:topLeftGesture];
        
        self.topRightIcon.image = [UIImage imageNamed:@"create-ride"];
        self.topRightLabel.text = GET_STRING(@"Create Ride");
        UITapGestureRecognizer *topRightGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createRideAction)];
        [self.topRightView addGestureRecognizer:topRightGesture];
        //happy Meter
//        self.bottomLeftIcon.image = [UIImage imageNamed:@"history"];
        self.bottomLeftLabel.text = GET_STRING(@"Happy Meter");
        UITapGestureRecognizer *bottomLeftGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(historyAction)];
        [self.bottomLeftView addGestureRecognizer:bottomLeftGesture];
        
        self.bottomRightIcon.image = [UIImage imageNamed:@"permit"];
        self.bottomRightLabel.text = GET_STRING(@"Permits");
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
        self.topLeftIcon.image = [UIImage imageNamed:@"search-icon"];
        self.topLeftLabel.text = GET_STRING(@"Search");
        UITapGestureRecognizer *topLeftGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAction)];
        [self.topLeftView addGestureRecognizer:topLeftGesture];
        
        self.topRightIcon.image = [UIImage imageNamed:@"RidesJoined_home"];
        self.topRightLabel.text = GET_STRING(@"Rides Joined");
        UITapGestureRecognizer *topRightGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showJoinedRides)];
        [self.topRightView addGestureRecognizer:topRightGesture];
        //Happy Meter
//        self.bottomLeftIcon.image = [UIImage imageNamed:@"history"];
        self.bottomLeftLabel.text = GET_STRING(@"Happy Meter");
        UITapGestureRecognizer *bottomLeftGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(historyAction)];
        [self.bottomLeftView addGestureRecognizer:bottomLeftGesture];
        
        self.bottomRightIcon.image = [UIImage imageNamed:@"SavedSearch_Home"];
        self.bottomRightLabel.text = GET_STRING(@"Saved Search");
        UITapGestureRecognizer *bottomRightGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(savedSearchAction)];
        [self.bottomRightView addGestureRecognizer:bottomRightGesture];
    }
}

- (void) configureUI
{
    
    // Picker
    
    UIPickerView *cityPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    cityPicker.delegate = self;
    cityPicker.dataSource = self;
    [cityPicker setBackgroundColor:[UIColor whiteColor]];
    [cityPicker setShowsSelectionIndicator:YES];
    _TextViaPicker.inputView = cityPicker;
    // Create done button in UIPickerView
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    mypickerToolbar.barStyle = UIBarStyleDefault;
    [mypickerToolbar sizeToFit];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *Cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(pickerCANCELClicked)];
    Cancel.tintColor =  Red_UIColor;
    [barItems addObject:Cancel];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked)];
    doneBtn.tintColor =  Red_UIColor;
    [barItems addObject:doneBtn];
    
    [mypickerToolbar setItems:barItems animated:YES];
    _TextViaPicker.inputAccessoryView = mypickerToolbar;
    //    _TextViaPicker.inputView = picker ;
    language = [NSArray new];
    
    //

    
    
    self.navigationItem.title = GET_STRING(@"Home Page");
    
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",self.sharedUser.FirstName,self.sharedUser.LastName];
    self.nameLabel.text = [self.nameLabel.text capitalizedString];
    
    self.nationalityLabel.text = (KIS_ARABIC)?self.sharedUser.NationalityArName:self.sharedUser.NationalityEnName;
    
    self.emailLabel.text = self.sharedUser.Username;
    self.mobileNumberLabel.text = [NSString stringWithFormat:@"%@",self.sharedUser.Mobile];
    if ([self.sharedUser.IsPhotoVerified boolValue])
    {
        self.verifiedImgOne.hidden = NO ;
    }
    
    if ([self.sharedUser.IsMobileVerified boolValue])
    {
        self.verifiedImgTwo.hidden = NO ;
        self.verifyBtn.hidden = YES ;
    }else{
        self.verifiedImgTwo.hidden = YES ;
        self.verifyBtn.hidden = NO ;
    }
    
    NSString *ridesCreatedText = [NSString stringWithFormat:@"%@ (%@)",GET_STRING(@"Rides Created"),self.sharedUser.DriverMyRidesCount];
    NSString *ridesJoinedText = [NSString stringWithFormat:@"%@ (%@)",GET_STRING(@"Rides Joined"),self.sharedUser.PassengerJoinedRidesCount];
    NSString *vehiclesCountText = [NSString stringWithFormat:@"%@ (%@)",GET_STRING(@"Vehicles"),self.sharedUser.VehiclesCount.stringValue];
    
    if ([self.sharedUser.IsPhotoVerified isEqual: @"True"] ) {
        //        self.profileImageView.image = self.sharedUser.userImage ? self.sharedUser.userImage : [UIImage imageNamed:@"thumbnail"];
        self.profileImageView.image = self.sharedUser.userImage ? self.sharedUser.userImage : [UIImage imageNamed:@"thumbnail"];
        //        NSLog(self.sharedUser.IsPhotoVerified);
        NSLog(@"Maybe true");
        
    }
    else if ([self.sharedUser.IsPhotoVerified isEqual: @"False"] ) {
        NSLog(@"Maybe false");
        switch ([[Languages sharedLanguageInstance] language]) {
                
                
            case Arabic:
                //
                
                if ([self.sharedUser.GenderAr  isEqual: @"ذكر"]) {
                    
                    self.profileImageView.image = self.sharedUser.userImage ? self.sharedUser.userImage : [UIImage imageNamed:@"imageaftereditar.png"];
                    
                    
                }else {
                    
                    self.profileImageView.image = self.sharedUser.userImage ? self.sharedUser.userImage : [UIImage imageNamed:@"imageaftereditfemalear.png"];
                    
                }
                
                
                break;
            case English:
                //
                
                if ([self.sharedUser.GenderEn  isEqual: @"Male"]) {
                    
                    self.profileImageView.image = self.sharedUser.userImage ? self.sharedUser.userImage : [UIImage imageNamed:@"imageafterediten.png"];
                    
                }else{
                    //                    NSLog(self.sharedUser.GenderAr);
                    
                    self.profileImageView.image = self.sharedUser.userImage ? self.sharedUser.userImage : [UIImage imageNamed:@"imageaftereditfemale.png"];
                    
                }
                break;
            case Chines:
                //
                
                if ([self.sharedUser.GenderEn  isEqual: @"Male"]) {
                    
                    self.profileImageView.image = self.sharedUser.userImage ? self.sharedUser.userImage : [UIImage imageNamed:@"imageafterediten_ch.png"];
                    
                }else{
                    //                    NSLog(self.sharedUser.GenderAr);
                    
                    self.profileImageView.image = self.sharedUser.userImage ? self.sharedUser.userImage : [UIImage imageNamed:@"imageaftereditfemale_ch.png"];
                    
                }
                break;
            case Philippine:
                //
                
                if ([self.sharedUser.GenderEn  isEqual: @"Male"]) {
                    
                    self.profileImageView.image = self.sharedUser.userImage ? self.sharedUser.userImage : [UIImage imageNamed:@"imageafterediten_fi.png"];
                    
                }else{
                    //                    NSLog(self.sharedUser.GenderAr);
                    
                    self.profileImageView.image = self.sharedUser.userImage ? self.sharedUser.userImage : [UIImage imageNamed:@"imageaftereditfemale_fi.png"];
                    
                }
            default:
                NSLog(@"Error while picking Language");
                
                break;
        }
    }else {
        
        
        NSLog(@"NoImage.png result from UrlImage √");
        if ([self.sharedUser.GenderEn  isEqual: @"Male"] || [self.sharedUser.GenderAr  isEqual: @"ذكر"]) {
            self.profileImageView.image = self.sharedUser.userImage ? self.sharedUser.userImage : [UIImage imageNamed:@"defaultdriver.jpg"];
        }else {
            self.profileImageView.image = self.sharedUser.userImage ? self.sharedUser.userImage : [UIImage imageNamed:@"defaultdriverfemale.jpg"];
        }
    }
    
    
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileImageView.layer.borderWidth = 0.5f;
    self.profileImageView.clipsToBounds = YES;
    
    self.ridesCreatedLabel.text = ridesCreatedText;
    self.ridesJoinedLabel.text = ridesJoinedText;
    self.vehiclesLabel.text = vehiclesCountText;
}


//LanguagePicker


//PickerT

- (void)pickerDoneClicked {
    //[textField resignFirstResponder];
    NSLog(@"hi");
    [_TextViaPicker resignFirstResponder];
    
    
    NSLog(@"that is the selected lang : %@",selected);
    
    if ([selected  isEqual: @"Arabic"] || [selected  isEqual: @"阿拉伯语"] || [selected  isEqual: @"Arabe"]|| [selected  isEqual: @"العربية"]) {
        NSLog(@"Select Arabic");
        [[Languages sharedLanguageInstance] setLanguage:Arabic];
        [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_CHANGE_NOTIFICATION object:self];
        [appDelegate reloadApp];
        
    } else  if ([selected  isEqual: @"Ingles"] || [selected  isEqual: @"英语"] || [selected  isEqual: @"الإنجليزية"]||[selected  isEqual: @"English"]) {
        NSLog(@"Select English");
        [[Languages sharedLanguageInstance] setLanguage:English];
        [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_CHANGE_NOTIFICATION object:self];
        [appDelegate reloadApp];
    } else  if ([selected  isEqual: @"الصينية"] || [selected  isEqual: @"Tsino"] || [selected  isEqual: @"Chinese"]||[selected  isEqual: @"中文"]) {
        NSLog(@"Select Chines");
        [[Languages sharedLanguageInstance] setLanguage:Chines];
        [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_CHANGE_NOTIFICATION object:self];
        [appDelegate reloadApp];
    } else  if ([selected  isEqual: @"Filipino"] || [selected  isEqual: @"الفلبينية"] || [selected  isEqual: @"菲律宾"]||[selected  isEqual: @"filipino"]) {
        NSLog(@"Select Filipino");
        [[Languages sharedLanguageInstance] setLanguage:Philippine];
        [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_CHANGE_NOTIFICATION object:self];
        [appDelegate reloadApp];
    }
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = hardCodedLanguages[row];
    if ([title  isEqual: @"Arabic"] || [title  isEqual: @"阿拉伯语"] || [title  isEqual: @"Arabe"]|| [title  isEqual: @"العربية"]) {
        title = GET_STRING(@"Arabic");
    } else  if ([title  isEqual: @"Ingles"] || [title  isEqual: @"英语"] || [title  isEqual: @"الإنجليزية"]||[title  isEqual: @"English"]) {
        title = GET_STRING(@"English");
    } else  if ([title  isEqual: @"الصينية"] || [title  isEqual: @"Tsino"] || [title  isEqual: @"Chinese"]||[title  isEqual: @"中文"]) {
        title = GET_STRING(@"Chinese");
    } else  if ([title  isEqual: @"Filipino"] || [title  isEqual: @"الفلبينية"] || [title  isEqual: @"菲律宾"]||[title  isEqual: @"filipino"]) {
        title = GET_STRING(@"Filipino");
    }//
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    
    return attString;
    
}

//

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return  hardCodedLanguages.count ;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return  hardCodedLanguages[row]  ;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    _TextViaPicker.text = hardCodedLanguages[row];
    selected = hardCodedLanguages[row];
    //    NSLog(selected);
    
    
}
-(void)pickerCANCELClicked{
    
    [_TextViaPicker resignFirstResponder];
}



//
- (IBAction)LanguageButtonPicker:(UIButton *)sender {
    [_TextViaPicker becomeFirstResponder];

    
}

//end of languagePicker
- (IBAction) verfiyMobileAction:(id)sender
{
    [KVNProgress showWithStatus:GET_STRING(@"Loading...")];
    
    [[MobAccountManager sharedMobAccountManager] verifyMobileNumber:[NSString stringWithFormat:@"%@",self.sharedUser.ID] WithSuccess:^(NSString *user)
     {
         [KVNProgress dismiss];
         
         if ([user containsString:@"1"])
         {
             [[HelpManager sharedHelpManager] showAlertWithMessage:GET_STRING(@"Mobile verification code has been sent to your mobile")];
             
             VerifyMobileViewController *verifyView = [[VerifyMobileViewController alloc] initWithNibName:@"VerifyMobileViewController" bundle:nil];
             
             verifyView.accountID = [NSString stringWithFormat:@"%@",self.sharedUser.ID] ;
             verifyView.delegate = self;
             [self presentPopupViewController:verifyView animationType:MJPopupViewAnimationSlideBottomBottom];
             
         }
         else
         {
             [[HelpManager sharedHelpManager] showAlertWithMessage:GET_STRING(@"Please check your mobile number")];
         }
     } Failure:^(NSString *error) {
         [KVNProgress dismiss];
     }];
}

- (void)dismissButtonClicked:(VerifyMobileViewController *)verifyMobileNumber
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    self.verifiedImgTwo.hidden = NO ;
    self.verifyBtn.hidden = YES ;
}

- (void) configureNavigationBar{
    
}

#pragma Gestures & Actions
- (void) searchAction{
    
    if ( IDIOM == IPAD ) {
        /* do something specifically for iPad. */
        SearchViewController *searchView = [[SearchViewController alloc] initWithNibName:(KIS_ARABIC)?@"SearchViewController_ar_Ipad":@"SearchViewController_Ipad" bundle:nil];
        searchView.enableBackButton = YES;
        [self.navigationController pushViewController:searchView animated:YES];
    } else {
        /* do something specifically for iPhone or iPod touch. */
        SearchViewController *searchView = [[SearchViewController alloc] initWithNibName:(KIS_ARABIC)?@"SearchViewController_ar":@"SearchViewController" bundle:nil];
        searchView.enableBackButton = YES;
        [self.navigationController pushViewController:searchView animated:YES];
    }
    

}

//GonMade creatRide
- (void) createRideAction
{
    //GonFollowOrders
    
    if (self.sharedUser.VehiclesCount.integerValue == 0)
    {
       
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:GET_STRING(@"You Don't Have Any Vehcile Registered") message:GET_STRING(@"Do you want to Register it now?") preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *Cancel = [UIAlertAction actionWithTitle:GET_STRING(@"Dismiss") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:GET_STRING(@"Register Vehicle") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (IDIOM == IPAD) {
                
                VehiclesViewController *registerVehicle = [[VehiclesViewController alloc] initWithNibName:(KIS_ARABIC)?@"VehiclesViewController_ar_Ipad":@"VehiclesViewController_Ipad" bundle:nil];
                registerVehicle.enableBackButton = YES;
                [self.navigationController pushViewController:registerVehicle animated:YES];
            }else {
                VehiclesViewController *registerVehicle = [[VehiclesViewController alloc] initWithNibName:(KIS_ARABIC)?@"VehiclesViewController_ar":@"VehiclesViewController" bundle:nil];
                registerVehicle.enableBackButton = YES;
                [self.navigationController pushViewController:registerVehicle animated:YES];
            }
        
            
        }];
        [alert addAction:Cancel];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
           } // first if
    else
    {
    
        if (self.sharedUser.DriverMyRidesCount.integerValue < 2)
        {
            User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];

            if (IDIOM == IPAD){
                CreateRideViewController *createRideViewController = [[CreateRideViewController alloc] initWithNibName:(KIS_ARABIC)?@"CreateRideViewController_ar_Ipad":@"CreateRideViewController_IPad" bundle:nil];
                createRideViewController.UserID = [NSString stringWithFormat:@"%@",user.ID];
                [self.navigationController pushViewController:createRideViewController animated:YES];
            }else {
                
                CreateRideViewController *createRideViewController = [[CreateRideViewController alloc] initWithNibName:(KIS_ARABIC)?@"CreateRideViewController_ar":@"CreateRideViewController" bundle:nil];
                createRideViewController.UserID = [NSString stringWithFormat:@"%@",user.ID];
                [self.navigationController pushViewController:createRideViewController animated:YES];
            }
            
            
            

        }
        else
        {
            [[HelpManager sharedHelpManager] showAlertWithMessage:GET_STRING(@"Sorry, It's not allowed to create more than two rides")];
        }
        
    }
}

- (void) historyAction
{
    
    NSLog(@"Happy Metter");
    HappyMeter *happyMeter = [[HappyMeter alloc] initWithNibName:@"HappyMeter" bundle:nil];
    happyMeter.serviceProviderSecret = serviceProviderSecretHM;
    happyMeter.clientID = clientIDHM;
    happyMeter.microApp = microAppHM;
    happyMeter.serviceProvider = serviceProviderHM;
    happyMeter.delegate = self;
    [self presentPopupViewController2:happyMeter animationType:MJPopupViewAnimationSlideBottomBottom];
    
    /* // SavedHistory
//    if ([[[[MobAccountManager sharedMobAccountManager] applicationUser] AccountStatus] isEqualToString:@"P"])
//    {
    
        NSLog(@"that is passenger value For H:%@",[[[MobAccountManager sharedMobAccountManager] applicationUser] IsPassenger]);
        NSString *LOL = [NSString stringWithFormat:@"%@",[[[MobAccountManager sharedMobAccountManager] applicationUser] IsPassenger]];
        NSLog(@"that is LOL Value :%@",LOL);
        if ([LOL containsString:@"1"] || [LOL containsString:@"true"]) {
        RidesJoinedViewController *joinedRidesViewController =  [[RidesJoinedViewController alloc] initWithNibName:@"RidesJoinedViewController" bundle:nil];
        joinedRidesViewController.title =  GET_STRING(@"History");
        [self.navigationController pushViewController:joinedRidesViewController animated:YES];
    }
    else
    {
        HistoryViewController *historyView = [[HistoryViewController alloc] initWithNibName:(KIS_ARABIC)?@"HistoryViewController_ar":@"HistoryViewController" bundle:nil];
        [self.navigationController pushViewController:historyView animated:YES];
    }
    
    */
}

- (void) permitAction
{
    PermitsViewController *permitsView = [[PermitsViewController alloc] initWithNibName:@"PermitsViewController" bundle:nil];
    [self.navigationController pushViewController:permitsView animated:YES];
}

- (void) savedSearchAction
{
    SavedSearchViewController *savedSearchViewController = [[SavedSearchViewController alloc] initWithNibName:@"SavedSearchViewController" bundle:nil];
    savedSearchViewController.enableBackButton = YES;
    [self.navigationController pushViewController:savedSearchViewController animated:YES];
}

- (IBAction) editAction:(id)sender
{
    if (IDIOM == IPAD) {
        
        EditProfileViewController *profileView = [[EditProfileViewController alloc] initWithNibName:(KIS_ARABIC)?@"EditProfileViewController_ar_Ipad":@"EditProfileViewController_Ipad" bundle:nil];
        [self.navigationController pushViewController:profileView animated:YES];
    }else {
        EditProfileViewController *profileView = [[EditProfileViewController alloc] initWithNibName:(KIS_ARABIC)?@"EditProfileViewController_ar":@"EditProfileViewController" bundle:nil];
        [self.navigationController pushViewController:profileView animated:YES];
    }

}

- (IBAction) openNotifications:(id)sender
{
    NotificationsViewController *notificationsView = [[NotificationsViewController alloc] initWithNibName:@"NotificationsViewController" bundle:nil];
    notificationsView.enableBackButton = YES;
    [self.navigationController pushViewController:notificationsView animated:YES];
}

- (void) getNotifications
{
    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
    
    __block HomeViewController *blockSelf = self;
    [KVNProgress showWithStatus:GET_STRING(@"loading")];
    
    [[MasterDataManager sharedMasterDataManager] getRequestNotifications:[NSString stringWithFormat:@"%@",user.ID] notificationType:NotificationTypeAlert  WithSuccess:^(NSMutableArray *array) {
        
        self.notificationCount += (int)array.count ;
        
        [self getAcceptedNotifications];
        
    } Failure:^(NSString *error) {
        NSLog(@"NotificationTypeAlert Error in Notifications");
        [KVNProgress dismiss];
        [KVNProgress showErrorWithStatus:@"Error"];
        [blockSelf performBlock:^{
            [KVNProgress dismiss];
        } afterDelay:3];
    }];
}

- (void) getAcceptedNotifications
{
    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
    
    __block HomeViewController *blockSelf = self;
    
    [[MasterDataManager sharedMasterDataManager] getRequestNotifications:[NSString stringWithFormat:@"%@",user.ID] notificationType:NotificationTypeAccepted WithSuccess:^(NSMutableArray *array) {
        
        blockSelf.notificationCount += (int)array.count ;
        [blockSelf getPendingNotifications];
        
    } Failure:^(NSString *error) {
        NSLog(@"NotificationTypeAccepted Error in Notifications");
        [KVNProgress dismiss];
        [KVNProgress showErrorWithStatus:@"Error"];
        [blockSelf performBlock:^{
            [KVNProgress dismiss];
        } afterDelay:3];
    }];
    
    [[MasterDataManager sharedMasterDataManager] getRequestNotifications:[NSString stringWithFormat:@"%@",user.ID] notificationType:NotificationTypeAccepted WithSuccess:^(NSMutableArray *array) {
        
        blockSelf.notificationCount += (int)array.count ;
        [blockSelf getPendingNotifications];
        
    } Failure:^(NSString *error) {
        NSLog(@"NotificationTypeAccepted Error in Notifications");
        [KVNProgress dismiss];
        [KVNProgress showErrorWithStatus:@"Error"];
        [blockSelf performBlock:^{
            [KVNProgress dismiss];
        } afterDelay:3];
    }];
    
}

- (void) getPendingNotifications
{
    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
    __block HomeViewController *blockSelf = self;
    
    [[MasterDataManager sharedMasterDataManager] getRequestNotifications:[NSString stringWithFormat:@"%@",user.ID] notificationType:Driver_GetPendingInvitationsFromPassenger WithSuccess:^(NSMutableArray *array) {
        
        blockSelf.notificationCount += (int)array.count ;
        self.notificationCountLabel.text = [NSString stringWithFormat:@"%d",blockSelf.NotificationURLCount];
        
        [KVNProgress dismiss];
        
    } Failure:^(NSString *error) {
        NSLog(@" Driver_GetPendingInvitationsFromPassenger Error in Notifications");
        [KVNProgress dismiss];
        [KVNProgress showErrorWithStatus:@"Error"];
        [blockSelf performBlock:^{
            [KVNProgress dismiss];
        } afterDelay:3];
    }];
}

- (void) showVeichles:(id)sender
{
    
    if (IDIOM == IPAD) {
        
        VehiclesViewController *registerVehicle = [[VehiclesViewController alloc] initWithNibName:(KIS_ARABIC)?@"VehiclesViewController_ar_Ipad":@"VehiclesViewController_Ipad" bundle:nil];
        registerVehicle.enableBackButton = YES;
        [self.navigationController pushViewController:registerVehicle animated:YES];
    }else {
        VehiclesViewController *registerVehicle = [[VehiclesViewController alloc] initWithNibName:(KIS_ARABIC)?@"VehiclesViewController_ar":@"VehiclesViewController" bundle:nil];
        registerVehicle.enableBackButton = YES;
        [self.navigationController pushViewController:registerVehicle animated:YES];
    }
    

}

- (void) showCreatedRides
{
    if (self.sharedUser.DriverMyRidesCount.integerValue > 0) {
        CreatedRidesViewController *createdRideViewController = [[CreatedRidesViewController alloc] initWithNibName:@"CreatedRidesViewController" bundle:nil];
        [self.navigationController pushViewController:createdRideViewController animated:YES];
    }
    else
    {
        [[HelpManager sharedHelpManager] showAlertWithMessage:GET_STRING(@"You don't have created rides yet")];
    }
}

- (void) showJoinedRides
{
    if (self.sharedUser.PassengerJoinedRidesCount.integerValue > 0) {
        RidesJoinedViewController *joinedRidesViewController =  [[RidesJoinedViewController alloc] initWithNibName:@"RidesJoinedViewController" bundle:nil];
        [self.navigationController pushViewController:joinedRidesViewController animated:YES];
    }
    else
    {
        [[HelpManager sharedHelpManager] showAlertWithMessage:GET_STRING(@"You don't have joined rides yet")];
    }
}

@end
