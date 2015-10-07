//
//  AdvancedSearchViewController.m
//  Sharekni
//
//  Created by Ahmed Askar on 9/26/15.
//
//

#import "AdvancedSearchViewController.h"
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
typedef enum RoadType : NSUInteger {
    PeriodicType,
    SingleRideType
} RoadType;

typedef enum TextFieldType : NSUInteger {
    PickupTextField,
    DestinationTextField,
    NationalityTextField,
    LanguageTextField,
    AgeRangeTextField
} TextFieldType;

@interface AdvancedSearchViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
//Outlets
@property (weak, nonatomic) IBOutlet UITextField *startPointTextField;
@property (weak, nonatomic) IBOutlet UITextField *destinationTextFiled;
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UILabel *dayNumberLabel;
@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthAndYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextField *nationalityTextField;
@property (weak, nonatomic) IBOutlet UIView *typeView;
@property (weak, nonatomic) IBOutlet UITextField *langageTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageRangeTextField;
@property (weak, nonatomic) IBOutlet UIView *sepratorLine;
@property (weak, nonatomic) IBOutlet UILabel *optionalHeader;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UILabel *pickupTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dropoffTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeSwitchImage;
@property (weak, nonatomic) IBOutlet UIImageView *genderSwitchImage;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodicLabel;
@property (weak, nonatomic) IBOutlet UILabel *singleRideLabel;
@property (weak, nonatomic) IBOutlet UIView *genderView;

@property (strong, nonatomic)  NSDateFormatter *dateFormatter;
@property (assign, nonatomic)  RoadType selectedType;
@property (assign, nonatomic)  BOOL isFemaleOnly;
@property (strong,nonatomic) NSDate *pickupDate;

@property (strong,nonatomic) NSArray *nationalties;
@property (strong,nonatomic) NSArray *languages;
@property (strong,nonatomic) NSArray *ageRanges;

@property (strong,nonatomic) AgeRange *selectedAgeRange;
@property (strong,nonatomic) Nationality *selectedNationality;
@property (strong,nonatomic) Language *selectedLanguage;

@end

@implementation AdvancedSearchViewController

-(NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.selectedType = SingleRideType;
    self.isFemaleOnly = false;
    self.pickupDate = [[NSDate date] dateBySettingHour:10];
    [self configureData];
    [self configureRoadTypeView];
    [self configureGenderView];
    [self configureUI];
}

#pragma Data
- (void) configureData{
    __block AdvancedSearchViewController *blockSelf = self;
    [KVNProgress showWithStatus:@"Loading"];
    [[MasterDataManager sharedMasterDataManager] GetNationalitiesByID:@"0" WithSuccess:^(NSMutableArray *array) {
        blockSelf.nationalties = array;
        [[MasterDataManager sharedMasterDataManager] GetAgeRangesWithSuccess:^(NSMutableArray *array) {
            blockSelf.ageRanges = array;
            [[MasterDataManager sharedMasterDataManager] GetPrefferedLanguagesWithSuccess:^(NSMutableArray *array) {
                [KVNProgress dismiss];
                blockSelf.languages = array;
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
    
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.pickupTitleLabel.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerTopLeft)
                                           cornerRadii:CGSizeMake(5.0, 5.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.pickupTitleLabel.bounds;
    maskLayer.path = maskPath.CGPath;
    self.pickupTitleLabel.layer.mask = maskLayer;
    

    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.dropoffTitleLabel.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerTopLeft)
                                           cornerRadii:CGSizeMake(5.0, 5.0)];
    
    maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.pickupTitleLabel.bounds;
    maskLayer.path = maskPath.CGPath;
    self.dropoffTitleLabel  .layer.mask = maskLayer;
    
    self.dateView.layer.cornerRadius = 10;
    self.dateView.layer.masksToBounds = YES;
    
    self.timeView.layer.cornerRadius = 10;
    self.timeView.layer.masksToBounds = YES;
    
    self.searchButton.layer.cornerRadius = 8;
    
    self.langageTextField.textColor        = Red_UIColor;
    self.nationalityTextField.textColor    = Red_UIColor;
    self.ageRangeTextField.textColor       = Red_UIColor;
    self.langageTextField.textColor        = Red_UIColor;
    self.pickupTitleLabel.backgroundColor  = Red_UIColor;
    self.dropoffTitleLabel.backgroundColor = Red_UIColor;
    self.startPointTextField.textColor     = Red_UIColor;
    self.destinationTextFiled.textColor    = Red_UIColor;
    self.optionalHeader.textColor          =  Red_UIColor;
    self.sepratorLine.backgroundColor      = Red_UIColor;
    
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
}

- (void) configureRoadTypeView{
    switch (self.selectedType) {
        case SingleRideType:
            self.singleRideLabel.textColor = [UIColor add_colorWithRGBHexString:Red_HEX];
            self.periodicLabel.textColor = [UIColor darkGrayColor];
            self.typeSwitchImage.image = [UIImage imageNamed:@"select_Left"];
            break;
        case PeriodicType:
            self.periodicLabel.textColor = [UIColor add_colorWithRGBHexString:Red_HEX];
            self.singleRideLabel.textColor = [UIColor darkGrayColor];
            self.typeSwitchImage.image = [UIImage imageNamed:@"select_Right"];
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

- (IBAction)searchAction:(id)sender {
    
}

#pragma Pickers

- (void) showDatePicker{
    __block AdvancedSearchViewController *blockSelf = self;
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        NSDate *date =  ((UIDatePicker *)controller.contentView).date;
        blockSelf.dateFormatter.dateFormat = @"EEE";
        NSString *day = [self.dateFormatter stringFromDate:date];
        blockSelf.dayLabel.text = day;
        
        blockSelf.dateFormatter.dateFormat = @"dd";
        NSString *dayNumber = [self.dateFormatter stringFromDate:date];
        blockSelf.dayNumberLabel.text = dayNumber;
        
        blockSelf.dateFormatter.dateFormat = @"MMM, yyyy";
        NSString * month = [self.dateFormatter stringFromDate:date];
        blockSelf.monthAndYearLabel.text = month;
        
        NSInteger hour = blockSelf.pickupDate.hour;
        NSInteger minutes = blockSelf.pickupDate.minute;
        
        blockSelf.pickupDate = [[date dateBySettingHour:hour] dateBySettingMinute:minutes];
    }];
    
    //Create cancel action
    RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        
    }];
    
    //Create date selection view controller
    RMDateSelectionViewController *dateSelectionController = [RMDateSelectionViewController actionControllerWithStyle:RMActionControllerStyleWhite selectAction:selectAction andCancelAction:cancelAction];
    dateSelectionController.title = @"select Pickup Date";
    dateSelectionController.datePicker.datePickerMode = UIDatePickerModeDate;
    dateSelectionController.datePicker.date = self.pickupDate;
    
    //Now just present the date selection controller using the standard iOS presentation method
    [self presentViewController:dateSelectionController animated:YES completion:nil];
}

- (void) showTimePicker{
    
    __block AdvancedSearchViewController *blockSelf = self;
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        NSDate *date =  ((UIDatePicker *)controller.contentView).date;
        blockSelf.dateFormatter.dateFormat = @"HH:mm a";
        NSString *time = [self.dateFormatter stringFromDate:date];
        blockSelf.timeLabel.text = time;
        NSInteger hour = date.hour;
        NSInteger minutes = date.minute;
        blockSelf.pickupDate = [blockSelf.pickupDate dateBySettingHour:hour minute:minutes second:0];
    }];
    
    //Create cancel action
    RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {

    }];
    
    //Create date selection view controller
    RMDateSelectionViewController *dateSelectionController = [RMDateSelectionViewController actionControllerWithStyle:RMActionControllerStyleWhite selectAction:selectAction andCancelAction:cancelAction];
    dateSelectionController.title = @"select Pickup Time";
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
            case PickupTextField:
            {
                Nationality *nationality = [self.nationalties objectAtIndex:selectedRow];
                self.nationalityTextField.text = nationality.NationalityArName;
                self.selectedNationality = nationality;
            }
                break;
            case DestinationTextField:
            {
                Nationality *nationality = [self.nationalties objectAtIndex:selectedRow];
                self.nationalityTextField.text = nationality.NationalityArName;
                self.selectedNationality = nationality;
            }
                break;
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
                selectedRow = [self.nationalties indexOfObject:self.selectedAgeRange];
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
        default:
            break;
    }
    
    //Now just present the picker controller using the standard iOS presentation method
    [self presentViewController:pickerController animated:YES completion:nil];
}

#pragma TextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == self.startPointTextField ){
        [self showPickerWithTextFieldType:PickupTextField];
    }
    else if (textField == self.destinationTextFiled){
        [self showPickerWithTextFieldType:DestinationTextField];
    }
    else if (textField == self.nationalityTextField){
        [self showPickerWithTextFieldType:NationalityTextField];
    }
    else if (textField == self.ageRangeTextField){
        [self showPickerWithTextFieldType:AgeRangeTextField];
    }
    else if (textField == self.langageTextField){
        [self showPickerWithTextFieldType:LanguageTextField];
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
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
