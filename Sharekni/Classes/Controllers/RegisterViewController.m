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

@interface RegisterViewController ()
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

    
    float animatedDistance ;
}
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
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configureUI
{
    [container setContentSize:CGSizeMake(self.view.frame.size.width, 700)];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setDatePicker)];
    [self.view addGestureRecognizer:gesture];
    
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
    [switchBtn    setBackgroundImage:[UIImage imageNamed:@"select_right"]      forState:UIControlStateSelected];
    [switchBtn    setSelected:NO];

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
            break;
        case 1:
            [passengerBtn setSelected:YES];
            [driverBtn    setSelected:NO];
            [bothBtn    setSelected:NO];
            driverLbl.textColor = [UIColor darkGrayColor];
            passengerLbl.textColor = [UIColor whiteColor];
            bothLbl.textColor = [UIColor darkGrayColor];
            break;
        case 2:
            [driverBtn    setSelected:NO];
            [passengerBtn setSelected:NO];
            [bothBtn    setSelected:YES];
            driverLbl.textColor = [UIColor darkGrayColor];
            passengerLbl.textColor = [UIColor darkGrayColor];
            bothLbl.textColor = [UIColor whiteColor];
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
    }else{
        switchBtn.selected = YES ;
    }
}

- (void)setDatePicker
{
    
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


- (void)didReceiveMemoryWarning {
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
