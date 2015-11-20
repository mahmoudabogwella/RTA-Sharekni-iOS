//
//  SavedSearchViewController.m
//  sharekni
//
//  Created by Ahmed Askar on 11/20/15.
//
//

#import "SavedSearchViewController.h"
#import "MessageUI/MessageUI.h"
#import "DriverRideCell.h"
#import "Constants.h"
#import <KVNProgress/KVNProgress.h>
#import "NSObject+Blocks.h"
#import <UIColor+Additions.h>
#import "MasterDataManager.h"
#import "RideDetailsViewController.h"
#import "DriverDetailsViewController.h"
#import "SearchResultsViewController.h"
#import "MobDriverManager.h"

@interface SavedSearchViewController ()

@property (nonatomic ,weak) IBOutlet UITableView *driverList ;
@property (nonatomic ,strong) NSMutableArray *savedData ;

@end

@implementation SavedSearchViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Saved Search";
    
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
  
    [self getRideDetails];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getRideDetails
{
    __block SavedSearchViewController *blockSelf = self;
    [KVNProgress showWithStatus:NSLocalizedString(@"loading", nil)];
    [[MasterDataManager sharedMasterDataManager] getSavedSearch:@"144450" withSuccess:^(NSMutableArray *array) {
        
        blockSelf.savedData = array;
        [KVNProgress dismiss];
        [self.driverList reloadData];
        
    } Failure:^(NSString *error) {
        NSLog(@"Error in Best Drivers");
        [KVNProgress dismiss];
        [KVNProgress showErrorWithStatus:@"Error"];
        [blockSelf performBlock:^{
            [KVNProgress dismiss];
        } afterDelay:3];
    }];
}

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.savedData.count;
}

- (DriverRideCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DriverRideCell *driverCell = (DriverRideCell *)[tableView dequeueReusableCellWithIdentifier:RIDE_CELLID];
    
    if (driverCell == nil)
    {
        driverCell = [[DriverRideCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RIDE_CELLID];
    }
    
    MostRideDetails *driverDetails = self.savedData[indexPath.row];
    [driverCell setSavedResultRideDetails:driverDetails];
    
    return driverCell ;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MostRideDetails *ride = self.savedData[indexPath.row];
//    DriverDetailsViewController *driverDetails = [[DriverDetailsViewController alloc] initWithNibName:@"DriverDetailsViewController" bundle:nil];
//    driverDetails.mostRideDetails = ride ;
//    [self.navigationController pushViewController:driverDetails animated:YES];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (!self.fromEmirate) {
//        [[HelpManager sharedHelpManager] showAlertWithMessage:NSLocalizedString(@"Please select start point ",nil)];
//    }
//    else{
        __block SavedSearchViewController *blockSelf = self;
        [KVNProgress showWithStatus:@"Loading..."];
        [[MobDriverManager sharedMobDriverManager] findRidesFromEmirate:ride.FromEmirateId andFromRegion:ride.FromRegionId toEmirate:ride.ToEmirateId andToRegion:ride.ToRegionId PerfferedLanguage:nil nationality:nil ageRange:nil date:nil isPeriodic:NO saveSearch:NO WithSuccess:^(NSArray *searchResults) {
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
                [[HelpManager sharedHelpManager] showAlertWithMessage:NSLocalizedString(@"No Rides Found ",nil)];
            }
        } Failure:^(NSString *error) {
            [KVNProgress dismiss];
        }];
//    }

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
