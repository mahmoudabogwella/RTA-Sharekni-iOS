//
//  NotificationsViewController.m
//  sharekni
//
//  Created by Ahmed Askar on 11/20/15.
//
//

#import "NotificationsViewController.h"
#import "MessageUI/MessageUI.h"
#import "Constants.h"
#import <KVNProgress/KVNProgress.h>
#import "NSObject+Blocks.h"
#import <UIColor+Additions.h>
#import "MasterDataManager.h"
#import "HelpManager.h"
#import "MasterDataManager.h"
#import "MobAccountManager.h"
#import "User.h"
#import "NotificationCell.h"
#import "NotificationDetailsViewController.h"

@interface NotificationsViewController () <ReloadNotificationsDelegate>

@property (nonatomic ,weak) IBOutlet UITableView *notificationsList ;

@end

@implementation NotificationsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Notifications";
    
//    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _backBtn.frame = CGRectMake(0, 0, 22, 22);
//    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
//    [_backBtn setHighlighted:NO];
//    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getNotifications
{
    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
    
    __block NotificationsViewController *blockSelf = self;
    [KVNProgress showWithStatus:NSLocalizedString(@"loading", nil)];
    [[MasterDataManager sharedMasterDataManager] getSavedSearch:[NSString stringWithFormat:@"%@",user.ID] withSuccess:^(NSMutableArray *array) {
        
        blockSelf.notifications = array;
        [KVNProgress dismiss];
        [self.notificationsList reloadData];
        
    } Failure:^(NSString *error) {
        NSLog(@"Error in Notifications");
        [KVNProgress dismiss];
        [KVNProgress showErrorWithStatus:@"Error"];
        [blockSelf performBlock:^{
            [KVNProgress dismiss];
        } afterDelay:3];
    }];
}

- (void)reloadNotifications
{
    [self reloadNotifications];
}

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.notifications.count;
}

- (NotificationCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier  = @"NotificationCell";
    
    NotificationCell *notificationCell = (NotificationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (notificationCell == nil)
    {
        notificationCell = (NotificationCell *)[[[NSBundle mainBundle] loadNibNamed:@"NotificationCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    Notification *notification = self.notifications[indexPath.row];
    [notificationCell setNotification:notification];
    
    return notificationCell ;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Notification *notification = self.notifications[indexPath.row];
    NotificationDetailsViewController *notificationDetails = [[NotificationDetailsViewController alloc] initWithNibName:@"NotificationDetailsViewController" bundle:nil];
    notificationDetails.delegate = self ;
    notificationDetails.notification = notification ;
    [self.navigationController pushViewController:notificationDetails animated:YES];
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
