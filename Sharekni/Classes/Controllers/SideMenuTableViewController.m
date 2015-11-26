//
//  SideMenuTableViewController.m
//  sharekni
//
//  Created by ITWORX on 10/31/15.
//
//

#import "SideMenuTableViewController.h"
#import "Constants.h"
#import "HelpManager.h"
#import <UIColor+Additions.h>
#import "User.h"
#import "MobAccountManager.h"
#import "BestDriversViewController.h"
#import "SearchViewController.h"
#import "MostRidesViewController.h"
#import <REFrostedViewController.h>
#import <UIViewController+REFrostedViewController.h>
#import "SideMenuCell.h"
#import "AppDelegate.h"
#import "SavedSearchViewController.h"
#import "WelcomeViewController.h"
#import "NotificationsViewController.h"

#define Title_Key @"Title"
#define Image_Key @"ImageName"



@interface SideMenuTableViewController ()
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) User *applicationUser;
@end

@implementation SideMenuTableViewController

- (instancetype) initWithNavigationController:(UINavigationController *) navigationController{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        self.homeNavigationController = navigationController;
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.applicationUser = [[MobAccountManager sharedMobAccountManager] applicationUser];
    [self configureDataSourceArray];
    [self configureTableView];
}

- (void) configureDataSourceArray{
    self.items = [NSMutableArray array];
    NSDictionary *dictionary;
    if ([self.applicationUser.AccountStatus containsString:@"D"] || [self.applicationUser.AccountStatus containsString:@"B"]) {
        dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Home Page", nil),@"Side_Home"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Vehicles", nil),@"Side_vehicles"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Most Rides", nil),@"Side_mostrides"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Best Drivers", nil),@"Side_bestdriver"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Search", nil),@"Side_search"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Notifications", nil),@"Side_notifications"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Logout", nil),@"Side_Logout"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
    }
    else{
        dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Home Page", nil),@"Side_Home"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Saved Search", nil),@"Side_vehicles"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Most Rides", nil),@"Side_mostrides"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Best Drivers", nil),@"Side_bestdriver"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Search", nil),@"Side_search"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Notifications", nil),@"Side_notifications"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Logout", nil),@"Side_Logout"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
    }

}

- (void) configureTableView{
    self.tableView.separatorColor = Red_UIColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = self.applicationUser.userImage ? self.applicationUser.userImage : [UIImage imageNamed:@"thumbnail"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        imageView.contentMode  =UIViewContentModeScaleAspectFit;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 135, 0, 24)];
        label.text = [NSString stringWithFormat:@"%@ %@",self.applicationUser.FirstName,self.applicationUser.LastName];
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = Red_UIColor;
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
    self.tableView.tableFooterView = [[UIView alloc]  initWithFrame:CGRectZero];
}


#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex{
        return 0;
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    return self.items.count;
}

- (SideMenuCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier  = @"SideMenuCell";
    
    SideMenuCell *sideCell = (SideMenuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (sideCell == nil)
    {
        sideCell = (SideMenuCell *)[[[NSBundle mainBundle] loadNibNamed:@"SideMenuCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    NSDictionary *dictionary = self.items[indexPath.row];
    
    sideCell.cellTitle.text = [dictionary valueForKey:Title_Key] ;
    sideCell.cellIcon.image = [UIImage imageNamed:[dictionary valueForKey:Image_Key]] ;
    return sideCell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dictionary = [self.items objectAtIndex:indexPath.row];
    NSString *title = [dictionary valueForKey:Title_Key];
    
        if ([title isEqualToString:NSLocalizedString(@"Home Page", nil)])
        { //Home
            [self.frostedViewController setContentViewController:self.homeNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        else if ([title isEqualToString:NSLocalizedString(@"Most Rides", nil)])
        { //Most Rides
            [self.frostedViewController setContentViewController:self.mostRidesNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        else if ([title isEqualToString:NSLocalizedString(@"Best Drivers", nil)]){
            [self.frostedViewController setContentViewController:self.bestDriversNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        else if ([title isEqualToString:NSLocalizedString(@"Search", nil)]){
            [self.frostedViewController setContentViewController:self.searchNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        else if ([title isEqualToString:NSLocalizedString(@"Notificationsrivers", nil)]){
            [self.frostedViewController setContentViewController:self.searchNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        else if ([title isEqualToString:NSLocalizedString(@"Saved Search", nil)]){
            [self.frostedViewController setContentViewController:self.savedSearchNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        else if ([title isEqualToString:NSLocalizedString(@"Notifications", nil)]){
            [self.frostedViewController setContentViewController:self.notificationsNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        else if ([title isEqualToString:NSLocalizedString(@"Logout", nil)]){
            [[HelpManager sharedHelpManager] deleteUserFromUSerDefaults];
            [MobAccountManager sharedMobAccountManager].applicationUser = nil;
            [self presentViewController:self.welcomeNavigationController animated:YES completion:nil];
        }
    
}

- (UINavigationController *)bestDriversNavigationController{
    if (!_bestDriversNavigationController) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BestDriversViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"BestDriversViewController"];
            viewController.enableBackButton = NO;        
        _bestDriversNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    }
    return _bestDriversNavigationController;
}

- (UINavigationController *)searchNavigationController{
    if (!_searchNavigationController) {
        SearchViewController *viewController = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
        viewController.enableBackButton = NO;
        _searchNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    }
    return _searchNavigationController;
}

- (UINavigationController *)mostRidesNavigationController{
    if (!_mostRidesNavigationController) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MostRidesViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"MostRidesViewController"];
        viewController.enableBackButton = NO;
        _mostRidesNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];

    }
    return _mostRidesNavigationController;
}

- (UINavigationController *)savedSearchNavigationController{
    if (!_savedSearchNavigationController) {
        SavedSearchViewController *savedSearchViewController = [[SavedSearchViewController alloc] initWithNibName:@"SavedSearchViewController" bundle:nil];
        _savedSearchNavigationController = [[UINavigationController alloc] initWithRootViewController:savedSearchViewController];
    }
    return _savedSearchNavigationController;
}

- (UINavigationController *)notificationsNavigationController{
    if (!_notificationsNavigationController) {
        NotificationsViewController *notificationsView = [[NotificationsViewController alloc] initWithNibName:@"NotificationsViewController" bundle:nil];
        _notificationsNavigationController = [[UINavigationController alloc] initWithRootViewController:notificationsView];
    }
    return _notificationsNavigationController;
}

- (UINavigationController *)welcomeNavigationController{
    if (!_welcomeNavigationController) {
        WelcomeViewController *welcomeViewController = [[WelcomeViewController alloc] initWithNibName:@"WelcomeViewController" bundle:nil];
     _welcomeNavigationController = [[UINavigationController alloc] initWithRootViewController:welcomeViewController];
    }
    return _welcomeNavigationController;
}

@end
