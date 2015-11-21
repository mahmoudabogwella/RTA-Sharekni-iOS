//
//  CreateRideViewController.m
//  sharekni
//
//  Created by Mohamed Abd El-latef on 10/24/15.
//
//20027

#import "CreateRideViewController.h"
#import "MasterDataManager.h"
#import <RMActionController.h>
#import <RMDateSelectionViewController.h>
#import <NSDate+Components.h>
#import <NSDate+Time.h>
#import <UIColor+Additions.h>
#import "Constants.h"
#import "MasterDataManager.h"
#import <KVNProgress/KVNProgress.h>
#import "NSObject+Blocks.h"
#import <RMPickerViewController.h>
#import "AgeRange.h"
#import "Language.h"
#import "Nationality.h"
#import <KLCPopup/KLCPopup.h>
#import "PickupLocationView.h"
#import <MZFormSheetController.h>
#import "SelectLocationViewController.h"
#import "MobDriverManager.h"
#import "HelpManager.h"
#import "UILabel+Borders.h"
#import "MobVehicleManager.h"
#import "Vehicle.h"
#import "MasterDataManager.h"
#import "MobDriverManager.h"

@interface CreateRideViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *seat4ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *seat3ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *seat2ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *seat1ImageView;
@property (weak, nonatomic) IBOutlet UIView *emiratesAndRegionsView;
@property (weak, nonatomic) IBOutlet UILabel *helpLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectAgeRangeButton;
@property (weak, nonatomic) IBOutlet UIButton *selectLanguageButton;
@property (weak, nonatomic) IBOutlet UIButton *selectVehicleButton;
@property (weak, nonatomic) IBOutlet UIButton *setDirectionButton;
@property (weak, nonatomic) IBOutlet UILabel *rideDetailsSectionLabel;
@property (weak, nonatomic) IBOutlet UIView *rideDetailsView;
@property (weak, nonatomic) IBOutlet UIView *optionsView;
@property (weak, nonatomic) IBOutlet UILabel *optionalSectionLabel;
@property (weak, nonatomic) IBOutlet UITextField *rideNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *startPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodicLabel;
@property (weak, nonatomic) IBOutlet UIImageView *switchImageView;
@property (weak, nonatomic) IBOutlet UILabel *singleRideLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *availableSeatsLabel;

@property (weak, nonatomic) IBOutlet UIView *timeView;

@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextField *nationalityTextField;
@property (weak, nonatomic) IBOutlet UIView *typeView;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIImageView *genderSwitchImage;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UIView *genderView;

@property (weak, nonatomic) IBOutlet UILabel *satLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunLabel;
@property (weak, nonatomic) IBOutlet UILabel *monLabel;
@property (weak, nonatomic) IBOutlet UILabel *tueLabel;
@property (weak, nonatomic) IBOutlet UILabel *wedLabel;
@property (weak, nonatomic) IBOutlet UILabel *thrLabel;
@property (weak, nonatomic) IBOutlet UILabel *friLabel;
@property (weak, nonatomic) IBOutlet UILabel *daysOfWeek;

@property (strong, nonatomic)  NSDateFormatter *dateFormatter;
@property (assign, nonatomic)  RoadType selectedType;
@property (assign, nonatomic)  BOOL isFemaleOnly;
@property (strong,nonatomic)   NSDate *pickupDate;

@property (strong,nonatomic) NSArray *nationalties;
@property (strong,nonatomic) NSArray *languages;
@property (strong,nonatomic) NSArray *ageRanges;
@property (strong,nonatomic) NSArray *vehicles;

@property (strong,nonatomic) AgeRange *selectedAgeRange;
@property (strong,nonatomic) Nationality *selectedNationality;
@property (strong,nonatomic) Language *selectedLanguage;
@property (strong,nonatomic) Vehicle *selectedVehicle;

@property (strong,nonatomic) Emirate *fromEmirate;
@property (strong,nonatomic) Emirate *toEmirate;

@property (strong,nonatomic) Region *fromRegion;
@property (strong,nonatomic) Region *toRegion;

@property (assign,nonatomic) BOOL isEdit;

@property (assign,nonatomic) BOOL seat1Active;
@property (assign,nonatomic) BOOL seat2Active;
@property (assign,nonatomic) BOOL seat3Active;
@property (assign,nonatomic) BOOL seat4Active;


@property (assign,nonatomic) BOOL satActive;
@property (assign,nonatomic) BOOL sunActive;
@property (assign,nonatomic) BOOL monActive;
@property (assign,nonatomic) BOOL tueActive;
@property (assign,nonatomic) BOOL wedActive;
@property (assign,nonatomic) BOOL thrActive;
@property (assign,nonatomic) BOOL friActive;
@property (assign, nonatomic) NSInteger noOfSeats;
@end

@implementation CreateRideViewController

-(NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.isEdit = (self.ride != nil);
    if (self.isEdit) {
        
    }
    else{
        self.noOfSeats = 0;
    }
    [self configureUI];
    [self configureSeats];
    [self configureDaysLabels];
    [self configureData];
    [self configureRoadTypeView];
    [self configureGenderView];
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

#pragma SEATS

- (void) configureSeats{
    self.seat1Active = NO;
    self.seat2Active = NO;
    self.seat3Active = NO;
    self.seat4Active = NO;
    UITapGestureRecognizer *seat1Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seat1GestureHandler)];
    [self.seat1ImageView addGestureRecognizer:seat1Gesture];
    
    UITapGestureRecognizer *seat2Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seat2GestureHandler)];
    [self.seat2ImageView addGestureRecognizer:seat2Gesture];
    
    UITapGestureRecognizer *seat3Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seat3GestureHandler)];
    [self.seat3ImageView addGestureRecognizer:seat3Gesture];
    
    UITapGestureRecognizer *seat4Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seat4GestureHandler)];
    [self.seat4ImageView addGestureRecognizer:seat4Gesture];
}


- (void) seat1GestureHandler{
    self.seat1Active = !self.seat1Active;
    if(self.seat1Active){
        [self.seat1ImageView setImage:[UIImage imageNamed:@"SeatActive"]];
        self.noOfSeats ++;
    }
    else{
        [self.seat1ImageView setImage:[UIImage imageNamed:@"Seat"]];
        self.noOfSeats --;
    }
}

- (void) seat2GestureHandler{
    self.seat2Active = !self.seat2Active;
    if(self.seat2Active){
        [self.seat2ImageView setImage:[UIImage imageNamed:@"SeatActive"]];
        self.noOfSeats ++;
    }
    else{
        [self.seat2ImageView setImage:[UIImage imageNamed:@"Seat"]];
        self.noOfSeats --;
    }
}

- (void) seat3GestureHandler{
    self.seat3Active = !self.seat3Active;
    if(self.seat3Active){
        [self.seat3ImageView setImage:[UIImage imageNamed:@"SeatActive"]];
        self.noOfSeats ++;
    }
    else{
        [self.seat3ImageView setImage:[UIImage imageNamed:@"Seat"]];
        self.noOfSeats --;
    }
    
}

- (void) seat4GestureHandler{
    self.seat4Active = !self.seat4Active;
    if(self.seat4Active){
        [self.seat4ImageView setImage:[UIImage imageNamed:@"SeatActive"]];
        self.noOfSeats ++;
    }
    else{
        [self.seat4ImageView setImage:[UIImage imageNamed:@"Seat"]];
        self.noOfSeats --;
    }
}

#pragma ACTIONS
- (IBAction) selectVehilceAction:(id)sender {
    if(self.vehicles.count == 0){
        [[HelpManager sharedHelpManager] showAlertWithMessage:NSLocalizedString(@"please configure your vehicles first", nil)];
    }
    else{
        [self showPickerWithTextFieldType:VehiclesTextField];
    }
}

- (IBAction) setDirectionAction:(id)sender {
    [self showLocationPicker];
}

- (IBAction) selectLanguageAction:(id)sender {
    [self showPickerWithTextFieldType:LanguageTextField];
}

- (IBAction) selectAgeRangeAction:(id)sender {
    [self showPickerWithTextFieldType:AgeRangeTextField];
}

#pragma DAYSOFWEEK
- (void) configureDaysLabels{
    if (self.isEdit) {
        
    }
    else{
        self.satActive = NO;
        self.sunActive = NO;
        self.monActive = NO;
        self.tueActive = NO;
        self.wedActive = NO;
        self.thrActive = NO;
        self.friActive = NO;
    }
    self.daysOfWeek.textColor = Red_UIColor;
    self.daysOfWeek.text = NSLocalizedString(@"Days Of Week", nil);
    self.daysOfWeek.backgroundColor   = [UIColor whiteColor];
    
    
    UITapGestureRecognizer *satGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(satTapped)];
    self.satLabel.layer.cornerRadius = self.satLabel.frame.size.width/2;
    self.satLabel.clipsToBounds = YES;
    self.satLabel.layer.borderWidth = .4;
    [self.satLabel addGestureRecognizer:satGesture];
    
    if(self.satActive){
        self.satLabel.layer.borderColor = Red_UIColor.CGColor;
        self.satLabel.backgroundColor = Red_UIColor;
        self.satLabel.textColor = [UIColor whiteColor];
    }
    else{
        self.satLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.satLabel.backgroundColor = [UIColor lightGrayColor];
        self.satLabel.textColor = [UIColor whiteColor];
    }
    
    UITapGestureRecognizer *sunGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sunTapped)];
    self.sunLabel.layer.cornerRadius = self.sunLabel.frame.size.width/2;
    self.sunLabel.clipsToBounds = YES;
    self.sunLabel.layer.borderWidth = .4;
    [self.sunLabel addGestureRecognizer:sunGesture];
    
    if(self.sunActive){
        self.sunLabel.backgroundColor = Red_UIColor;
        self.sunLabel.layer.borderColor = Red_UIColor.CGColor;
        self.sunLabel.textColor = [UIColor whiteColor];
    }
    else{
        self.sunLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.sunLabel.backgroundColor = [UIColor lightGrayColor];
        self.sunLabel.textColor = [UIColor whiteColor];
    }
    
    UITapGestureRecognizer *monGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(monTapped)];
    self.monLabel.layer.cornerRadius = self.monLabel.frame.size.width/2;
    self.monLabel.clipsToBounds = YES;
    self.monLabel.layer.borderWidth = .4;

    [self.monLabel addGestureRecognizer:monGesture];
    
    if(self.monActive){
        self.monLabel.backgroundColor = Red_UIColor;
        self.monLabel.layer.borderColor = Red_UIColor.CGColor;
        self.monLabel.textColor = [UIColor whiteColor];
    }
    else{
        self.monLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.monLabel.backgroundColor = [UIColor lightGrayColor];
        self.monLabel.textColor = [UIColor whiteColor];
    }
    
    UITapGestureRecognizer *tueGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tueTapped)];
    self.tueLabel.layer.cornerRadius = self.tueLabel.frame.size.width/2;
    self.tueLabel.clipsToBounds = YES;
    self.tueLabel.layer.borderWidth = .4;
    [self.tueLabel addGestureRecognizer:tueGesture];
    
    if(self.tueActive){
        self.tueLabel.backgroundColor = Red_UIColor;
        self.tueLabel.layer.borderColor = Red_UIColor.CGColor;
        self.tueLabel.textColor = [UIColor whiteColor];
    }
    else{
        self.tueLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.tueLabel.backgroundColor = [UIColor lightGrayColor];
        self.tueLabel.textColor = [UIColor whiteColor];
    }
    
    UITapGestureRecognizer *wedGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wedTapped)];
    self.wedLabel.layer.cornerRadius = self.wedLabel.frame.size.width/2;
    self.wedLabel.clipsToBounds = YES;
    self.wedLabel.layer.borderWidth = .4;
    [self.wedLabel addGestureRecognizer:wedGesture];
    
    if(self.wedActive){
        self.wedLabel.backgroundColor = Red_UIColor;
        self.wedLabel.layer.borderColor = Red_UIColor.CGColor;
        self.wedLabel.textColor = [UIColor whiteColor];
    }
    else{
        self.wedLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.wedLabel.backgroundColor = [UIColor lightGrayColor];
        self.wedLabel.textColor = [UIColor whiteColor];
    }
    
    UITapGestureRecognizer *thrGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thrTapped)];
    self.thrLabel.layer.cornerRadius = self.thrLabel.frame.size.width/2;
    self.thrLabel.clipsToBounds = YES;
    self.thrLabel.layer.borderWidth = .4;
    [self.thrLabel addGestureRecognizer:thrGesture];
    
    if(self.thrActive){
        self.thrLabel.backgroundColor = Red_UIColor;
        self.thrLabel.layer.borderColor = Red_UIColor.CGColor;
        self.thrLabel.textColor = [UIColor whiteColor];
    }
    else{
        self.thrLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.thrLabel.backgroundColor = [UIColor lightGrayColor];
        self.thrLabel.textColor = [UIColor whiteColor];
    }
    
    UITapGestureRecognizer *friGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(friTapped)];
    self.friLabel.layer.cornerRadius = self.friLabel.frame.size.width/2;
    self.friLabel.clipsToBounds = YES;
    self.friLabel.layer.borderWidth = .4;
    [self.friLabel addGestureRecognizer:friGesture];
    
    if(self.friActive){
        self.friLabel.backgroundColor = Red_UIColor;
        self.friLabel.layer.borderColor = Red_UIColor.CGColor;
        self.friLabel.textColor = [UIColor whiteColor];
    }
    else{
        self.friLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.friLabel.backgroundColor = [UIColor lightGrayColor];
        self.friLabel.textColor = [UIColor whiteColor];
    }
}

- (void) satTapped{
    self.satActive =  !self.satActive;
    if(self.satActive){
        self.satLabel.backgroundColor = Red_UIColor;
        self.satLabel.textColor = [UIColor whiteColor];
    }
    else{
        self.satLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.satLabel.backgroundColor = [UIColor lightGrayColor];
        self.satLabel.textColor = [UIColor whiteColor];;
    }
}
- (void) sunTapped{
    self.sunActive = !self.sunActive;
    if(self.sunActive){
        self.sunLabel.backgroundColor = Red_UIColor;
        self.sunLabel.textColor = [UIColor whiteColor];
    }
    else{
        self.sunLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.sunLabel.backgroundColor = [UIColor lightGrayColor];
        self.sunLabel.textColor = [UIColor whiteColor];
    }
}
- (void) monTapped{
    self.monActive = !self.monActive;
    if(self.monActive){
        self.monLabel.backgroundColor = Red_UIColor;
        self.monLabel.textColor = [UIColor whiteColor];
    }
    else{
        self.monLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.monLabel.backgroundColor = [UIColor lightGrayColor];
        self.monLabel.textColor = [UIColor whiteColor];
    }
}
- (void) tueTapped{
    self.tueActive = !self.tueActive;
    if(self.tueActive){
        self.tueLabel.backgroundColor = Red_UIColor;
        self.tueLabel.textColor = [UIColor whiteColor];
    }
    else{
        self.tueLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.tueLabel.backgroundColor = [UIColor lightGrayColor];
        self.tueLabel.textColor = [UIColor whiteColor];
    }
}
- (void) wedTapped{
    self.wedActive = !self.wedActive;
    if(self.wedActive){
        self.wedLabel.backgroundColor = Red_UIColor;
        self.wedLabel.textColor = [UIColor whiteColor];
    }
    else{
        self.wedLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.wedLabel.backgroundColor = [UIColor lightGrayColor];
        self.wedLabel.textColor = [UIColor whiteColor];
    }
}
- (void) thrTapped{
    self.thrActive = !self.thrActive;
    if(self.thrActive){
        self.thrLabel.backgroundColor = Red_UIColor;
        self.thrLabel.textColor = [UIColor whiteColor];
    }
    else{
        self.thrLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.thrLabel.backgroundColor = [UIColor lightGrayColor];
        self.thrLabel.textColor = [UIColor whiteColor];
    }
}
- (void) friTapped{
    self.friActive = !self.friActive;
    if(self.friActive){
        self.friLabel.backgroundColor = Red_UIColor;
        self.friLabel.textColor = [UIColor whiteColor];
    }
    else{
        self.friLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.friLabel.backgroundColor = [UIColor lightGrayColor];
        self.friLabel.textColor = [UIColor whiteColor];
    }
}

#pragma Data
- (void) configureData{
    __block CreateRideViewController *blockSelf = self;
    [KVNProgress showWithStatus:@"Loading"];
    [[MasterDataManager sharedMasterDataManager] getVehicleById:nil WithSuccess:^(NSMutableArray *array) {
        blockSelf.vehicles = array;
        [[MasterDataManager sharedMasterDataManager] GetNationalitiesByID:@"0" WithSuccess:^(NSMutableArray *array) {
            blockSelf.nationalties = array;
            [[MasterDataManager sharedMasterDataManager] GetAgeRangesWithSuccess:^(NSMutableArray *array) {
                blockSelf.ageRanges = array;
                [[MasterDataManager sharedMasterDataManager] GetPrefferedLanguagesWithSuccess:^(NSMutableArray *array) {
                    blockSelf.languages = array;
                    [KVNProgress dismiss];
                } Failure:^(NSString *error) {
                    [blockSelf handleManagerFailure];
                }];
            } Failure:^(NSString *error) {
                [blockSelf handleManagerFailure];
            }];
        } Failure:^(NSString *error) {
            [blockSelf handleManagerFailure];
        }];
    } Failure:^(NSString *error) {
            [blockSelf handleManagerFailure];        
    }];
}

- (void) handleManagerFailure{
    [KVNProgress dismiss];
    [KVNProgress showErrorWithStatus:@"Error"];
    [self performBlock:^{
        [KVNProgress dismiss];
    } afterDelay:3];
}

#pragma UI

- (void) configureUI{
    
    self.title = NSLocalizedString(@"Create Ride", nil);
    
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.scrollView.frame.size.height)];
    self.selectedType = SingleRideType;
    self.isFemaleOnly = false;

    
    self.dateView.layer.cornerRadius = 10;
    self.dateView.layer.masksToBounds = YES;
    
    self.timeView.layer.cornerRadius = 10;
    self.timeView.layer.masksToBounds = YES;
    
    self.createButton.layer.cornerRadius = 8;
    
    [self.selectVehicleButton setTitleColor:Red_UIColor forState:UIControlStateNormal];
    [self.selectVehicleButton setBackgroundColor:[UIColor whiteColor]];
    
    [self.selectLanguageButton setTitleColor:Red_UIColor forState:UIControlStateNormal];
    [self.selectLanguageButton setBackgroundColor:[UIColor whiteColor]];
    
    [self.selectAgeRangeButton setTitleColor:Red_UIColor forState:UIControlStateNormal];
    [self.selectAgeRangeButton setBackgroundColor:[UIColor whiteColor]];
    
    self.nationalityTextField.textColor             = Red_UIColor;
    self.destinationLabel.textColor                 = Red_UIColor;
    self.startPointLabel.textColor                  = Red_UIColor;

    self.rideDetailsSectionLabel.textColor          = Red_UIColor;
    self.optionalSectionLabel.textColor             = Red_UIColor;
    
    [self.rideDetailsSectionLabel addRightBorderWithColor:Red_UIColor];
    [self.rideDetailsSectionLabel addLeftBorderWithColor:Red_UIColor];
    [self.optionalSectionLabel addRightBorderWithColor:Red_UIColor];
    [self.optionalSectionLabel addLeftBorderWithColor:Red_UIColor];
    
    UITapGestureRecognizer *dateTapGestureRecognizer  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDatePicker)];
    [self.dateView addGestureRecognizer:dateTapGestureRecognizer];
    
    UITapGestureRecognizer *TimeTapGestureRecognizer  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTimePicker)];
    [self.timeView addGestureRecognizer:TimeTapGestureRecognizer];
    
    UITapGestureRecognizer *typeGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(typeChangedHandler)];
    self.typeView.userInteractionEnabled = YES;
    [self.typeView addGestureRecognizer:typeGestureRecognizer];
    
    UITapGestureRecognizer *genderGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(genderChangedHandler)];
    self.genderView.userInteractionEnabled = YES;
    [self.genderView addGestureRecognizer:genderGestureRecognizer];
    
    UITapGestureRecognizer *dismissGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissHandler)];
    [self.view addGestureRecognizer:dismissGestureRecognizer];
    
    self.rideDetailsView.layer.cornerRadius = 20;
    self.rideDetailsView.backgroundColor = [UIColor clearColor];
    self.rideDetailsView.layer.borderColor = Red_UIColor.CGColor;
    self.rideDetailsView.layer.borderWidth = 1.0f;

    self.optionsView.layer.cornerRadius = 20;
    self.optionsView.backgroundColor = [UIColor clearColor];
    self.optionsView.layer.borderColor = Red_UIColor.CGColor;
    self.optionsView.layer.borderWidth = 1.0f;
    
    if(self.isEdit){
        self.helpLabel.alpha = 0;
        self.emiratesAndRegionsView.alpha = 1;
    }
    else {
        self.helpLabel.alpha = 1;
        self.emiratesAndRegionsView.alpha = 0;
    }
}

- (void) configureRoadTypeView{
    switch (self.selectedType) {
        case SingleRideType:
            self.singleRideLabel.textColor = [UIColor add_colorWithRGBHexString:Red_HEX];
            self.periodicLabel.textColor = [UIColor darkGrayColor];
            self.switchImageView.image = [UIImage imageNamed:@"select_Left"];
            break;
        case PeriodicType:
            self.periodicLabel.textColor = [UIColor add_colorWithRGBHexString:Red_HEX];
            self.singleRideLabel.textColor = [UIColor darkGrayColor];
            self.switchImageView.image = [UIImage imageNamed:@"select_Right"];
            break;
        default:
            break;
    }
}

- (void) configureGenderView{
    if (self.isFemaleOnly) {
        self.genderSwitchImage.image = [UIImage imageNamed:@"select_Right"];
        self.genderLabel.textColor = [UIColor add_colorWithRGBHexString:Red_HEX];
    }
    else{
        self.genderSwitchImage.image = [UIImage imageNamed:@"select_Left"];
        self.genderLabel.textColor = [UIColor darkGrayColor];
    }
}

#pragma Actions&Handler

- (void) popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) genderChangedHandler{
    self.isFemaleOnly = !self.isFemaleOnly;
    [self configureGenderView];
}

- (void) typeChangedHandler{
    if (self.selectedType == SingleRideType) {
        self.selectedType = PeriodicType;
    }
    else{
        self.selectedType = SingleRideType;
    }
    [self configureRoadTypeView];
}

- (void) dismissHandler{
    [self.view endEditing:YES];
}

- (IBAction) creatRideAction:(id)sender {
    if (!self.fromEmirate || !self.toEmirate) {
        [[HelpManager sharedHelpManager] showAlertWithMessage:NSLocalizedString(@"Please set startpoint and destination.",nil)];
    }
    else if (!self.selectedVehicle){
        [[HelpManager sharedHelpManager] showAlertWithMessage:NSLocalizedString(@"Please select Vehicle.",nil)];
    }
    else if (self.rideNameTextField.text.length == 0){
        [[HelpManager sharedHelpManager] showAlertWithMessage:NSLocalizedString(@"Please enter ride name.",nil)];
    }
//    else if (self.noOfSeats.text.length == 0){
//        [[HelpManager sharedHelpManager] showAlertWithMessage:NSLocalizedString(@"Please enter ride name.",nil)];
//    }
//    else if (self.rideNameTextField.text.length == 0){
//        [[HelpManager sharedHelpManager] showAlertWithMessage:NSLocalizedString(@"Please enter ride name.",nil)];
//    }
    else{
        __block CreateRideViewController *blockSelf = self;
        [KVNProgress showWithStatus:@"Loading..."];
        BOOL isRounded = self.selectedType == PeriodicType ? YES : NO;
        NSString *gender = self.isFemaleOnly ? @"F":@"M";
        
        [[MobDriverManager sharedMobDriverManager] createRideWithName:self.rideNameTextField.text fromEmirate:self.fromEmirate fromRegion:self.fromRegion toEmirate:self.toEmirate toRegion:self.toRegion isRounded:isRounded date:self.pickupDate saturday:self.satActive sunday:self.sunActive monday:self.monActive tuesday:self.tueActive wednesday:self.wedActive thursday:self.thrActive friday:self.friActive PreferredGender:gender vehicle:self.selectedVehicle noOfSeats:self.noOfSeats language:self.selectedLanguage nationality:self.selectedNationality  ageRange:self.selectedAgeRange WithSuccess:^(NSString *response) {
            [KVNProgress dismiss];
            
            if ([response containsString:@"1"]) {
                [KVNProgress showSuccessWithStatus:NSLocalizedString(@"Ride created successfully", nil)];
                [blockSelf performBlock:^{
                    [KVNProgress dismiss];
                    [blockSelf.navigationController popViewControllerAnimated:YES];
                } afterDelay:3];
            }
            else if ([response containsString:@"0"]){
                [[HelpManager sharedHelpManager] showAlertWithMessage:NSLocalizedString(@"Error.", nil)];
            }
            else if ([response containsString:@"-2"]){
                [[HelpManager sharedHelpManager] showAlertWithMessage:NSLocalizedString(@"you cannot create more than 2 rides.", nil)];
            }
        } Failure:^(NSString *error) {
            [KVNProgress dismiss];
            [KVNProgress showErrorWithStatus:NSLocalizedString(@"an error happend when trying to create ride", nil)];
            [blockSelf performBlock:^{
                [KVNProgress dismiss];
            } afterDelay:3];
        }];
    }
}

#pragma Pickers

- (void) showDatePicker{
    __block CreateRideViewController *blockSelf = self;
    RMAction *selectAction = [RMAction actionWithTitle:NSLocalizedString(@"Select",nil) style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        NSDate *date =  ((UIDatePicker *)controller.contentView).date;
        blockSelf.dateFormatter.dateFormat = @"EEE,  dd/MM/yyyy";
        NSString *dateString = [self.dateFormatter stringFromDate:date];
        blockSelf.dateLabel.text = dateString;
        
        NSInteger hour = blockSelf.pickupDate.hour;
        NSInteger minutes = blockSelf.pickupDate.minute;
        
        blockSelf.pickupDate = [[date dateBySettingHour:hour] dateBySettingMinute:minutes];
    }];
    
    //Create cancel action
    RMAction *cancelAction = [RMAction actionWithTitle:NSLocalizedString(@"Cancel",nil) style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        
    }];
    
    //Create date selection view controller
    RMDateSelectionViewController *dateSelectionController = [RMDateSelectionViewController actionControllerWithStyle:RMActionControllerStyleWhite selectAction:selectAction andCancelAction:cancelAction];
    dateSelectionController.title = NSLocalizedString(@"select Pickup Date", nil);
    dateSelectionController.datePicker.datePickerMode = UIDatePickerModeDate;
    dateSelectionController.datePicker.date = self.pickupDate ? self.pickupDate : [NSDate date];
    
    //Now just present the date selection controller using the standard iOS presentation method
    [self presentViewController:dateSelectionController animated:YES completion:nil];
}

- (void) showTimePicker{
    
    __block CreateRideViewController *blockSelf = self;
    RMAction *selectAction = [RMAction actionWithTitle:NSLocalizedString(@"Select",nil) style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        NSDate *date =  ((UIDatePicker *)controller.contentView).date;
        blockSelf.dateFormatter.dateFormat = @"HH:mm a";
        NSString *time = [self.dateFormatter stringFromDate:date];
        blockSelf.timeLabel.text = time;
        NSInteger hour = date.hour;
        NSInteger minutes = date.minute;
        blockSelf.pickupDate = [blockSelf.pickupDate dateBySettingHour:hour minute:minutes second:0];
    }];
    
    //Create cancel action
    RMAction *cancelAction = [RMAction actionWithTitle:NSLocalizedString(@"Cancel",nil) style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        
    }];
    
    //Create date selection view controller
    RMDateSelectionViewController *dateSelectionController = [RMDateSelectionViewController actionControllerWithStyle:RMActionControllerStyleWhite selectAction:selectAction andCancelAction:cancelAction];
    dateSelectionController.title = NSLocalizedString(@"select Pickup Time",nil);
    dateSelectionController.datePicker.datePickerMode = UIDatePickerModeTime;
    dateSelectionController.datePicker.date = self.pickupDate;
    
    //Now just present the date selection controller using the standard iOS presentation method
    [self presentViewController:dateSelectionController animated:YES completion:nil];
}
//http://www.sharekni-web.sdg.ae/_mobfiles/CLS_MobDriver.asmx/Passenger_FindRide?AccountID=0&PreferredGender=N&Time=&FromEmirateID=2&FromRegionID=5&ToEmirateID=3&ToRegionID=8&PrefferedLanguageId=0&PrefferedNationlaities=&AgeRangeId=0&StartDate=&SaveFind=0&IsPeriodic=

- (void) showPickerWithTextFieldType:(TextFieldType)type{
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        UIPickerView *picker = ((RMPickerViewController *)controller).picker;
        NSInteger selectedRow = [picker selectedRowInComponent:0];
        switch (picker.tag) {
            case NationalityTextField:
            {
                Nationality *nationality = [self.nationalties objectAtIndex:selectedRow];
                self.nationalityTextField.text = nationality.NationalityEnName;
                self.selectedNationality = nationality;
            }
                break;
            case LanguageTextField:
            {
                Language *language = [self.languages objectAtIndex:selectedRow];
                [self.selectLanguageButton setTitle:language.LanguageEnName forState:UIControlStateNormal];
                self.selectedLanguage = language;
            }
                break;
            case AgeRangeTextField:
            {
                AgeRange *range = [self.ageRanges objectAtIndex:selectedRow];
                [self.selectAgeRangeButton  setTitle:range.Range forState:UIControlStateNormal];
                self.selectedAgeRange = range;
            }
                break;
            case VehiclesTextField:
            {
                Vehicle *vehicle = [self.vehicles objectAtIndex:selectedRow];
                [self.selectVehicleButton setTitle:vehicle.ModelEnName forState:UIControlStateNormal];
                self.selectedVehicle = vehicle;
            }
                break;
                
            default:
                break;
        }
    }];
    
    
    RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        NSLog(@"Row selection was canceled");
    }];
    
    //Create picker view controller
    RMPickerViewController *pickerController = [RMPickerViewController actionControllerWithStyle:RMActionControllerStyleDefault selectAction:selectAction andCancelAction:cancelAction];
    
    pickerController.picker.delegate = self;
    pickerController.picker.dataSource = self;
    pickerController.picker.tag = type;
    NSInteger selectedRow = 0;
    switch (type) {
        case NationalityTextField:
        {
            if (self.selectedNationality) {
                selectedRow = [self.nationalties indexOfObject:self.selectedNationality];
            }
        }
            break;
        case LanguageTextField:
        {
            if (self.selectedLanguage) {
                selectedRow = [self.languages indexOfObject:self.selectedLanguage];
            }
        }
            break;
        case AgeRangeTextField:
        {
            if (self.selectedAgeRange) {
                selectedRow = [self.ageRanges indexOfObject:self.selectedAgeRange];
            }
        }
            break;
        case VehiclesTextField:
        {
            if (self.selectedVehicle) {
                selectedRow = [self.vehicles indexOfObject:self.selectedVehicle];
            }
        }
            break;
        default:
            break;
    }
    [pickerController.picker selectRow:selectedRow inComponent:0 animated:YES];
    //Now just present the picker controller using the standard iOS presentation method
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (void) showLocationPicker{
    SelectLocationViewController *selectLocationViewController = [[SelectLocationViewController alloc] initWithNibName:@"SelectLocationViewController" bundle:nil];
    selectLocationViewController.validateDestination = YES;
    __block CreateRideViewController *blockSelf = self;
    [selectLocationViewController setSelectionHandler:^(Emirate *fromEmirate, Region *fromRegion,Emirate *toEmirate, Region *toRegion) {
        
        blockSelf.helpLabel.alpha = 0;
        blockSelf.emiratesAndRegionsView.alpha = 1;
        
        NSString *fromText = [NSString stringWithFormat:@"%@,%@",fromEmirate.EmirateEnName,fromRegion.RegionEnName];
        
        blockSelf.fromEmirate = fromEmirate;
        blockSelf.fromRegion = fromRegion;
        blockSelf.startPointLabel.text = fromText;
        
        NSString *toText = [NSString stringWithFormat:@"%@,%@",toEmirate.EmirateEnName,toRegion.RegionEnName];
        blockSelf.toEmirate = toEmirate;
        blockSelf.toRegion = toRegion;
        blockSelf.destinationLabel.text = toText;
        
    }];
    [self.navigationController pushViewController:selectLocationViewController animated:YES];
}

#pragma TextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField == self.nationalityTextField){
        [self showPickerWithTextFieldType:NationalityTextField];
    }
    return NO;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma PickerViewDeelgate&DataSource
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"";
    switch (pickerView.tag) {
        case NationalityTextField:
        {
            Nationality *nationality = [self.nationalties objectAtIndex:row];
            title = nationality.NationalityEnName;
        }
            break;
        case AgeRangeTextField:
        {
            AgeRange *range = [self.ageRanges objectAtIndex:row];
            title = range.Range;
        }
            break;
        case LanguageTextField:
        {
            Language *language = [self.languages objectAtIndex:row];
            title = language.LanguageEnName;
        }
            break;
        case VehiclesTextField:
        {
            Vehicle *vehicle = [self.vehicles objectAtIndex:row];
            title = vehicle.ModelEnName;
        }
            break;
            
        default:
            break;
    }
    
    return title;


}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case NationalityTextField:
        {
            return self.nationalties.count;
        }
            break;
        case AgeRangeTextField:
        {
            return self.ageRanges.count;
        }
            break;
        case LanguageTextField:
        {
            return self.languages.count;
        }
            break;
        case VehiclesTextField:
        {
            return self.vehicles.count;
        }
            break;
            
        default:
            break;
    }
    return 0;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

@end
