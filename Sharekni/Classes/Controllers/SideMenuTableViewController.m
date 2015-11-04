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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.applicationUser = [[MobAccountManager sharedMobAccountManager] applicationUser];
    [self configureDataSourceArray];
    [self configureTableView];
}

- (void) configureDataSourceArray{
    self.items = [NSMutableArray array];
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Home", nil),@""] forKeys:@[Title_Key,Image_Key]];
    [self.items addObject:dictionary];
    
    dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Most Rides", nil),@""] forKeys:@[Title_Key,Image_Key]];
    [self.items addObject:dictionary];
    
    dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Best Drivers", nil),@""] forKeys:@[Title_Key,Image_Key]];
    [self.items addObject:dictionary];
    
    dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Search", nil),@""] forKeys:@[Title_Key,Image_Key]];
    [self.items addObject:dictionary];
    
    dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Notifications", nil),@""] forKeys:@[Title_Key,Image_Key]];
    [self.items addObject:dictionary];
    
    dictionary = [[NSDictionary alloc] initWithObjects:@[NSLocalizedString(@"Logout", nil),@""] forKeys:@[Title_Key,Image_Key]];
    [self.items addObject:dictionary];
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
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 51, 100, 79)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"man.png"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
//        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
//        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *dictionary = self.items[indexPath.row];
    cell.textLabel.text = [dictionary valueForKey:Title_Key];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 5) {
        if (indexPath.row == 0) { //Home
            [self.frostedViewController setContentViewController:self.homeNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        if (indexPath.row == 1) { //Most Rides
            [self.frostedViewController setContentViewController:self.mostRidesNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        if (indexPath.row == 2) { //Best Drivers
            [self.frostedViewController setContentViewController:self.bestDriversNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        if (indexPath.row == 3) { //Search
            [self.frostedViewController setContentViewController:self.searchNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        if (indexPath.row == 4) { //Notifications
            [self.frostedViewController setContentViewController:self.searchNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
    }
    else{
        //Logout
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



@end
