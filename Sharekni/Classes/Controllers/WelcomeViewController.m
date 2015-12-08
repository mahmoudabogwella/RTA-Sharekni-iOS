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

@interface WelcomeViewController ()
{
    NSArray* language ;
}
@property (weak, nonatomic) IBOutlet UIView *mostRidesView;
@property (weak, nonatomic) IBOutlet UIView *bestDriversView;

@property (weak, nonatomic) IBOutlet UIButton *enBtn;
@property (weak, nonatomic) IBOutlet UIButton *arBtn;

@end

@implementation WelcomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = NSLocalizedString(@"sharkni", nil);
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO ;
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self configureUI];
}

- (void) configureUI{
    
    self.navigationController.navigationBar.translucent = YES;
    
    language = [NSArray new];
    
//    if (KIS_ARABIC) {
//        self.arBtn.hidden = YES ;
//    }else{
//        self.enBtn.hidden = YES ;
//    }

    self.bestDriversView.layer.cornerRadius = 10;
    self.bestDriversView.layer.borderWidth = 1.5;
    self.bestDriversView.layer.borderColor = Red_UIColor.CGColor;
    UITapGestureRecognizer *BestDrivertapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bestDriverTapped)];
    [self.bestDriversView addGestureRecognizer:BestDrivertapGesture];
    
    self.mostRidesView.layer.cornerRadius = 10;
    self.mostRidesView.layer.borderWidth = 1.5;
    self.mostRidesView.layer.borderColor = Red_UIColor.CGColor;
    UITapGestureRecognizer *mostRidestapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mostRidesTapped)];
    [self.mostRidesView addGestureRecognizer:mostRidestapGesture];
}

- (IBAction)login:(id)sender
{
    LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginView animated:YES];
}

- (IBAction)Register:(id)sender
{
    RegisterViewController *registerView = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerView animated:YES];
}

- (IBAction)search:(id)sender
{
    SearchViewController *searchView = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    searchView.enableBackButton = YES;
    [self.navigationController pushViewController:searchView animated:YES];
}

- (IBAction)makeATour:(id)sender
{
    TourViewController *tourView = [[TourViewController alloc] initWithNibName:@"TourViewController" bundle:nil];
    [self.navigationController pushViewController:tourView animated:YES];
}

- (void)mostRidesTapped
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MostRidesViewController *ridesView = [storyboard instantiateViewControllerWithIdentifier:@"MostRidesViewController"];
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
    if (KIS_SYS_LANGUAGE_ARABIC)
    {
        language = [NSArray arrayWithObject:@"en"];
        [self userDidFinishSelectingLanguage];
    }
}

- (IBAction)selectArabic:(id)sender
{
    if (!KIS_SYS_LANGUAGE_ARABIC)
    {
        language = [NSArray arrayWithObject:@"ar"];
        [self userDidFinishSelectingLanguage];
    }
}

-(void) userDidFinishSelectingLanguage {
    UIAlertView * al = [[UIAlertView alloc] initWithTitle:nil
                                                  message:NSLocalizedString(@"App needs to open it again", nil)
                                                 delegate:self
                                        cancelButtonTitle:NSLocalizedString(@"No", nil)
                                        otherButtonTitles: NSLocalizedString(@"Restart", nil), nil];
    [al show];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != alertView.cancelButtonIndex) {
        
       [self updateUser:language];
    }
}

- (void)updateUser:(NSArray *)lang
{
    if ([lang[0] isEqualToString:@"ar"]) {
        [KUSER_DEFAULTS setObject:@"ar"
                           forKey:KUSER_LANGUAGE_KEY];
        [KUSER_DEFAULTS synchronize];
    }else{
        [KUSER_DEFAULTS setObject:@"en"
                           forKey:KUSER_LANGUAGE_KEY];
        [KUSER_DEFAULTS synchronize];
    }
    [KUSER_DEFAULTS setObject:lang forKey:@"AppleLanguages"];
    [KUSER_DEFAULTS synchronize];
    exit(0);
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
