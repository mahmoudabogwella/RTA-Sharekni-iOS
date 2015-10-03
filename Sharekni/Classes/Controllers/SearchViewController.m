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

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

}

- (IBAction)topRides:(id)sender {
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
