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
@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"searchOptions", nil);
    self.navigationController.navigationBarHidden = NO ;
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)quickSearch:(id)sender
{
    QuickSearchViewController *quickSearchView = [[QuickSearchViewController alloc] initWithNibName:@"QuickSearchViewController" bundle:nil];
    [self.navigationController pushViewController:quickSearchView animated:YES];
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
