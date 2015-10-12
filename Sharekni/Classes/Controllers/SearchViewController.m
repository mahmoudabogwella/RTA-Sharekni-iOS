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

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"searchOptions", nil);
    
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)quickSearch:(id)sender
{
//    QuickSearchViewController *quickSearchView = [[QuickSearchViewController alloc] initWithNibName:@"QuickSearchViewController" bundle:nil];
//    [self.navigationController pushViewController:quickSearchView animated:YES];
    UIAlertView *alertView =  [[UIAlertView alloc] initWithTitle:@"Attention" message:@"This feature is under development" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}


- (IBAction)advancedSearch:(id)sender
{
    AdvancedSearchViewController *advancedSearchView = [[AdvancedSearchViewController alloc] initWithNibName:@"AdvancedSearchViewController" bundle:nil];
    [self.navigationController pushViewController:advancedSearchView animated:YES];
}

- (IBAction)mapLookUp:(id)sender {
    UIAlertView *alertView =  [[UIAlertView alloc] initWithTitle:@"Attention" message:@"This feature is under development" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)topRides:(id)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MostRidesViewController *mostRides = [storyboard instantiateViewControllerWithIdentifier:@"MostRidesViewController"];
    [self.navigationController pushViewController:mostRides animated:YES];
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
