//
//  EditProfileViewController.m
//  sharekni
//
//  Created by Ahmed Askar on 12/11/15.
//
//

#import "EditProfileViewController.h"
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
#import "HomeViewController.h"
#import "SharekniWebViewController.h"
#import "MLPAutoCompleteTextField.h"
#import <REFrostedViewController.h>
#import "SideMenuTableViewController.h"
#import "UploadImageManager.h"

@interface EditProfileViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,MLPAutoCompleteTextFieldDataSource,MLPAutoCompleteTextFieldDelegate,REFrostedViewControllerDelegate,UITextFieldDelegate>


@property (weak,nonatomic)  IBOutlet UIScrollView *container;
@property (weak,nonatomic)  IBOutlet UITextField *firstNametxt;
@property (weak,nonatomic)  IBOutlet UITextField *lastNametxt;
@property (weak,nonatomic)  IBOutlet UITextField *mobileNumberTxt;
@property (weak,nonatomic)  IBOutlet UITextField *usernameTxt;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak,nonatomic) IBOutlet MLPAutoCompleteTextField *nationalityTxt;
@property (weak,nonatomic) IBOutlet UITextField *preferredLanguageTxt;

//@property (weak,nonatomic) IBOutlet UIView *datePickerView;
@property (weak,nonatomic) IBOutlet UIButton *switchBtn;

@property (weak,nonatomic) IBOutlet UILabel *femaleLabel;
//@property (weak,nonatomic) IBOutlet UILabel *dateLabel;
@property (weak,nonatomic) IBOutlet UILabel *maleLabel;
@property (nonatomic,assign) float animatedDistance ;

@property (weak, nonatomic) IBOutlet UIView *firstNameView;
@property (weak, nonatomic) IBOutlet UIView *lastNameView;
@property (weak, nonatomic) IBOutlet UIView *mobileNumberView;
@property (weak, nonatomic) IBOutlet UIView *userNameView;
@property (weak, nonatomic) IBOutlet UIView *nationalityView;
@property (weak, nonatomic) IBOutlet UIView *languageView;

@property (strong,nonatomic) NSArray *nationalties;
@property (nonatomic,strong) NSMutableArray *nationaltiesStringsArray;

@property (strong,nonatomic) NSArray *languages;
@property (strong,nonatomic) Nationality *selectedNationality;
@property (strong,nonatomic) Language *selectedLanguage;
@property (strong,nonatomic) NSString *firstName;
@property (strong,nonatomic) NSString *lastName;
@property (strong,nonatomic) NSString *mobileNumber ;
@property (strong,nonatomic) NSString *NationalitySub ;

//GonLang
@property (weak, nonatomic) IBOutlet UIButton *Lupdate;


//
//@property (strong,nonatomic) NSDate *date;
//@property (strong,nonatomic) NSDateFormatter *dateFormatter;
@property (assign,nonatomic) BOOL isMale;

@property (nonatomic,strong) User *sharedUser;


@property (strong,nonatomic) UIImage *profileImage;

@end

@implementation EditProfileViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = NO ;
    
    self.title = GET_STRING(@"Edit Profile");
    
    self.maleLabel.text = GET_STRING(@"Male");
    self.femaleLabel.text = GET_STRING(@"Female");
    [_Lupdate setTitle:GET_STRING(@"Update") forState:UIControlStateNormal];
    self.Lupdate.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    
    
    [self configureUI];
    [self configureData];
    [self configrueNationalityAutoCompelete];
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

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void) popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma Data

- (void) configureUI
{
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileImageView.layer.borderWidth = 0.5f;
    self.profileImageView.clipsToBounds = YES;
    
    
//    self.dateLabel.textColor = [UIColor blackColor];

//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDatePicker)];
   // [self.datePickerView addGestureRecognizer:gesture];
   // [self.dateLabel addGestureRecognizer:gesture];
  //  [self.dateLabel setUserInteractionEnabled:YES];
   // [self.datePickerView setUserInteractionEnabled:YES];
    
//    [self.switchBtn    setBackgroundImage:[UIImage imageNamed:@"select_Left"]       forState:UIControlStateNormal];
//    [self.switchBtn    setBackgroundImage:[UIImage imageNamed:@"select_Right"]      forState:UIControlStateSelected];
    
    self.maleLabel.textColor = Red_UIColor;
    self.femaleLabel.textColor = [UIColor darkGrayColor];
    self.maleLabel.userInteractionEnabled = YES;
    self.femaleLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *maleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maleTapped)];
    [self.maleLabel addGestureRecognizer:maleGesture];
    
    UITapGestureRecognizer *femaleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(femaleTapped)];
    [self.femaleLabel addGestureRecognizer:femaleGesture];
    
    [self.container setContentSize:self.container.frame.size];
    
    if ([self.firstNametxt respondsToSelector:@selector(setAttributedPlaceholder:)])
    {
        UIColor *color = [UIColor add_colorWithRGBHexString:Red_HEX];
        self.firstNametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:GET_STRING(@"firstName") attributes:@{NSForegroundColorAttributeName: color}];
        self.lastNametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:GET_STRING(@"lastName") attributes:@{NSForegroundColorAttributeName: color}];
        self.mobileNumberTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:GET_STRING(@"mobile") attributes:@{NSForegroundColorAttributeName: color}];
        self.usernameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:GET_STRING(@"Username (Your Email)") attributes:@{NSForegroundColorAttributeName: color}];
        self.preferredLanguageTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:GET_STRING(@"pLanguage") attributes:@{NSForegroundColorAttributeName: color}];
        self.nationalityTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:GET_STRING(@"nationality") attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    
   // self.dateLabel.textColor = Red_UIColor;
}

- (void) femaleTapped
{
    self.isMale = NO;
    self.switchBtn.selected = YES ;
    self.maleLabel.textColor =  [UIColor darkGrayColor];
    self.femaleLabel.textColor = Red_UIColor;
    [self.switchBtn setBackgroundImage:[UIImage imageNamed:@"select_right"]forState:UIControlStateNormal];

}

- (void) maleTapped{
    self.switchBtn.selected = NO ;
    self.maleLabel.textColor = Red_UIColor;
    self.femaleLabel.textColor = [UIColor darkGrayColor];
    self.isMale = YES;
    [self.switchBtn setBackgroundImage:[UIImage imageNamed:@"select_Left"]forState:UIControlStateNormal];

    
}

- (void) configrueNationalityAutoCompelete
{
    self.nationalityTxt.delegate = self;
    self.nationalityTxt.autoCompleteDataSource = self;
    self.nationalityTxt.autoCompleteDelegate = self;
    self.nationalityTxt.autoCompleteTableBorderColor = Red_UIColor;
    self.nationalityTxt.autoCompleteTableBorderWidth = 2;
    self.nationalityTxt.autoCompleteTableBackgroundColor = [UIColor whiteColor];
    self.nationalityTxt.autoCompleteTableAppearsAsKeyboardAccessory = YES;
    self.nationalityTxt.autoCompleteTableCellTextColor = [UIColor blackColor];
    [self.nationalityTxt setTintColor:Red_UIColor];
}

- (void) configureData
{
    self.sharedUser = [[MobAccountManager sharedMobAccountManager] applicationUser];
    if ([self.sharedUser.GenderEn  isEqual: @"Male"] || [self.sharedUser.GenderAr  isEqual: @"ذكر"]) {
        self.profileImageView.image = self.sharedUser.userImage ? self.sharedUser.userImage : [UIImage imageNamed:@"defaultdriver.jpg"];
        [self.switchBtn setBackgroundImage:[UIImage imageNamed:@"select_right"]forState:UIControlStateNormal];

    }else {
        self.profileImageView.image = self.sharedUser.userImage ? self.sharedUser.userImage : [UIImage imageNamed:@"defaultdriverfemale.jpg"];
        [self.switchBtn setBackgroundImage:[UIImage imageNamed:@"select_Left"]forState:UIControlStateNormal];

    }
//    self.profileImageView.image = self.sharedUser.userImage ? self.sharedUser.userImage : [UIImage imageNamed:@"thumbnail"];
    self.firstName = self.sharedUser.FirstName ;
    self.firstNametxt.text = self.firstName ;
    self.lastName = self.sharedUser.LastName ;
    self.lastNametxt.text = self.lastName ;
    self.mobileNumberTxt.text = [self.sharedUser.Mobile stringByReplacingOccurrencesOfString:@"+971" withString:@""] ;
    self.usernameTxt.text = self.sharedUser.Username ;
    self.nationalityTxt.text = (KIS_ARABIC)?self.sharedUser.NationalityArName:self.sharedUser.NationalityEnName ;
   
     if ([self.sharedUser.NationalityArName  isEqual: @"Not Specified"]|| [self.sharedUser.NationalityEnName  isEqual: @"Not Specified"]) {
     NSLog(@"The Nationality is : Not Specified");
         NSLog(_nationalityTxt.text);
     _nationalityTxt.text = @"";
     } else {
     NSLog(_nationalityTxt.text);
     }
    
//    NSString *dateString = self.sharedUser.BirthDate;
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
//    self.date = [dateFormatter dateFromString:dateString];
//    self.dateLabel.text = self.sharedUser.BirthDate ;
//
    if ([self.sharedUser.GenderEn isEqualToString:@"Male"])
    {
        self.isMale = YES;
        [self.switchBtn setSelected:NO];
        self.maleLabel.textColor = Red_UIColor;
        self.femaleLabel.textColor = [UIColor darkGrayColor];
        //SelectRight.png
        [self.switchBtn setBackgroundImage:[UIImage imageNamed:@"select_Left"]forState:UIControlStateNormal];

    }
    else
    {
        self.isMale = NO;
        [self.switchBtn setSelected:YES];
        self.maleLabel.textColor =  [UIColor darkGrayColor];
        self.femaleLabel.textColor = Red_UIColor;
        [self.switchBtn setBackgroundImage:[UIImage imageNamed:@"select_right"]forState:UIControlStateNormal];


    }

    __block EditProfileViewController*blockSelf = self;
    [[MasterDataManager sharedMasterDataManager] GetNationalitiesByID:@"0" WithSuccess:^(NSMutableArray *array) {
        blockSelf.nationalties = array;
        blockSelf.nationaltiesStringsArray = [NSMutableArray array];
        
        
        for (Nationality *nationality in blockSelf.nationalties)
        {
            long x = [self.sharedUser.NationalityId longValue] ;
            NSString *str = [NSString stringWithFormat:@"%ld",x];
            NSString *str2 = [NSString stringWithFormat:@"%@",nationality.ID];
            if ([str2 isEqualToString:str])
            {
                self.selectedNationality = nationality ;
            }
            
            if (KIS_ARABIC)
            {
                [blockSelf.nationaltiesStringsArray addObject:nationality.NationalityArName];
            }
            else
            {
                [blockSelf.nationaltiesStringsArray addObject:nationality.NationalityEnName];
            }
        }
        
        [[MasterDataManager sharedMasterDataManager] GetPrefferedLanguagesWithSuccess:^(NSMutableArray *array)
        {
            [KVNProgress dismiss];
            blockSelf.languages = array;
            for (Language *language in blockSelf.languages)
            {
                NSString *str = [NSString stringWithFormat:@"%@",language.LanguageId];
                
                if ([str isEqualToString:[NSString stringWithFormat:@"%@",self.sharedUser.PrefferedLanguage]])
                {
                    self.preferredLanguageTxt.text = (KIS_ARABIC)?language.LanguageArName:language.LanguageEnName;
                    self.selectedLanguage = language ;
                }
            }
        } Failure:^(NSString *error) {
            [blockSelf handleManagerFailure];
        }];
    } Failure:^(NSString *error) {
        [blockSelf handleManagerFailure];
    }];
    
//    self.dateFormatter = [[NSDateFormatter alloc] init];
}

- (void) handleManagerFailure
{
    [KVNProgress dismiss];
    [KVNProgress showErrorWithStatus:@"Error"];
    [self performBlock:^{
        [KVNProgress dismiss];
    } afterDelay:3];

}

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
    if(textField.text.length == 0 )
    {
        [self addRedBorderToView:textField.superview];
    }
    else
    {
        [self addGreyBorderToView:textField.superview];
    }
    
    if (textField == self.firstNametxt)
    {
        [self isValidFirstName];
    }
    else if (textField == self.lastNametxt)
    {
        [self isValidLastName];
    }
    else if (textField == self.mobileNumberTxt){
        [self isValidMobileNumber];
    }
    else if (textField == self.nationalityTxt)
    {
        [self isValidNationality];
    }
    
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
        self.animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        self.animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= self.animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.nationalityTxt)
    {
        return YES;
    }
    else if (textField == self.preferredLanguageTxt)
    {
        [self showPickerWithTextFieldType:LanguageTextField];
    }
    else
    {
        return YES;
    }
    return NO;
}

- (BOOL)textSouldEndEditing
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += self.animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField == self.mobileNumberTxt)
    {
        if (textField.text.length <= 8)
        {
            return YES;
        }
        else if(string.length == 0)
        {
            return YES ;
        }
        return NO;
    }
    return YES;
}

#pragma Touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView* view in self.view.subviews) {
        for (UIGestureRecognizer* recognizer in view.gestureRecognizers) {
            [recognizer addTarget:self action:@selector(touchEvent:)];
        }
        [self.view endEditing:YES];
        [self.container endEditing:YES];
        [self.mobileNumberTxt resignFirstResponder];
    }
}

- (void)touchEvent:(id)sender{
    
    
}

#pragma Pickers
- (void) showPickerWithTextFieldType:(TextFieldType)type{
    RMAction *selectAction = [RMAction actionWithTitle:GET_STRING(@"Select") style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        UIPickerView *picker = ((RMPickerViewController *)controller).picker;
        NSInteger selectedRow = [picker selectedRowInComponent:0];
        switch (picker.tag) {
            case NationalityTextField:
            {
                Nationality *nationality = [self.nationalties objectAtIndex:selectedRow];
                if (KIS_ARABIC) {
                    self.nationalityTxt.text = nationality.NationalityArName;
                }else{
                    self.nationalityTxt.text = nationality.NationalityEnName;
                }
                
                self.selectedNationality = nationality;
                [self configureBorders];
            }
                break;
            case LanguageTextField:
            {
                Language *language = [self.languages objectAtIndex:selectedRow];
                if (KIS_ARABIC) {
                    self.preferredLanguageTxt.text = language.LanguageArName;
                    
                }else{
                    self.preferredLanguageTxt.text = language.LanguageEnName;
                    
                }
                self.selectedLanguage = language;
            }
                break;
            default:
                break;
        }
        [self configureBorders];
    }];
    
    
    RMAction *cancelAction = [RMAction actionWithTitle:GET_STRING(@"Cancel") style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
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

//- (void)showDatePicker
//{
//    [self.view endEditing:YES];
//    __block EditProfileViewController *blockSelf = self;
//    RMAction *selectAction = [RMAction actionWithTitle:GET_STRING(@"Select") style:RMActionStyleDone andHandler:^(RMActionController *controller) {
//        NSDate *date =  ((UIDatePicker *)controller.contentView).date;
//        blockSelf.dateFormatter.dateFormat = @"dd, MMM, yyyy";
//        NSString * dateString = [self.dateFormatter stringFromDate:date];
//        self.dateLabel.text = dateString;
//        blockSelf.date = date;
//        if (([[HelpManager sharedHelpManager] yearsBetweenDate:[NSDate date] andDate:blockSelf.date] < 18)){
//            UIAlertView *alertView = [[UIAlertView  alloc] initWithTitle:GET_STRING(@"Error") message:GET_STRING(@"You should be older than 18 Years") delegate:self cancelButtonTitle:GET_STRING(@"Ok") otherButtonTitles:nil, nil];
//            [alertView show];
//            self.date = nil;
//            [self configureBorders];
//        }
//    }];
//    
//    //Create cancel action
//    RMAction *cancelAction = [RMAction actionWithTitle:GET_STRING(@"Cancel") style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
//        
//    }];
//    
//    //Create date selection view controller
//    RMDateSelectionViewController *dateSelectionController = [RMDateSelectionViewController actionControllerWithStyle:RMActionControllerStyleWhite selectAction:selectAction andCancelAction:cancelAction];
//    dateSelectionController.title = GET_STRING(@"Select date of birth");
//    dateSelectionController.datePicker.datePickerMode = UIDatePickerModeDate;
//    dateSelectionController.datePicker.date = self.date;
//    
//    //Now just present the date selection controller using the standard iOS presentation method
//    [self presentViewController:dateSelectionController animated:YES completion:nil];
//}

//GonEdit
#pragma Actions
- (IBAction)updateAction:(id)sender
{
    
    self.firstName = self.firstNametxt.text;
    self.firstName =[self SpacesRemover:self.firstName];
    self.lastName = self.lastNametxt.text;
    self.lastName = [self SpacesRemover:self.lastName];
    self.mobileNumber = self.mobileNumberTxt.text;
    self.mobileNumber = [self SpacesRemover:self.mobileNumber];


    BOOL validNationality = [self.nationaltiesStringsArray containsObject:self.nationalityTxt.text];
    if (validNationality)
    {
        self.selectedNationality = [self.nationalties objectAtIndex:[self.nationaltiesStringsArray indexOfObject:self.nationalityTxt.text]];
    }
    
    if(self.firstName.length == 0 || self.lastName.length == 0 /*|| !self.date*/)
    {
        [[HelpManager sharedHelpManager] showAlertWithMessage:GET_STRING(@"Please fill all fields")];
        [self configureBorders];
    }
    else if (![self isValidFirstName])
    {
        [[HelpManager sharedHelpManager] showAlertWithMessage:GET_STRING(@"First name mustn't have numbers")];
    }
    else if (![self isValidLastName])
    {
        [[HelpManager sharedHelpManager] showAlertWithMessage:GET_STRING(@"Last name mustn't have numbers")];
    }
    else if (![self isValidMobileNumber]){
        [[HelpManager sharedHelpManager] showAlertWithMessage:GET_STRING(@"Mobile Number should be only 9 and should start with [50 – 55 – 56 – 52]")];
    }
   /* else if (([[HelpManager sharedHelpManager] yearsBetweenDate:[NSDate date] andDate:self.date] < 18))
    {
        [[HelpManager sharedHelpManager] showAlertWithMessage:GET_STRING(@"You should be older than 18 Years")];
        self.date = nil;
        [self configureBorders];
    }*/
    else if (!validNationality && [_nationalityTxt.text length] != 0)
    {
        [[HelpManager sharedHelpManager] showAlertWithMessage:GET_STRING(@"Please Choose a valid nationality.")];
    }
    else {
        if (self.profileImage) {
            [KVNProgress showWithStatus:GET_STRING(@"Loading...")];
            UploadImageManager *imageManager = [[UploadImageManager alloc] initWithImage:self.profileImage Success:^(NSString *fileName) {
                     [self registerDriverWithPhotoName:fileName];
                
            } Failure:^(NSString *error) {
                [KVNProgress dismiss];
                    [self registerDriverWithPhotoName:@""];
            }];
            [imageManager uploadPhoto];
        }
        else{
                [self registerDriverWithPhotoName:@""];
            }
        
        
    }
        
        
    
    
    
//    else
//    {
//        self.dateFormatter.dateFormat = @"dd/MM/yyyy";
//        NSString *dateString = [self.dateFormatter stringFromDate:self.date];
//        [KVNProgress showWithStatus:GET_STRING(@"Loading...")];
//    
//    //GonMade Bos ya sede u will give the imagePath the name of your image
//        
//        [[MobAccountManager sharedMobAccountManager] updateUserProfileWithAccountID:[NSString stringWithFormat:@"%@",self.sharedUser.ID] firstName:self.firstName lastName:self.lastName gender:self.isMale ? @"M":@"F" imagePath:@"" birthDate:dateString nationalityID:self.selectedNationality.ID PreferredLanguageId:self.selectedLanguage.LanguageId Mobile:[self.sharedUser.Mobile stringByReplacingOccurrencesOfString:@"+971" withString:@""] WithSuccess:^(NSString *user) {
//        
//            [KVNProgress dismiss];
//            [KVNProgress showSuccessWithStatus:GET_STRING(@"Edit profile info success")];
//            [self performSelector:@selector(popViewController) withObject:nil afterDelay:1.0f];
//
//        } Failure:^(NSString *error)
//        {
//            [KVNProgress dismiss];
//            [[HelpManager sharedHelpManager] showAlertWithMessage:error];
//        }];
//    }
}

-(NSString *)SpacesRemover :(NSString *)StringRemoveSpaces{
    NSString *s = [StringRemoveSpaces stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return s ;
}

- (IBAction)selectGender:(id)sender
{
    UIButton *btn = (UIButton*)sender ;
    
    if (btn.selected)
    {
        self.switchBtn.selected = NO ;
        self.maleLabel.textColor = Red_UIColor;
        self.femaleLabel.textColor = [UIColor darkGrayColor];
        self.isMale = YES;
        [self.switchBtn setBackgroundImage:[UIImage imageNamed:@"select_Left"]forState:UIControlStateNormal];

    }
    else
    {
        self.isMale = NO;
        self.switchBtn.selected = YES ;
        self.maleLabel.textColor =  [UIColor darkGrayColor];
        self.femaleLabel.textColor = Red_UIColor;
        [self.switchBtn setBackgroundImage:[UIImage imageNamed:@"select_right"]forState:UIControlStateNormal];

    }
}


- (void) registerDriverWithPhotoName:(NSString *)photoName{

//self.dateFormatter.dateFormat = @"dd/MM/yyyy";
//NSString *dateString = [self.dateFormatter stringFromDate:self.date];
[KVNProgress showWithStatus:GET_STRING(@"Loading...")];

//GonMade Bos ya sede u will give the imagePath the name of your image

    if([_nationalityTxt.text length] != 0) {
        
        _NationalitySub = self.selectedNationality.ID;
    }else {
            _NationalitySub = @"0";
    }

[[MobAccountManager sharedMobAccountManager] updateUserProfileWithAccountID:[NSString stringWithFormat:@"%@",self.sharedUser.ID] firstName:[self SpacesRemover:self.firstName] lastName:[self SpacesRemover:self.lastName] gender:self.isMale ? @"M":@"F" imagePath:photoName birthDate:11/11/1988 nationalityID: _NationalitySub /*self.selectedNationality.ID */PreferredLanguageId:self.selectedLanguage.LanguageId Mobile:self.mobileNumber WithSuccess:^(NSString *user) {
    
    [KVNProgress dismiss];
    [KVNProgress showSuccessWithStatus:GET_STRING(@"Edit profile info success")];
    [self performSelector:@selector(popViewController) withObject:nil afterDelay:1.0f];
    
} Failure:^(NSString *error)
 {
     [KVNProgress dismiss];
     [[HelpManager sharedHelpManager] showAlertWithMessage:error];
 }];
}





#pragma PickerViewDeelgate&DataSource
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = @"";
    switch (pickerView.tag)
    {
        case NationalityTextField:
        {
            Nationality *nationality = [self.nationalties objectAtIndex:row];
            if (KIS_ARABIC) {
                title = nationality.NationalityArName;
            }else{
                title = nationality.NationalityEnName;
            }
        }
            break;
        case LanguageTextField:
        {
            Language *language = [self.languages objectAtIndex:row];
            if (KIS_ARABIC)
            {
                title = language.LanguageArName;
            }else{
                title = language.LanguageEnName;
            }
            
        }
            break;
            
        default:
            break;
    }
    
    return title;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

#pragma HomeViewController

- (void) mainViewController{
    
}

#pragma Borders
- (void) configureBorders
{
    self.firstName = self.firstNametxt.text;
    self.lastName = self.lastNametxt.text;
    self.mobileNumber = self.mobileNumberTxt.text;

    if (self.firstName.length == 0)
    {
        [self addRedBorderToView:self.firstNameView];
    }
    else{
        [self addGreyBorderToView:self.firstNameView];
    }
    
    if(self.lastName.length == 0){
        [self addRedBorderToView:self.lastNameView];
    }
    else{
        [self addGreyBorderToView:self.lastNameView];
    }
    if(self.mobileNumber.length == 0){
        [self addRedBorderToView:self.mobileNumberView];
    }
    else{
        [self addGreyBorderToView:self.mobileNumberView];
    }
    
    BOOL validNationality = [self.nationaltiesStringsArray containsObject:self.nationalityTxt.text];
    if (!validNationality){
        [self addRedBorderToView:self.nationalityView];
    }
    else{
        [self addGreyBorderToView:self.nationalityView];
    }

//    if (!self.date){
//        [self addRedBorderToView:self.datePickerView];
//    }
//    else{
//        [self addGreyBorderToView:self.datePickerView];
//    }
}

- (void) addRedBorderToView :(UIView *)view{
    view.layer.borderWidth = .5;
    view.layer.borderColor = Red_UIColor.CGColor;
}

- (void) addGreyBorderToView :(UIView *)view{
    view.layer.borderWidth = .5;
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void) removeBorderFromView:(UIView *)view{
    view.layer.borderWidth = 0;
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

#pragma Validation

- (BOOL) isValidFirstName{
    
    NSString *firstName = self.firstNametxt.text;
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    if ([firstName rangeOfCharacterFromSet:set].location != NSNotFound) {
        [self addRedBorderToView:self.firstNameView];
        return NO;
    }
    [self addGreyBorderToView:self.firstNameView];
    return YES;
}

- (BOOL) isValidLastName{
    
    NSString *lastName = self.lastNametxt.text;
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    if ([lastName rangeOfCharacterFromSet:set].location != NSNotFound) {
        [self addRedBorderToView:self.lastNameView];
        return NO;
    }
    [self addGreyBorderToView:self.lastNameView];
    return YES;
}


-(BOOL) IsValidEmail:(NSString *)checkString{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (BOOL) isValidNationality{
    BOOL validNationality = [self.nationaltiesStringsArray containsObject:self.nationalityTxt.text];
    if (!validNationality) {
        [self addRedBorderToView:self.nationalityView];
        return NO;
    }
    [self addGreyBorderToView:self.nationalityView];
    return YES;
}

- (BOOL) isValidMobileNumber
{
    NSArray *begins = @[@"50",@"55",@"56",@"52"];
    NSString *mobileNumber = self.mobileNumberTxt.text;
    NSString *begin = [mobileNumber substringToIndex:mobileNumber.length > 2 ? 2 : 0];
    
    if (mobileNumber.length != 9) {
        [self addRedBorderToView:self.mobileNumberView];
        return NO;
    }
    else if (![begins containsObject:begin]){
        [self addRedBorderToView:self.mobileNumberView];
        return NO;
    }
    else{
        [self addGreyBorderToView:self.mobileNumberView];
        return YES;
    }
    return YES;
}

- (REFrostedViewController *) homeViewController
{
    
    HomeViewController *homeViewControlle;
    if ( IDIOM == IPAD )
    {
        homeViewControlle = [[HomeViewController alloc] initWithNibName:(KIS_ARABIC)?@"HomeViewController_ar_Ipad":@"HomeViewController_Ipad" bundle:nil];
        
        
    }else {
        homeViewControlle = [[HomeViewController alloc] initWithNibName:(KIS_ARABIC)?@"HomeViewController_ar":@"HomeViewController" bundle:nil];
        
    }
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewControlle];
    SideMenuTableViewController  *menuController = [[SideMenuTableViewController alloc] initWithNavigationController:navigationController];
    
    
    // Create frosted view controller
    //
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.liveBlur = YES;
    frostedViewController.delegate = self;
    
    return frostedViewController;
}






//- (void) configureProfileImageView{
//    [self.profileImageView setUserInteractionEnabled:YES];
//    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2;
//    self.profileImageView.clipsToBounds = YES;
//    UITapGestureRecognizer *profileImageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileImageTapped)];
//    [self.profileImageView addGestureRecognizer:profileImageGesture];
//}
//
//- (void) profileImageTapped{
//    UIActionSheet *imageSourceOptions;
//    
//    imageSourceOptions = [[UIActionSheet alloc]
//                          initWithTitle:nil
//                          delegate:nil
//                          cancelButtonTitle:GET_STRING(@"Cancel")
//                          destructiveButtonTitle:nil
//                          otherButtonTitles:
//                          GET_STRING(@"Photo Library"),
//                          GET_STRING(@"Camera"),nil];
//    imageSourceOptions.delegate = self;
//    [imageSourceOptions showInView:self.view];
//}

- (IBAction)uploadPhotoHandler:(id)sender {
    UIActionSheet *imageSourceOptions;
    
    imageSourceOptions = [[UIActionSheet alloc]
                          initWithTitle:nil
                          delegate:nil
                          cancelButtonTitle:GET_STRING(@"Cancel")
                          destructiveButtonTitle:nil
                          otherButtonTitles:
                          GET_STRING(@"Photo Library"),
                          GET_STRING(@"Camera"),nil];
    imageSourceOptions.delegate = self;
    [imageSourceOptions showInView:self.view];
}

//- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    
//    UIImagePickerControllerSourceType source;
//    
//    if(buttonIndex == 0)
//    {
//        source = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
//    else if (buttonIndex == 1)
//    {
//        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//        {
//            [[[UIAlertView alloc] initWithTitle:nil message:GET_STRING(@"No camera on device") delegate:nil cancelButtonTitle:GET_STRING(@"Ok") otherButtonTitles:nil] show];
//            return;
//        }
//        source = UIImagePickerControllerSourceTypeCamera;
//    }
//    else
//    {
//        return;
//    }
//    
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
//    imagePickerController.sourceType = source;
//    imagePickerController.delegate = self;
//    if (source != UIImagePickerControllerSourceTypeCamera) {
//        imagePickerController.modalPresentationStyle = UIModalPresentationFormSheet;
//    }
//    imagePickerController.allowsEditing = YES;
//    [self presentViewController:imagePickerController];
//}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation
{
    // my code
    UIImagePickerControllerSourceType source;
    
    if(buttonIndex == 0)
    {
        source = UIImagePickerControllerSourceTypePhotoLibrary;
        NSLog(@"HE Picked Gallery");
    }
    else if (buttonIndex == 1)
    {
        NSLog(@"HE Picked Camera");
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            [[[UIAlertView alloc] initWithTitle:nil message:GET_STRING(@"No camera on device") delegate:nil cancelButtonTitle:GET_STRING(@"Ok") otherButtonTitles:nil] show];
            return;
        }
        source = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        return;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.sourceType = source;
    imagePickerController.delegate = self;
    if (source != UIImagePickerControllerSourceTypeCamera) {
        imagePickerController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController];
    
}


#pragma mark UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.profileImage = [info valueForKey:UIImagePickerControllerEditedImage];
    self.profileImageView.image = self.profileImage;
    self.profileImageView.hidden = NO;
//    self.uploadButton.hidden = YES;
    [self saveProfileImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ImagePicker Delegate

- (void) imagePickerControllerDidSelectImage:(UIImage *)image withIconName:(NSString *)iconName{
    
    self.profileImage = image;
    self.profileImageView.image = self.profileImage;
    [self saveProfileImage];
    
    
}

- (void) presentViewController:(UIViewController*)viewController{
    if ([viewController isKindOfClass:[UIImagePickerController class]] &&
        ((UIImagePickerController*)viewController).sourceType == UIImagePickerControllerSourceTypeCamera) {
    }
    else {
        viewController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void) saveProfileImage{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
