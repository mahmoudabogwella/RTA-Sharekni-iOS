//
//  CreateRideViewController.m
//  sharekni
//
//  Created by Mohamed Abd El-latef on 10/24/15.
//
//

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


@interface CreateRideViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *setDirectionButton;
@property (weak, nonatomic) IBOutlet UITextField *selectVehicleTextField;
@property (weak, nonatomic) IBOutlet UILabel *rideDetailsSectionLabel;
@property (weak, nonatomic) IBOutlet UIView *rideDetailsView;
@property (weak, nonatomic) IBOutlet UIView *optionsView;
@property (weak, nonatomic) IBOutlet UITextField *noOfSeatsTextField;
@property (weak, nonatomic) IBOutlet UILabel *optionalSectionLabel;
@property (weak, nonatomic) IBOutlet UITextField *rideNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *startPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationLabel;
@property (weak, nonatomic) IBOutlet UITextField *vehiclesTextField;
@property (weak, nonatomic) IBOutlet UILabel *destinationTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodicLabel;
@property (weak, nonatomic) IBOutlet UIImageView *switchImageView;
@property (weak, nonatomic) IBOutlet UILabel *singleRideLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *timeView;

@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextField *nationalityTextField;
@property (weak, nonatomic) IBOutlet UIView *typeView;
@property (weak, nonatomic) IBOutlet UITextField *langageTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageRangeTextField;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIImageView *genderSwitchImage;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UIView *genderView;


@property (strong, nonatomic)  NSDateFormatter *dateFormatter;
@property (assign, nonatomic)  RoadType selectedType;
@property (assign, nonatomic)  BOOL isFemaleOnly;
@property (strong,nonatomic) NSDate *pickupDate;

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

@end

@implementation CreateRideViewController

-(NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureUI];
    [self configureData];
    [self configureRoadTypeView];
    [self configureGenderView];
}

- (IBAction)setDirectionAction:(id)sender {
    [self showLocationPicker];
}

#pragma Data
- (void) configureData{
    __block CreateRideViewController *blockSelf = self;
    [KVNProgress showWithStatus:@"Loading"];
    [[MasterDataManager sharedMasterDataManager] GetNationalitiesByID:@"0" WithSuccess:^(NSMutableArray *array) {
        blockSelf.nationalties = array;
        [[MasterDataManager sharedMasterDataManager] GetAgeRangesWithSuccess:^(NSMutableArray *array) {
            blockSelf.ageRanges = array;
            [[MasterDataManager sharedMasterDataManager] GetPrefferedLanguagesWithSuccess:^(NSMutableArray *array) {
                blockSelf.languages = array;
                [[MobVehicleManager sharedMobVehicleManager] getVehiclesWithSuccess:^(NSArray *vehicles) {
                    blockSelf.vehicles = vehicles;
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
    self.pickupDate = [[NSDate date] dateBySettingHour:10];

    
    self.dateView.layer.cornerRadius = 10;
    self.dateView.layer.masksToBounds = YES;
    
    self.timeView.layer.cornerRadius = 10;
    self.timeView.layer.masksToBounds = YES;
    
    self.createButton.layer.cornerRadius = 8;
    
    self.langageTextField.textColor                 = Red_UIColor;
    self.nationalityTextField.textColor             = Red_UIColor;
    self.ageRangeTextField.textColor                = Red_UIColor;
    self.langageTextField.textColor                 = Red_UIColor;
    self.destinationLabel.textColor                 = Red_UIColor;
    self.startPointLabel.textColor                  = Red_UIColor;
    self.noOfSeatsTextField.textColor               = Red_UIColor;
    self.vehiclesTextField.textColor                = Red_UIColor;
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

- (void)popViewController
{
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

- (IBAction)creatRideAction:(id)sender {
    if (!self.fromEmirate) {
        [[HelpManager sharedHelpManager] showAlertWithMessage:NSLocalizedString(@"Please select start point ",nil)];
    }
    else if (!self.toEmirate){
        [[HelpManager sharedHelpManager] showAlertWithMessage:NSLocalizedString(@"Please select destination ",nil)];
        
    }
    else{
        __block CreateRideViewController *blockSelf = self;
        [KVNProgress showWithStatus:@"Loading..."];
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
    dateSelectionController.datePicker.date = self.pickupDate;
    
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
                self.nationalityTextField.text = nationality.NationalityArName;
                self.selectedNationality = nationality;
            }
                break;
            case LanguageTextField:
            {
                Language *language = [self.languages objectAtIndex:selectedRow];
                self.langageTextField.text = language.LanguageArName;
                self.selectedLanguage = language;
            }
                break;
            case AgeRangeTextField:
            {
                AgeRange *range = [self.ageRanges objectAtIndex:selectedRow];
                self.ageRangeTextField.text = range.Range;
                self.selectedAgeRange = range;
            }
                break;
            case VehiclesTextField:
            {
                Vehicle *vehicle = [self.vehicles objectAtIndex:selectedRow];
                self.vehiclesTextField.text = vehicle.ModelArName;
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
    __block CreateRideViewController *blockSelf = self;
    [selectLocationViewController setSelectionHandler:^(Emirate *fromEmirate, Region *fromRegion ,Emirate *toEmirate, Region *toRegion) {
        NSString *fromText = [NSString stringWithFormat:@"%@,%@",fromEmirate.EmirateEnName,fromRegion.RegionEnName];

            blockSelf.fromEmirate = fromEmirate;
            blockSelf.fromRegion = fromRegion;
            blockSelf.startPointLabel.text = fromText;
        NSString *toText = [NSString stringWithFormat:@"%@,%@",toEmirate.EmirateEnName,toRegion.RegionEnName];
        
            blockSelf.toEmirate = toEmirate;
            blockSelf.toRegion = toRegion;
            blockSelf.destinationLabel.text = toText;
    }];
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:selectLocationViewController];
    
    formSheet.formSheetWindow.transparentTouchEnabled = NO;
    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromTop;
    formSheet.shouldDismissOnBackgroundViewTap = YES;
    formSheet.shouldCenterVertically = NO;
    formSheet.presentedFormSheetSize = CGSizeMake(300, 200);
    formSheet.portraitTopInset = 55;
    formSheet.cornerRadius = 8;
    
    [formSheet presentAnimated:YES completionHandler:^(UIViewController *presentedFSViewController) {
        
    }];
}

#pragma TextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField == self.nationalityTextField){
        [self showPickerWithTextFieldType:NationalityTextField];
    }
    else if (textField == self.ageRangeTextField){
        [self showPickerWithTextFieldType:AgeRangeTextField];
    }
    else if (textField == self.langageTextField){
        [self showPickerWithTextFieldType:LanguageTextField];
    }
    else if (textField == self.vehiclesTextField){
        [self showPickerWithTextFieldType:VehiclesTextField];
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
            title = nationality.NationalityArName;
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
            title = language.LanguageArName;
        }
            break;
        case VehiclesTextField:
        {
            Vehicle *vehicle = [self.vehicles objectAtIndex:row];
            title = vehicle.ModelArName;
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
