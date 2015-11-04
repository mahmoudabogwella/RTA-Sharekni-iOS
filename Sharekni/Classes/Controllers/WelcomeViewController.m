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
<<<<<<< HEAD
#import "MostRidesViewController.h"

=======
#import "TopRidesViewController.h"
#import "MostRidesViewController.h"
>>>>>>> origin/master
@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.title = NSLocalizedString(@"sharkni", nil);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO ;
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
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
    [self.navigationController pushViewController:searchView animated:YES];
}

- (IBAction)topRides:(id)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MostRidesViewController *ridesView = [storyboard instantiateViewControllerWithIdentifier:@"MostRidesViewController"];
<<<<<<< HEAD
=======
    ridesView.enableBackButton = YES;
>>>>>>> origin/master
    [self.navigationController pushViewController:ridesView animated:YES];
}

- (IBAction)bestDrivers:(id)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BestDriversViewController *driversView = [storyboard instantiateViewControllerWithIdentifier:@"BestDriversViewController"];
    [self.navigationController pushViewController:driversView animated:YES];
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
