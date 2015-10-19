//
//  RegisterViewController.m
//  Sharekni
//
//  Created by Ahmed Askar on 9/25/15.
//
//

#import "RegisterViewController.h"
#import "Constants.h"
#import <UIColor+Additions/UIColor+Additions.h>
#import <RMActionController.h>
#import <RMPickerViewController.h>
#import "Nationality.h"
#import "Language.h"
#import "HelpManager.h"
#import <RMDateSelectionViewController.h>
#import "MasterDataManager.h"
#import <KVNProgress.h>
#import "NSObject+Blocks.h"
#import "MobAccountManager.h"
@interface RegisterViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    __weak IBOutlet UIScrollView *container;
    __weak IBOutlet UIButton *driverBtn;
    __weak IBOutlet UIButton *passengerBtn;
    __weak IBOutlet UIButton *bothBtn;
    __weak IBOutlet UITextField *firstNametxt;
    __weak IBOutlet UITextField *lastNametxt;
    __weak IBOutlet UITextField *mobileNumberTxt;
    __weak IBOutlet UITextField *usernameTxt;
    __weak IBOutlet UITextField *passwordTxt;
    __weak IBOutlet UITextField *nationalityTxt;
    __weak IBOutlet UITextField *preferredLanguageTxt;
    __weak IBOutlet UILabel *dateLbl;
    __weak IBOutlet UIView *datePickerView;
    __weak IBOutlet UIButton *switchBtn;
    
    __weak IBOutlet UILabel *driverLbl;
    __weak IBOutlet UILabel *passengerLbl;
    __weak IBOutlet UILabel *bothLbl;

    __weak IBOutlet UILabel *femaleLabel;
    
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UILabel *maleLabel;
    float animatedDistance ;
}

@property (strong,nonatomic) NSArray *nationalties;
@property (strong,nonatomic) NSArray *languages;

@property (strong,nonatomic) Nationality *selectedNationality;
@property (strong,nonatomic) Language *selectedLanguage;
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *password;
@property (strong,nonatomic) NSString *firstName;
@property (strong,nonatomic) NSString *lastName;
@property (strong,nonatomic) NSString *mobileNumber;
@property (strong,nonatomic) NSDate *date;
@property (strong,nonatomic) NSDateFormatter *dateFormatter;
@property (assign,nonatomic) BOOL isMale;
@property (assign,nonatomic) AccountType accountType;
@end

@implementation RegisterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = NO ;
    
    self.title = NSLocalizedString(@"registration", nil);
    
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
   
    [self configureUI];
    [self configureData];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configureUI
{
    
    dateLabel.textColor = [UIColor blackColor];
    
    [container setContentSize:CGSizeMake(self.view.frame.size.width, 700)];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setDatePicker)];
    [datePickerView addGestureRecognizer:gesture];
    [dateLbl addGestureRecognizer:gesture];
    [dateLbl setUserInteractionEnabled:YES];
    [datePickerView setUserInteractionEnabled:YES];
    
    [driverBtn    setBackgroundImage:[UIImage imageNamed:@"DriverUnActive"]    forState:UIControlStateNormal];
    [driverBtn    setBackgroundImage:[UIImage imageNamed:@"DriverActive"]      forState:UIControlStateSelected];
    [driverBtn    setSelected:NO];
   
    [passengerBtn setBackgroundImage:[UIImage imageNamed:@"PassengerUnActive"] forState:UIControlStateNormal];
    [passengerBtn setBackgroundImage:[UIImage imageNamed:@"PassengerActive"]   forState:UIControlStateSelected];
    [passengerBtn    setSelected:NO];

    [bothBtn      setBackgroundImage:[UIImage imageNamed:@"BothUnActive"]      forState:UIControlStateNormal];
    [bothBtn      setBackgroundImage:[UIImage imageNamed:@"BothActive"]        forState:UIControlStateSelected];
    [bothBtn    setSelected:NO];

    [switchBtn    setBackgroundImage:[UIImage imageNamed:@"select_Left"]       forState:UIControlStateNormal];
    [switchBtn    setBackgroundImage:[UIImage imageNamed:@"select_Right"]      forState:UIControlStateSelected];
    [switchBtn    setSelected:NO];
    
    maleLabel.textColor = Red_UIColor;
    femaleLabel.textColor = [UIColor darkGrayColor];
    

    if ([firstNametxt respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor add_colorWithRGBHexString:Red_HEX];
        firstNametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"firstName",nil) attributes:@{NSForegroundColorAttributeName: color}];
        lastNametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"lastName", nil) attributes:@{NSForegroundColorAttributeName: color}];
        mobileNumberTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"mobile", nil) attributes:@{NSForegroundColorAttributeName: color}];
        usernameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"username", nil) attributes:@{NSForegroundColorAttributeName: color}];
        passwordTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"password", nil) attributes:@{NSForegroundColorAttributeName: color}];
        nationalityTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"nationality", nil) attributes:@{NSForegroundColorAttributeName: color}];
        preferredLanguageTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"pLanguage", nil) attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
}

- (void) configureData{
    __block RegisterViewController*blockSelf = self;
    [[MasterDataManager sharedMasterDataManager] GetNationalitiesByID:@"0" WithSuccess:^(NSMutableArray *array) {
        blockSelf.nationalties = array;
        [[MasterDataManager sharedMasterDataManager] GetPrefferedLanguagesWithSuccess:^(NSMutableArray *array) {
            [KVNProgress dismiss];
            blockSelf.languages = array;
        } Failure:^(NSString *error) {
            [blockSelf handleManagerFailure];
        }];
    } Failure:^(NSString *error) {
        [blockSelf handleManagerFailure];
    }];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
}

- (void) handleManagerFailure{
    [KVNProgress dismiss];
    [KVNProgress showErrorWithStatus:@"Error"];
    [self performBlock:^{
        [KVNProgress dismiss];
    } afterDelay:3];
}

#pragma mark - Event Handlers
- (IBAction)selectHumanType:(id)sender
{
    switch ([sender tag]) {
        case 0:
            [driverBtn    setSelected:YES];
            [passengerBtn setSelected:NO];
            [bothBtn    setSelected:NO];
            driverLbl.textColor = [UIColor whiteColor];
            passengerLbl.textColor = [UIColor darkGrayColor];
            bothLbl.textColor = [UIColor darkGrayColor];
            self.accountType = AccountTypeDriver;
            break;
        case 1:
            [passengerBtn setSelected:YES];
            [driverBtn    setSelected:NO];
            [bothBtn    setSelected:NO];
            driverLbl.textColor = [UIColor darkGrayColor];
            passengerLbl.textColor = [UIColor whiteColor];
            bothLbl.textColor = [UIColor darkGrayColor];
            self.accountType = AccountTypePassenger;
            break;
        case 2:
            [driverBtn    setSelected:NO];
            [passengerBtn setSelected:NO];
            [bothBtn    setSelected:YES];
            driverLbl.textColor = [UIColor darkGrayColor];
            passengerLbl.textColor = [UIColor darkGrayColor];
            bothLbl.textColor = [UIColor whiteColor];
            self.accountType = AccountTypeBoth;
            break;
        default:
            break;
    }
}

- (IBAction)selectGender:(id)sender
{
    UIButton *btn = (UIButton*)sender ;
    
    if (btn.selected)
    {
        switchBtn.selected = NO ;
        maleLabel.textColor = Red_UIColor;
        femaleLabel.textColor = [UIColor darkGrayColor];
        self.isMale = YES;
    }else{
        self.isMale = NO;
        switchBtn.selected = YES ;
        maleLabel.textColor =  [UIColor darkGrayColor];
        femaleLabel.textColor = Red_UIColor;;
    }
}

- (void)setDatePicker
{
    
    [self.view endEditing:YES];
    __block RegisterViewController *blockSelf = self;
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        NSDate *date =  ((UIDatePicker *)controller.contentView).date;
        
        blockSelf.dateFormatter.dateFormat = @"dd, MMM, yyyy";
        NSString * dateString = [self.dateFormatter stringFromDate:date];
        dateLabel.text = dateString;
        blockSelf.date = date;
    }];
    
    //Create cancel action
    RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        
    }];
    
    //Create date selection view controller
    RMDateSelectionViewController *dateSelectionController = [RMDateSelectionViewController actionControllerWithStyle:RMActionControllerStyleWhite selectAction:selectAction andCancelAction:cancelAction];
    dateSelectionController.title = @"select date of birth";
    dateSelectionController.datePicker.datePickerMode = UIDatePickerModeDate;
    dateSelectionController.datePicker.date = [NSDate date];
    
    //Now just present the date selection controller using the standard iOS presentation method
    [self presentViewController:dateSelectionController animated:YES completion:nil];
}

#pragma TextFieldDelegate
#pragma mark - TextFieldDelegate

// This code handles the scrolling when tabbing through infput fields
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 220;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 140;
//when clicking the return button in the keybaord
- (BOOL)textFieldShouldEndEditing:(UITextField*)textField
{
    return [self textSouldEndEditing];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField  resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    [self textDidBeginEditing:textFieldRect];
}

- (void)textDidBeginEditing:(CGRect)textRect
{
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textRect.origin.y + 0.5 * textRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}

- (BOOL)textSouldEndEditing
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView* view in self.view.subviews) {
        for (UIGestureRecognizer* recognizer in view.gestureRecognizers) {
            [recognizer addTarget:self action:@selector(touchEvent:)];
        }
        
        [self.view endEditing:YES];
    }
}

- (void)touchEvent:(id)sender
{
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.view endEditing:YES];
    if (textField == nationalityTxt){
        [self showPickerWithTextFieldType:NationalityTextField];
    }
    else if (textField == preferredLanguageTxt){
        [self showPickerWithTextFieldType:LanguageTextField];
    }
    else{
        return YES;
    }
    return NO;
}

- (void) showPickerWithTextFieldType:(TextFieldType)type{
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        UIPickerView *picker = ((RMPickerViewController *)controller).picker;
        NSInteger selectedRow = [picker selectedRowInComponent:0];
        switch (picker.tag) {
            case NationalityTextField:
            {
                Nationality *nationality = [self.nationalties objectAtIndex:selectedRow];
                nationalityTxt.text = nationality.NationalityArName;
                self.selectedNationality = nationality;
            }
                break;
            case LanguageTextField:
            {
                Language *language = [self.languages objectAtIndex:selectedRow];
                preferredLanguageTxt.text = language.LanguageArName;
                self.selectedLanguage = language;
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
        default:
            break;
    }
    //Now just present the picker controller using the standard iOS presentation method
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (IBAction)registerAction:(id)sender {
    self.userName = usernameTxt.text;
    self.password = passwordTxt.text;
    self.firstName = firstNametxt.text;
    self.lastName = lastNametxt.text;
    self.mobileNumber = mobileNumberTxt.text;
    if(self.firstName.length == 0){
        [[HelpManager sharedHelpManager] showToastWithMessage:NSLocalizedString(@"Please enter your first name.",nil)];
    }
    else if(self.lastName.length == 0){
        [[HelpManager sharedHelpManager] showToastWithMessage:NSLocalizedString(@"Please enter your last name.",nil)];
    }
    else if(self.userName.length == 0){
        [[HelpManager sharedHelpManager] showToastWithMessage:NSLocalizedString(@"Please enter your username.",nil)];
    }
    else if(self.password.length == 0){
        [[HelpManager sharedHelpManager] showToastWithMessage:NSLocalizedString(@"Please enter your password. ",nil)];
    }
    else if(self.mobileNumber.length == 0){
        [[HelpManager sharedHelpManager] showToastWithMessage:NSLocalizedString(@"Please enter your mobile number. ",nil)];
    }
    else if (!self.selectedNationality){
        [[HelpManager sharedHelpManager] showToastWithMessage:NSLocalizedString(@"Please select nationality. ",nil)];
    }
    else if (!self.selectedLanguage){
        [[HelpManager sharedHelpManager] showToastWithMessage:NSLocalizedString(@"Please select your preferred language. ",nil)];
    }
    else if (!self.date){
        [[HelpManager sharedHelpManager] showToastWithMessage:NSLocalizedString(@"Please select your date of birth. ",nil)];
    }
    else{
        self.dateFormatter.dateFormat = @"dd/MM/yyyy";
        NSString *dateString = [self.dateFormatter stringFromDate:self.date];
        [KVNProgress showWithStatus:@"Loading..."];
     [[MobAccountManager sharedMobAccountManager] registerPassengerWithFirstName:self.firstName lastName:self.lastName mobile:self.mobileNumber username:self.userName password:self.password gender:self.isMale ? @"M":@"F" imagePath:nil birthDate:dateString nationalityID:self.selectedNationality.ID PreferredLanguageId:self.selectedLanguage.LanguageId WithSuccess:^(NSMutableArray *array) {
         [KVNProgress dismiss];
        [[HelpManager sharedHelpManager] showToastWithMessage:NSLocalizedString(@"Registeration Compeleted. ",nil)];
     } Failure:^(NSString *error) {
         [KVNProgress dismiss];
        [[HelpManager sharedHelpManager] showToastWithMessage:NSLocalizedString(@"Registeration Failed. ",nil)];
     }];
    }
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
