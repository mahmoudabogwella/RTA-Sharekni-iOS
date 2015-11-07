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
#import <KLCPopup/KLCPopup.h>
#import "PickupLocationView.h"
#import <MZFormSheetController.h>
#import "SelectLocationViewController.h"
#import "MobDriverManager.h"
#import "HelpManager.h"
#import "SearchResultsViewController.h"
#import "MobDriverManager.h"
#import "MLPAutoCompleteTextField.h"
#import "MLPAutoCompleteTextFieldDataSource.h"
#import "MLPAutoCompleteTextFieldDelegate.h"

@interface AdvancedSearchViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,MLPAutoCompleteTextFieldDelegate,MLPAutoCompleteTextFieldDataSource>
//Outlets
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView ;

@property (weak, nonatomic) IBOutlet UIButton *setDirectionBtuton;
@property (weak, nonatomic) IBOutlet UIButton *languageButton;
@property (weak, nonatomic) IBOutlet UIButton *ageRangeButton;

@property (weak, nonatomic) IBOutlet UITextField *startPointTextField;
@property (weak, nonatomic) IBOutlet UITextField *destinationTextFiled;


@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet MLPAutoCompleteTextField *nationalityTextField;

@property (weak, nonatomic) IBOutlet UIView *typeView;

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
@property (strong,nonatomic) NSMutableArray *nationaltiesStringsArray;
@property (strong,nonatomic) NSArray *languages;
@property (strong,nonatomic) NSArray *ageRanges;

@property (strong,nonatomic) AgeRange *selectedAgeRange;
@property (strong,nonatomic) Nationality *selectedNationality;
@property (strong,nonatomic) Language *selectedLanguage;

@property (strong,nonatomic) Emirate *fromEmirate;
@property (strong,nonatomic) Emirate *toEmirate;

@property (strong,nonatomic) Region *fromRegion;
@property (strong,nonatomic) Region *toRegion;

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
 
    self.title = NSLocalizedString(@"advancedSearch", nil);
    
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 660)];
    self.selectedType = SingleRideType;
    self.isFemaleOnly = false;
    self.pickupDate = [[NSDate date] dateBySettingHour:10];
    [self configureData];
    [self configureRoadTypeView];
    [self configureGenderView];
    [self configureUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma Data
- (void) configureData{
    __block AdvancedSearchViewController *blockSelf = self;
    [KVNProgress showWithStatus:@"Loading"];
    [[MasterDataManager sharedMasterDataManager] GetNationalitiesByID:@"0" WithSuccess:^(NSMutableArray *array) {
        blockSelf.nationalties = array;
        blockSelf.nationaltiesStringsArray = [NSMutableArray array];
        for (Nationality *nationality in array) {
            [blockSelf.nationaltiesStringsArray addObject:nationality.NationalityEnName];
        }
        [[MasterDataManager sharedMasterDataManager] GetAgeRangesWithSuccess:^(NSMutableArray *array) {
            blockSelf.ageRanges = array;
            [[MasterDataManager sharedMasterDataManager] GetPrefferedLanguagesWithSuccess:^(NSMutableArray *array) {
                [KVNProgress dismiss];
                blockSelf.languages = array;
                [[MasterDataManager sharedMasterDataManager] GetEmiratesWithSuccess:^(NSMutableArray *array) {
                    
                } Failure:^(NSString *error) {
                    
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
    
    [self.setDirectionBtuton setBackgroundColor:Red_UIColor];
    self.setDirectionBtuton.layer.cornerRadius = 10;
    [self.setDirectionBtuton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.setDirectionBtuton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.setDirectionBtuton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [self.languageButton setBackgroundColor:[UIColor whiteColor]];
    self.languageButton.layer.cornerRadius = 10;
    [self.languageButton setTitleColor:Red_UIColor forState:UIControlStateNormal];
    [self.languageButton setTitleColor:Red_UIColor forState:UIControlStateHighlighted];
    [self.languageButton setTitleColor:Red_UIColor forState:UIControlStateSelected];
    self.languageButton.layer.borderWidth = .8;
    self.languageButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    [self.ageRangeButton setBackgroundColor:[UIColor whiteColor]];
    self.ageRangeButton.layer.cornerRadius = 10;
    [self.ageRangeButton setTitleColor:Red_UIColor forState:UIControlStateNormal];
    [self.ageRangeButton setTitleColor:Red_UIColor forState:UIControlStateHighlighted];
    [self.ageRangeButton setTitleColor:Red_UIColor forState:UIControlStateSelected];
    self.ageRangeButton.layer.borderWidth = .8;
    self.ageRangeButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
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
    
    self.dateView.layer.cornerRadius = 8;
    self.dateView.layer.borderWidth = 0;
    self.dateView.layer.borderColor = Red_UIColor.CGColor;
    self.dateView.layer.masksToBounds = YES;
    
    
    self.timeView.layer.cornerRadius = 8;
    self.timeView.layer.borderWidth = 0;
    self.timeView.layer.borderColor = [UIColor blackColor].CGColor;
    self.timeView.layer.masksToBounds = YES;
    
    self.searchButton.layer.cornerRadius = 8;
    
    self.nationalityTextField.textColor    = Red_UIColor;
    self.pickupTitleLabel.backgroundColor  = Red_UIColor;
    self.dropoffTitleLabel.backgroundColor = Red_UIColor;
    self.startPointTextField.textColor     = Red_UIColor;
    self.destinationTextFiled.textColor    = Red_UIColor;
    self.optionalHeader.textColor          =  Red_UIColor;
    self.sepratorLine.backgroundColor      = Red_UIColor;
    self.dateLabel.textColor = Red_UIColor;
    self.timeLabel.textColor = Red_UIColor;
    self.dateLabel.textColor = Red_UIColor;
    self.timeLabel.textColor = Red_UIColor;
    
    
    self.dateLabel.text = NSLocalizedString(@"Starting when", nil);
    self.timeLabel.text = NSLocalizedString(@"schedule on", nil);
    
    [self.languageButton setTitle:NSLocalizedString(@"Choose a language", nil) forState:UIControlStateNormal];
    [self.ageRangeButton setTitle:NSLocalizedString(@"Choose age range", nil) forState:UIControlStateNormal];
    
    
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
    
    self.nationalityTextField.delegate = self;
    self.nationalityTextField.autoCompleteDataSource = self;
    self.nationalityTextField.autoCompleteDelegate = self;
    self.nationalityTextField.autoCompleteTableBorderColor = Red_UIColor;
    self.nationalityTextField.autoCompleteTableBorderWidth = 2;
    self.nationalityTextField.autoCompleteTableBackgroundColor = [UIColor whiteColor];
    self.nationalityTextField.autoCompleteTableAppearsAsKeyboardAccessory = YES;
    [self.nationalityTextField setTintColor:Red_UIColor];
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
    if (!self.fromEmirate) {
          [[HelpManager sharedHelpManager] showToastWithMessage:NSLocalizedString(@"Please select start point ",nil)];
    }
    else if (!self.toEmirate){
         [[HelpManager sharedHelpManager] showToastWithMessage:NSLocalizedString(@"Please select destination ",nil)];
    }
    else{
        __block AdvancedSearchViewController *blockSelf = self;
        [KVNProgress showWithStatus:@"Loading..."];
        [[MobDriverManager sharedMobDriverManager] findRidesFromEmirate:self.fromEmirate andFromRegion:self.fromRegion toEmirate:self.toEmirate andToRegion:self.toRegion PerfferedLanguage:self.selectedLanguage nationality:self.selectedNationality ageRange:self.selectedAgeRange date:self.pickupDate isPeriodic:(self.selectedType == PeriodicType) ? YES : NO WithSuccess:^(NSArray *searchResults) {
            [KVNProgress dismiss];
            if(searchResults){
                SearchResultsViewController *resultViewController = [[SearchResultsViewController alloc] initWithNibName:@"SearchResultsViewController" bundle:nil];
                resultViewController.results = searchResults;
                resultViewController.fromEmirate = blockSelf.fromEmirate;
                resultViewController.toEmirate = blockSelf.toEmirate;
                resultViewController.fromRegion = blockSelf.fromRegion;
                resultViewController.toRegion = blockSelf.toRegion;
                [blockSelf.navigationController pushViewController:resultViewController animated:YES];
            }
            else{
                [[HelpManager sharedHelpManager] showToastWithMessage:NSLocalizedString(@"No Rides Found ",nil)];
            }
        } Failure:^(NSString *error) {
            [KVNProgress dismiss];            
        }];
    }
}

#pragma Pickers

- (void) showDatePicker{
    __block AdvancedSearchViewController *blockSelf = self;
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        NSDate *date =  ((UIDatePicker *)controller.contentView).date;
        blockSelf.dateFormatter.dateFormat = @"EEE,  dd/MM/yyyy";
        NSString *dateString = [self.dateFormatter stringFromDate:date];
        blockSelf.dateLabel.text = dateString;
        
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
                [self.languageButton setTitle:language.LanguageEnName forState:UIControlStateNormal];
                self.selectedLanguage = language;
            }
            break;
            case AgeRangeTextField:
            {
                AgeRange *range = [self.ageRanges objectAtIndex:selectedRow];
                [self.ageRangeButton setTitle:range.Range forState:UIControlStateNormal];
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
        default:
            break;
    }
    //Now just present the picker controller using the standard iOS presentation method
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (void) showLocationPicker{
    SelectLocationViewController *selectLocationViewController = [[SelectLocationViewController alloc] initWithNibName:@"SelectLocationViewController" bundle:nil];
    __block AdvancedSearchViewController *blockSelf = self;
    [selectLocationViewController setSelectionHandler:^(Emirate *fromEmirate, Region *fromRegion,Emirate *toEmirate, Region *toRegion) {
        
        NSString *fromText = [NSString stringWithFormat:@"%@,%@",fromEmirate.EmirateEnName,fromRegion.RegionEnName];
        
            blockSelf.fromEmirate = fromEmirate;
            blockSelf.fromRegion = fromRegion;
            blockSelf.startPointTextField.text = fromText;
        
            NSString *toText = [NSString stringWithFormat:@"%@,%@",toEmirate.EmirateEnName,toRegion.RegionEnName];
            blockSelf.toEmirate = toEmirate;
            blockSelf.toRegion = toRegion;
            blockSelf.destinationTextFiled.text = toText;
    }];
    [self.navigationController pushViewController:selectLocationViewController animated:YES];
//    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:selectLocationViewController];
//    
//    formSheet.formSheetWindow.transparentTouchEnabled = NO;
//    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromTop;
//    formSheet.shouldDismissOnBackgroundViewTap = YES;
//    formSheet.shouldCenterVertically = NO;
//    formSheet.presentedFormSheetSize = CGSizeMake(300, 200);
//    formSheet.portraitTopInset = 55;
//    formSheet.cornerRadius = 8;
//    
//    [formSheet presentAnimated:YES completionHandler:^(UIViewController *presentedFSViewController) {
//        
//    }];
}

#pragma TextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == self.startPointTextField && textField.text.length == 0){
        [self showLocationPicker];
    }
    else if (textField == self.destinationTextFiled && textField.text.length == 0){
        [self showLocationPicker];
    }
    else if (textField == self.nationalityTextField){
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
- (IBAction)setDirectionButtonHandler:(id)sender {
    [self showLocationPicker];
}
- (IBAction)ageRangeButtonHandler:(id)sender {
    [self showPickerWithTextFieldType:AgeRangeTextField];
}
- (IBAction)languageButtonHandler:(id)sender {
    [self showPickerWithTextFieldType:LanguageTextField];
}

#pragma AutoCompelete_Delegate
- (BOOL)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
shouldStyleAutoCompleteTableView:(UITableView *)autoCompleteTableView
               forBorderStyle:(UITextBorderStyle)borderStyle{
    return YES;
}

- (NSArray *)autoCompleteTextField:(MLPAutoCompleteTextField *)textField      possibleCompletionsForString:(NSString *)string{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",string]; // if you need case sensitive search avoid '[c]' in the predicate
    NSArray *results = [self.nationaltiesStringsArray filteredArrayUsingPredicate:predicate];
    return results;
}

@end
