//
//  WelcomeViewController.m
//  Sharekni
//
//  Created by Ahmed Askar on 9/22/15.
//
//

#import "WelcomeViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "SearchViewController.h"
#import "BestDriversViewController.h"
#import "MostRidesViewController.h"
#import <UIColor+Additions.h>
#import "Constants.h"
#import "TourViewController.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "Languages.h"

#import "HappyMeter.h"
#import "UIViewController+MJPopupViewController.h"

@interface WelcomeViewController ()<MJAddRemarkPopupDelegate ,UIPickerViewDelegate ,UIPickerViewDataSource >
{
    NSArray* language ;
    //language Labels OutLet
    __weak IBOutlet UILabel *TMostRides;
    __weak IBOutlet UILabel *TbestDrivers;
    __weak IBOutlet UILabel *TLogin;
    __weak IBOutlet UILabel *Tregister;
    
    __weak IBOutlet UILabel *TheHappyMeter;
    __weak IBOutlet UILabel *TSearch;
    //
    __weak IBOutlet UITextField *TextViaPicker;
    
}





//

@property (weak, nonatomic) IBOutlet UIView *mostRidesView;
@property (weak, nonatomic) IBOutlet UIView *bestDriversView;

@property (weak, nonatomic) IBOutlet UIButton *enBtn;
@property (weak, nonatomic) IBOutlet UIButton *arBtn;

@end

@implementation WelcomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = GET_STRING(@"sharkni");
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden = NO ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    switch ([[Languages sharedLanguageInstance] language]) {
            
            
        case Arabic:
            //GET_STRING(@"Filipino") GET_STRING(@"Chinese") GET_STRING(@"Arabic") GET_STRING(@"English")
           
            hardCodedLanguages = @[ GET_STRING(@"English"),GET_STRING(@"Chinese"),GET_STRING(@"Filipino"),GET_STRING(@"Urdu")];
            selected = @"English";
            break;
        case English:
            //
            
            //        self.HindiButtonSelector.hidden = NO;
            hardCodedLanguages = @[GET_STRING(@"Arabic") ,GET_STRING(@"Chinese"),GET_STRING(@"Filipino") ,GET_STRING(@"Urdu")];
            selected = @"العربية";
            break;
        case Chines:
            //
            
            //        self.HindiButtonSelector.hidden = NO;
            hardCodedLanguages = @[GET_STRING(@"English") ,GET_STRING(@"Arabic"),GET_STRING(@"Filipino") ,GET_STRING(@"Urdu")];
            selected = @"English";
            break;
        case Philippine:
            //
            
            //        self.HindiButtonSelector.hidden = NO;
            hardCodedLanguages = @[GET_STRING(@"English") ,GET_STRING(@"Arabic"),GET_STRING(@"Chinese") ,GET_STRING(@"Urdu")];
            selected = @"English";
            break;
        case Urdu:
            //
            
            //        self.HindiButtonSelector.hidden = NO;
            hardCodedLanguages = @[GET_STRING(@"English") ,GET_STRING(@"Arabic"),GET_STRING(@"Chinese") ,GET_STRING(@"Filipino")];
            selected = @"English";
            break;
        default:
            NSLog(@"Error Picking Language");
            break;
    }
    
    TMostRides.text = GET_STRING(@"Most Rides");
    TbestDrivers.text = GET_STRING(@"Best Drivers");
    TLogin.text = GET_STRING(@"login");
    Tregister.text = GET_STRING(@"registration");
    TheHappyMeter.text = GET_STRING(@"Happy Meter");
    TSearch.text = GET_STRING(@"Search");

    [self shouldAutorotate];
    self.navigationController.navigationBarHidden = NO ;
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self configureUI];
    if ( IDIOM == IPAD) {
        NSLog(@"IPAD ");
    }
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

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void) configureUI
{
    self.navigationController.navigationBar.translucent = YES;
    
    
    // Picker
    
    UIPickerView *cityPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    cityPicker.delegate = self;
    cityPicker.dataSource = self;
    [cityPicker setBackgroundColor:[UIColor whiteColor]];
    [cityPicker setShowsSelectionIndicator:YES];
    TextViaPicker.inputView = cityPicker;
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
    [doneBtn setTitle:GET_STRING(@"Ok")];
    [barItems addObject:doneBtn];
    
    [mypickerToolbar setItems:barItems animated:YES];
    TextViaPicker.inputAccessoryView = mypickerToolbar;
    //    _TextViaPicker.inputView = picker ;
    language = [NSArray new];
    
    //
   if ( IDIOM == IPAD ) {
       self.bestDriversView.layer.cornerRadius = 20;
       self.bestDriversView.layer.borderWidth = 3.5;
   }else {
       self.bestDriversView.layer.cornerRadius = 10;
       self.bestDriversView.layer.borderWidth = 1.5;}
   
    self.bestDriversView.layer.borderColor = Red_UIColor.CGColor;
    UITapGestureRecognizer *BestDrivertapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bestDriverTapped)];
    [self.bestDriversView addGestureRecognizer:BestDrivertapGesture];
    
    if ( IDIOM == IPAD ) {
        self.mostRidesView.layer.cornerRadius = 20;
        self.mostRidesView.layer.borderWidth = 3.5;
    }else {
        self.mostRidesView.layer.cornerRadius = 10;
        self.mostRidesView.layer.borderWidth = 1.5;}

    self.mostRidesView.layer.borderColor = Red_UIColor.CGColor;
    UITapGestureRecognizer *mostRidestapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mostRidesTapped)];
    [self.mostRidesView addGestureRecognizer:mostRidestapGesture];
}



//PickerT

- (void)pickerDoneClicked {
    //[textField resignFirstResponder];
    NSLog(@"hi");
    [TextViaPicker resignFirstResponder];
    
    
    NSLog(@"that is the selected lang : %@",selected);
    
    if ([selected  isEqual: @"العربية"]) {
        NSLog(@"Selected Arabic");
        [[Languages sharedLanguageInstance] setLanguage:Arabic];
        [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_CHANGE_NOTIFICATION object:self];
        [appDelegate reloadApp];
        
    } else  if ([selected  isEqual: @"English"]) {
        NSLog(@"Selected English");
        [[Languages sharedLanguageInstance] setLanguage:English];
        [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_CHANGE_NOTIFICATION object:self];
        [appDelegate reloadApp];
    } else  if ([selected  isEqual: @"中国"] ) {
        NSLog(@"Selected Chines");
        [[Languages sharedLanguageInstance] setLanguage:Chines];
        [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_CHANGE_NOTIFICATION object:self];
        [appDelegate reloadApp];
    } else  if ([selected  isEqual: @"Filipino"]) {
        NSLog(@"Selected Filipino");
        [[Languages sharedLanguageInstance] setLanguage:Philippine];
        [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_CHANGE_NOTIFICATION object:self];
        [appDelegate reloadApp];
    }else  if ([selected  isEqual: @"اردو"]) {
        NSLog(@"Selected Urdu");
        [[Languages sharedLanguageInstance] setLanguage:Urdu];
        [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_CHANGE_NOTIFICATION object:self];
        [appDelegate reloadApp];
    }
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = hardCodedLanguages[row];
    if ([title  isEqual: @"العربية"]) {
        title = GET_STRING(@"Arabic");
    } else  if ([title  isEqual: @"English"]) {
        title = GET_STRING(@"English");
    } else  if ([title  isEqual: @"中国"] ) {
        title = GET_STRING(@"Chinese");
    } else  if ([title  isEqual: @"Filipino"]) {
        title = GET_STRING(@"Filipino");
    }else  if ([title  isEqual: @"اردو"]) {
        title = GET_STRING(@"Urdu");
    }
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
    
    TextViaPicker.text = hardCodedLanguages[row];
    selected = hardCodedLanguages[row];
    //    NSLog(selected);
    
    
}
-(void)pickerCANCELClicked{
    
    [TextViaPicker resignFirstResponder];
}




//

- (IBAction)login:(id)sender
{
    if ( IDIOM == IPAD ) {
        /* do something specifically for iPad. */
        
        LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:(KIS_ARABIC)?@"LoginViewController_ar_Ipad":@"LoginViewController_Ipad" bundle:nil];
        [self.navigationController pushViewController:loginView animated:YES];
        
    } else {
        /* do something specifically for iPhone or iPod touch. */
        LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:(KIS_ARABIC)?@"LoginViewController_ar":@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginView animated:YES];
        
    }
}

- (IBAction)Register:(id)sender
{
    if ( IDIOM == IPAD ) {
        /* do something specifically for iPad. */
        RegisterViewController *registerView = [[RegisterViewController alloc] initWithNibName:(KIS_ARABIC)?@"RegisterViewController_ar_Ipad":@"RegisterViewController_Ipad" bundle:nil];
        [self.navigationController pushViewController:registerView animated:YES];
    } else {
        /* do something specifically for iPhone or iPod touch. */
        RegisterViewController *registerView = [[RegisterViewController alloc] initWithNibName:(KIS_ARABIC)?@"RegisterViewController_ar":@"RegisterViewController" bundle:nil];
        [self.navigationController pushViewController:registerView animated:YES];
    }
    

}

- (IBAction)search:(id)sender
{
    
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

- (IBAction)makeATour:(id)sender
{
    /*
    TourViewController *tourView = [[TourViewController alloc] initWithNibName:@"TourViewController" bundle:nil];
    [self.navigationController pushViewController:tourView animated:YES];
  */
    //Happy Meter
    NSLog(@"Happy Metter");
    HappyMeter *happyMeter = [[HappyMeter alloc] initWithNibName:@"HappyMeter" bundle:nil];
    happyMeter.serviceProviderSecret = serviceProviderSecretHM;
    happyMeter.clientID = clientIDHM;
    happyMeter.microApp = microAppHM;
    happyMeter.serviceProvider = serviceProviderHM;
    happyMeter.delegate = self;
    [self presentPopupViewController2:happyMeter animationType:MJPopupViewAnimationSlideBottomBottom];
}

-(void)dismissButtonClick:(HappyMeter *)HappyMeter {
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
//End Happy Meter


- (void)mostRidesTapped
{
    MostRidesViewController *ridesView = [[MostRidesViewController alloc] initWithNibName:@"MostRidesViewController" bundle:nil];
    ridesView.enableBackButton = YES;
    [self.navigationController pushViewController:ridesView animated:YES];
}

- (void)bestDriverTapped
{
    BestDriversViewController *driversView = [[BestDriversViewController alloc] initWithNibName:@"BestDriversViewController" bundle:nil];
    driversView.enableBackButton = YES;
    [self.navigationController pushViewController:driversView animated:YES];
}

- (IBAction)selectEnglish:(id)sender
{
    
   /*
    language = [NSArray arrayWithObject:@"en"];
    
    LanguageType newLanguage;
    newLanguage = English;
    if (newLanguage != [Languages sharedLanguageInstance].language)
    {
        [[Languages sharedLanguageInstance] setLanguage:newLanguage];
        [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_CHANGE_NOTIFICATION object:self];
        [appDelegate reloadApp];
    }
    
    */
    [TextViaPicker becomeFirstResponder];

}

- (IBAction)selectArabic:(id)sender
{
    /*
    language = [NSArray arrayWithObject:@"ar"];
    LanguageType newLanguage;
    newLanguage = Arabic;
    if (newLanguage != [Languages sharedLanguageInstance].language)
    {
        [[Languages sharedLanguageInstance] setLanguage:newLanguage];
        [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_CHANGE_NOTIFICATION object:self];
        [appDelegate reloadApp];
    }*/
    [TextViaPicker becomeFirstResponder];

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
