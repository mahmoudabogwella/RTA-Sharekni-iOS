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
#import "VehiclesViewController.h"
#import "HomeViewController.h"
#import "FAQ.h"

#define Title_Key @"Title"
#define Image_Key @"ImageName"



@interface SideMenuTableViewController ()
{
    NSArray *language ;
}
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) User *applicationUser;
@property (nonatomic,strong) NSString *MProfileImage;
@property (nonatomic,strong) NSString *FProfileImage;

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
    language = [NSArray new];
    [self configureDataSourceArray];
    [self configureTableView];
}

- (void) configureDataSourceArray
{
    self.items = [NSMutableArray array];
    NSDictionary *dictionary;
//    if ([self.applicationUser.AccountStatus containsString:@"D"] || [self.applicationUser.AccountStatus containsString:@"B"]) {
    
    NSLog(@"that is passenger value :%@",self.applicationUser.IsPassenger);
    NSString *LOL = [NSString stringWithFormat:@"%@",self.applicationUser.IsPassenger];
    NSLog(@"that is LOL Value :%@",LOL);
    if ([LOL containsString:@"0"] || [LOL containsString:@"false"]) {
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[GET_STRING(@"Home Page"),@"Side_Home"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[GET_STRING(@"Vehicles"),@"Side_vehicles"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        //Add new sidemenu 1
        dictionary = [[NSDictionary alloc] initWithObjects:@[GET_STRING(@"Help & FAQ"),@"Side_savesearch"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        // End of add new 1
        dictionary = [[NSDictionary alloc] initWithObjects:@[GET_STRING(@"Most Rides"),@"Side_mostrides"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[GET_STRING(@"Best Drivers"),@"Side_bestdriver"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[GET_STRING(@"Search"),@"Side_search"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[GET_STRING(@"Notifications"),@"Side_notifications"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        /*
        dictionary = [[NSDictionary alloc] initWithObjects:@[GET_STRING(@"Language"),(KIS_ARABIC)?@"Language_En":@"Language_Ar"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
*/
        dictionary = [[NSDictionary alloc] initWithObjects:@[GET_STRING(@"Logout"),@"Side_Logout"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
    }
    else{
        dictionary = [[NSDictionary alloc] initWithObjects:@[GET_STRING(@"Home Page"),@"Side_Home"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        //Add new sidemenu
        dictionary = [[NSDictionary alloc] initWithObjects:@[GET_STRING(@"Help & FAQ"),@"Side_savesearch"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        //end of add new 2
        dictionary = [[NSDictionary alloc] initWithObjects:@[GET_STRING(@"Most Rides"),@"Side_mostrides"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[GET_STRING(@"Best Drivers"),@"Side_bestdriver"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[GET_STRING(@"Search"),@"Side_search"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        
        dictionary = [[NSDictionary alloc] initWithObjects:@[GET_STRING(@"Notifications"),@"Side_notifications"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
        /*
        dictionary = [[NSDictionary alloc] initWithObjects:@[GET_STRING(@"Language"),(KIS_ARABIC)?@"Language_En":@"Language_Ar"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
*/
        dictionary = [[NSDictionary alloc] initWithObjects:@[GET_STRING(@"Logout"),@"Side_Logout"] forKeys:@[Title_Key,Image_Key]];
        [self.items addObject:dictionary];
    }
}

- (void) configureTableView
{
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
        
        
//        imageView.image = self.applicationUser.userImage ? self.applicationUser.userImage : [UIImage imageNamed:@"thumbnail"];
        switch ([[Languages sharedLanguageInstance] language]) {
                
                
            case Arabic:
                //
                if ([self.applicationUser.GenderEn  isEqual: @"Male"] || [self.applicationUser.GenderAr  isEqual: @"ذكر"]) {
                    
                    _MProfileImage = @"imageaftereditar.png";
                }else{
                    //                    NSLog(self.sharedUser.GenderAr);
                    _FProfileImage = @"imageaftereditfemale.png";
                }
                break;
            case English:
                //
                if ([self.applicationUser.GenderEn  isEqual: @"Male"] || [self.applicationUser.GenderAr  isEqual: @"ذكر"]) {
                    
                    _MProfileImage = @"imageafterediten.png";
                }else{
                    //                    NSLog(self.sharedUser.GenderAr);
                    _FProfileImage = @"imageaftereditfemale.png";
                }
                break;
            case Chines:
                //
                if ([self.applicationUser.GenderEn  isEqual: @"Male"] || [self.applicationUser.GenderAr  isEqual: @"ذكر"]) {
                    
                    _MProfileImage = @"imageafterediten_ch.png";
                }else{
                    //                    NSLog(self.sharedUser.GenderAr);
                    _FProfileImage = @"imageaftereditfemale_ch.png";
                }
                break;
            case Philippine:
                //
                
                if ([self.applicationUser.GenderEn  isEqual: @"Male"] || [self.applicationUser.GenderAr  isEqual: @"ذكر"]) {
                    
                    _MProfileImage = @"imageafterediten_fi.png";
                }else{
                    //                    NSLog(self.sharedUser.GenderAr);
                    _FProfileImage = @"imageaftereditfemale_fi.png";
                }
            case Urdu:
                //
                if ([self.applicationUser.GenderEn  isEqual: @"Male"] || [self.applicationUser.GenderAr  isEqual: @"ذكر"]) {
                    
                    _MProfileImage = @"Urduimageafterediten.png";
                }else{
                    //                    NSLog(self.sharedUser.GenderAr);
                    _FProfileImage = @"Urduimageaftereditfemale.png";
                }
                break;
            default:
                NSLog(@"Error with the language Image Picker");
                break;
        }
        self.applicationUser = [[MobAccountManager sharedMobAccountManager] applicationUser];
        if ([self.applicationUser.GenderEn  isEqual: @"Male"] || [self.applicationUser.GenderAr  isEqual: @"ذكر"]) {
            imageView.image = self.applicationUser.userImage ? self.applicationUser.userImage : [UIImage imageNamed:_MProfileImage];
            
        }else {
            imageView.image = self.applicationUser.userImage ? self.applicationUser.userImage : [UIImage imageNamed:_FProfileImage];

            
        }
        
        
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        imageView.contentMode  =UIViewContentModeScaleAspectFit;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 145, 0, 24)];
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
    if (IDIOM == IPAD) {
        NSLog(@"I'm Ipad User in The Side Menu");
        return 100;
    }else {
    return 42;
    }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictionary = [self.items objectAtIndex:indexPath.row];
    NSString *title = [dictionary valueForKey:Title_Key];
    
        if ([title isEqualToString:GET_STRING(@"Home Page")])
        { //Home
            [self.frostedViewController setContentViewController:self.homeNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        else if ([title isEqualToString:GET_STRING(@"Most Rides")])
        { //Most Rides
            [self.frostedViewController setContentViewController:self.mostRidesNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        else if ([title isEqualToString:GET_STRING(@"Best Drivers")]){
            [self.frostedViewController setContentViewController:self.bestDriversNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        else if ([title isEqualToString:GET_STRING(@"Search")]){
            [self.frostedViewController setContentViewController:self.searchNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        else if ([title isEqualToString:GET_STRING(@"Notificationsrivers")]){
            [self.frostedViewController setContentViewController:self.searchNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        else if ([title isEqualToString:GET_STRING(@"Saved Search")]){
            [self.frostedViewController setContentViewController:self.savedSearchNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        else if ([title isEqualToString:GET_STRING(@"Help & FAQ")]){
            [self.frostedViewController setContentViewController:self.FAQVC];
            [self.frostedViewController hideMenuViewController];
        }
        else if ([title isEqualToString:GET_STRING(@"Notifications")]){
            [self.frostedViewController setContentViewController:self.notificationsNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        else if ([title isEqualToString:GET_STRING(@"Vehicles")]){
            [self.frostedViewController setContentViewController:self.vehiclesNavigationController];
            [self.frostedViewController hideMenuViewController];
        }
        else if ([title isEqualToString:GET_STRING(@"Logout")]){
            [[HelpManager sharedHelpManager] deleteUserFromUSerDefaults];
            [MobAccountManager sharedMobAccountManager].applicationUser = nil;
            [self presentViewController:self.welcomeNavigationController animated:YES completion:nil];
        }/*else if ([title isEqualToString:GET_STRING(@"Language")]){

            if (KIS_ARABIC)
            {
                [self selectLangaugeEn];
            }else{
                [self selectLangaugeAr];
            }
        }*/
}

- (void)selectLangaugeEn
{
    language = [NSArray arrayWithObject:@"en"];
    
    LanguageType newLanguage;
    newLanguage = English;
    if (newLanguage != [Languages sharedLanguageInstance].language)
    {
        [[Languages sharedLanguageInstance] setLanguage:newLanguage];
        [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_CHANGE_NOTIFICATION object:self];
        [appDelegate reloadApp];
    }
}

- (void)selectLangaugeAr
{
    language = [NSArray arrayWithObject:@"ar"];
    LanguageType newLanguage;
    newLanguage = Arabic;
    if (newLanguage != [Languages sharedLanguageInstance].language)
    {
        [[Languages sharedLanguageInstance] setLanguage:newLanguage];
        [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_CHANGE_NOTIFICATION object:self];
        [appDelegate reloadApp];
    }
}

-(UINavigationController *)FAQVC{

        if (!_FAQVC) {
            FAQ *viewController = [[FAQ alloc] initWithNibName:@"FAQ" bundle:nil];
            viewController.enableBackButton = NO;
            _FAQVC = [[UINavigationController alloc] initWithRootViewController:viewController];
        }
        return _FAQVC;
    }



- (UINavigationController *)homeNavigationController
{
    if (!_homeNavigationController) {
        
        HomeViewController *homeViewControlle;
        if ( IDIOM == IPAD )
        {
            homeViewControlle = [[HomeViewController alloc] initWithNibName:(KIS_ARABIC)?@"HomeViewController_ar_Ipad":@"HomeViewController_Ipad" bundle:nil];
            
            
        }else {
            homeViewControlle = [[HomeViewController alloc] initWithNibName:(KIS_ARABIC)?@"HomeViewController_ar":@"HomeViewController" bundle:nil];
            
        }
        
        homeViewControlle.enableBackButton = NO;
        _homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewControlle];
    }
    return _homeNavigationController;
}


- (UINavigationController *)bestDriversNavigationController
{
    if (!_bestDriversNavigationController) {
        BestDriversViewController *viewController = [[BestDriversViewController alloc] initWithNibName:@"BestDriversViewController" bundle:nil];
        viewController.enableBackButton = NO;
        _bestDriversNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    }
    return _bestDriversNavigationController;
}

- (UINavigationController *)searchNavigationController
{
    if (!_searchNavigationController) {
        
        
        
        if ( IDIOM == IPAD ) {
            /* do something specifically for iPad. */
            SearchViewController *viewController = [[SearchViewController alloc] initWithNibName:(KIS_ARABIC)?@"SearchViewController_ar_Ipad":@"SearchViewController_Ipad" bundle:nil];
            viewController.enableBackButton = NO;
            _searchNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        } else {
            /* do something specifically for iPhone or iPod touch. */
            SearchViewController *viewController = [[SearchViewController alloc] initWithNibName:(KIS_ARABIC)?@"SearchViewController_ar":@"SearchViewController" bundle:nil];
            viewController.enableBackButton = NO;
            _searchNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        }
        
        
        
        
    
    }
    return _searchNavigationController;
}

- (UINavigationController *)mostRidesNavigationController
{
    if (!_mostRidesNavigationController) {

    MostRidesViewController *viewController = [[MostRidesViewController alloc] initWithNibName:@"MostRidesViewController" bundle:nil];
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

- (UINavigationController *)notificationsNavigationController
{
    if (!_notificationsNavigationController)
    {
        NotificationsViewController *notificationsView = [[NotificationsViewController alloc] initWithNibName:@"NotificationsViewController" bundle:nil];
        _notificationsNavigationController = [[UINavigationController alloc] initWithRootViewController:notificationsView];
    }
    return _notificationsNavigationController;
}

- (UINavigationController *)vehiclesNavigationController
{
    if (!_vehiclesNavigationController)
    {
        
        
        if (IDIOM == IPAD) {
            VehiclesViewController *vehiclesView = [[VehiclesViewController alloc] initWithNibName:(KIS_ARABIC)?@"VehiclesViewController_ar_Ipad":@"VehiclesViewController_Ipad" bundle:nil];
            _vehiclesNavigationController = [[UINavigationController alloc] initWithRootViewController:vehiclesView];
        }else {
            VehiclesViewController *vehiclesView = [[VehiclesViewController alloc] initWithNibName:(KIS_ARABIC)?@"VehiclesViewController_ar":@"VehiclesViewController" bundle:nil];
            _vehiclesNavigationController = [[UINavigationController alloc] initWithRootViewController:vehiclesView];
            
        }
        
        
     
    }
    return _vehiclesNavigationController;
}

- (UINavigationController *)welcomeNavigationController
{
    if (!_welcomeNavigationController)
    {
        if ( IDIOM == IPAD ) {
            WelcomeViewController *welcomeViewController = [[WelcomeViewController alloc] initWithNibName:(KIS_ARABIC)?@"WelcomeViewController_ar_Ipad":@"WelcomeViewController_Ipad" bundle:nil];
            
            _welcomeNavigationController = [[UINavigationController alloc] initWithRootViewController:welcomeViewController];
        }
        else{
        WelcomeViewController *welcomeViewController = [[WelcomeViewController alloc] initWithNibName:(KIS_ARABIC)?@"WelcomeViewController_ar":@"WelcomeViewController" bundle:nil];
            _welcomeNavigationController = [[UINavigationController alloc] initWithRootViewController:welcomeViewController];}
    }
    return _welcomeNavigationController;
}

@end
