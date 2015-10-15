//
//  QuickSearchViewController.m
//  Sharekni
//
//  Created by Ahmed Askar on 10/4/15.
//
//

#import "QuickSearchViewController.h"
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

@interface QuickSearchViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *startPointTextField;
@property (weak, nonatomic) IBOutlet UITextField *destinationTextFiled;
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UILabel *dayNumberLabel;
@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthAndYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UILabel *pickupTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dropoffTitleLabel;

@property (strong,nonatomic) Emirate *fromEmirate;
@property (strong,nonatomic) Emirate *toEmirate;

@property (strong,nonatomic) Region *fromRegion;
@property (strong,nonatomic) Region *toRegion;

@property (strong, nonatomic)  NSDateFormatter *dateFormatter;
@property (strong,nonatomic) NSDate *pickupDate;
@end

@implementation QuickSearchViewController

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
    
    self.pickupDate = [[NSDate date] dateBySettingHour:10];
    [self configureUI];
    self.startPointTextField.delegate = self;
    self.destinationTextFiled.delegate = self;
}

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
    
    self.pickupTitleLabel.backgroundColor  = Red_UIColor;
    self.dropoffTitleLabel.backgroundColor = Red_UIColor;
    self.startPointTextField.textColor     = Red_UIColor;
    self.destinationTextFiled.textColor    = Red_UIColor;
    
    UITapGestureRecognizer *dateTapGestureRecognizer  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDatePicker)];
    [self.dateView addGestureRecognizer:dateTapGestureRecognizer];
    
    UITapGestureRecognizer *TimeTapGestureRecognizer  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTimePicker)];
    [self.timeView addGestureRecognizer:TimeTapGestureRecognizer];
    
}

#pragma Pickers

- (void) showDatePicker{
    __block QuickSearchViewController  *blockSelf = self;
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
    
    __block QuickSearchViewController *blockSelf = self;
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

- (void) showLocationPickerWithTextFieldType:(TextFieldType)type{
    SelectLocationViewController *selectLocationViewController = [[SelectLocationViewController alloc] initWithNibName:@"SelectLocationViewController" bundle:nil];
    selectLocationViewController.viewTitle = type == PickupTextField ? NSLocalizedString(@"Select pickup point", Nil): NSLocalizedString(@"Select destionation point", nil);
    __block QuickSearchViewController *blockSelf = self;
    [selectLocationViewController setSelectionHandler:^(Emirate *selectedEmirate, Region *selectedRegion) {
        NSString *text = [NSString stringWithFormat:@"%@,%@",selectedEmirate.EmirateArName,selectedRegion.RegionArName];
        if (type == PickupTextField) {
            blockSelf.fromEmirate = selectedEmirate;
            blockSelf.fromRegion = selectedRegion;
            blockSelf.startPointTextField.text = text;
        }
        else if (type == DestinationTextField){
            blockSelf.toEmirate = selectedEmirate;
            blockSelf.toRegion = selectedRegion;
            blockSelf.destinationTextFiled.text = text;
        }
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
    if(textField == self.startPointTextField ){
        [self showLocationPickerWithTextFieldType:PickupTextField];
    }
    else if (textField == self.destinationTextFiled){
        [self showLocationPickerWithTextFieldType:DestinationTextField];
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

- (IBAction)searchAction:(id)sender {
    if (!self.fromEmirate) {
        [[HelpManager sharedHelpManager] showToastWithMessage:NSLocalizedString(@"Please select start point ",nil)];
    }
    else if (!self.toEmirate){
        [[HelpManager sharedHelpManager] showToastWithMessage:NSLocalizedString(@"Please select destination ",nil)];
    }
    else{

    }
}


- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
