//
//  SearchViewController.m
//  Sharekni
//
//  Created by Ahmed Askar on 10/4/15.
//
//

#import "SearchViewController.h"
#import "QuickSearchViewController.h"
#import "AdvancedSearchViewController.h"
#import "MostRidesViewController.h"
#import "MapLookupViewController.h"
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

@interface SearchViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *startPointTextField;
@property (weak, nonatomic) IBOutlet UITextField *destinationTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UILabel *pickupTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dropoffTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UILabel *saveSearchLabel;
@property (weak, nonatomic) IBOutlet UIImageView *SwitchImage;
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UIButton *advancedSearchBG;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *saveSearchView;

@property (strong,nonatomic) Emirate *fromEmirate;
@property (strong,nonatomic) Emirate *toEmirate;

@property (strong,nonatomic) Region *fromRegion;
@property (strong,nonatomic) Region *toRegion;

@property (nonatomic,assign) BOOL saveSearchEnabled;

@property (strong, nonatomic)  NSDateFormatter *dateFormatter;
@property (strong,nonatomic) NSDate *pickupDate;
@end

@implementation SearchViewController

-(NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"searchOptions", nil);
    self.navigationController.navigationBarHidden = NO ;
    self.pickupDate = [[NSDate date] dateBySettingHour:10];
    self.startPointTextField.delegate = self;
    self.destinationTextFiled.delegate = self;
    [self configureUI];
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
    
    self.dateView.layer.cornerRadius = 8;
    self.dateView.layer.borderWidth = 0;
    self.dateView.layer.borderColor = Red_UIColor.CGColor;
    self.dateView.layer.masksToBounds = YES;
    
    
    self.timeView.layer.cornerRadius = 8;
    self.timeView.layer.borderWidth = 0;
    self.timeView.layer.borderColor = [UIColor blackColor].CGColor;
    self.timeView.layer.masksToBounds = YES;
    
    self.saveSearchView.layer.cornerRadius = 10;
    self.saveSearchView.layer.borderWidth = 0;
    self.saveSearchView.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.searchButton.layer.cornerRadius = 8;
    
    self.pickupTitleLabel.backgroundColor  = Red_UIColor;
    self.dropoffTitleLabel.backgroundColor = Red_UIColor;
    self.startPointTextField.textColor     = Red_UIColor;
    self.destinationTextFiled.textColor    = Red_UIColor;
    
    self.dateLabel.textColor = Red_UIColor;
    self.timeLabel.textColor = Red_UIColor;
    self.dateLabel.text = NSLocalizedString(@"Starting when", nil);
    self.timeLabel.text = NSLocalizedString(@"schedule on", nil);
    
    [self.searchButton setBackgroundColor:Red_UIColor];
    
    
    [self.view sendSubviewToBack:self.advancedSearchBG];
    [self.view sendSubviewToBack:self.background];

    UITapGestureRecognizer *saveSearchTapGestureRecognizer  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveSearchViewTapped)];
    [self.saveSearchView addGestureRecognizer:saveSearchTapGestureRecognizer];
    
    UITapGestureRecognizer *dateTapGestureRecognizer  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDatePicker)];
    [self.dateView addGestureRecognizer:dateTapGestureRecognizer];
    
    UITapGestureRecognizer *TimeTapGestureRecognizer  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTimePicker)];
    [self.timeView addGestureRecognizer:TimeTapGestureRecognizer];
}

- (void) saveSearchViewTapped{
    self.saveSearchEnabled = !self.saveSearchEnabled;
    if (self.saveSearchEnabled) {
        self.saveSearchLabel.textColor = Red_UIColor;
        self.SwitchImage.image = [UIImage imageNamed:@"select_Right"];
    }
    else{
        self.saveSearchLabel.textColor = [UIColor blackColor];
        self.SwitchImage.image = [UIImage imageNamed:@"select_Left"];
    }
}

#pragma Pickers

- (void) showDatePicker{
    __block SearchViewController  *blockSelf = self;
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        NSDate *date =  ((UIDatePicker *)controller.contentView).date;
        blockSelf.dateFormatter.dateFormat = @"dd/MM/yyyy";
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
    
    __block SearchViewController *blockSelf = self;
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

- (void) showLocationPickerWithTextFieldType:(TextFieldType)type{
    SelectLocationViewController *selectLocationViewController = [[SelectLocationViewController alloc] initWithNibName:@"SelectLocationViewController" bundle:nil];
    selectLocationViewController.viewTitle = type == PickupTextField ? NSLocalizedString(@"Select pickup point", Nil): NSLocalizedString(@"Select destionation point", nil);
    __block SearchViewController *blockSelf = self;
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

- (IBAction)quickSearchAction:(id)sender {
    if (!self.fromEmirate) {
        [[HelpManager sharedHelpManager] showToastWithMessage:NSLocalizedString(@"Please select start point ",nil)];
    }
    else if (!self.toEmirate){
        [[HelpManager sharedHelpManager] showToastWithMessage:NSLocalizedString(@"Please select destination ",nil)];
    }
    else{
        __block SearchViewController *blockSelf = self;
        [KVNProgress showWithStatus:@"Loading..."];
        [[MobDriverManager sharedMobDriverManager] findRidesFromEmirate:self.fromEmirate andFromRegion:self.fromRegion toEmirate:self.toEmirate andToRegion:self.toRegion PerfferedLanguage:nil nationality:nil ageRange:nil date:self.pickupDate isPeriodic:YES WithSuccess:^(NSArray *searchResults) {
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


- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)advancedSearch:(id)sender
{
    AdvancedSearchViewController *advancedSearchView = [[AdvancedSearchViewController alloc] initWithNibName:@"AdvancedSearchViewController" bundle:nil];
    [self.navigationController pushViewController:advancedSearchView animated:YES];
}

- (IBAction)mapLookUp:(id)sender {
    MapLookupViewController *mapLookupViewController = [[MapLookupViewController alloc] initWithNibName:@"MapLookupViewController" bundle:nil];
    [self.navigationController pushViewController:mapLookupViewController animated:YES];
}

- (IBAction)topRides:(id)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MostRidesViewController *mostRides = [storyboard instantiateViewControllerWithIdentifier:@"MostRidesViewController"];
    mostRides.enableBackButton = YES;
    [self.navigationController pushViewController:mostRides animated:YES];
}

@end
