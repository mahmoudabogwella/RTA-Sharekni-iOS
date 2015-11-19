//
//  RideDetailsViewController.m
//  sharekni
//
//  Created by Ahmed Askar on 10/31/15.
//
//

#import "RideDetailsViewController.h"
#import "MessageUI/MessageUI.h"
#import "Constants.h"
#import <KVNProgress/KVNProgress.h>
#import "NSObject+Blocks.h"
#import <UIColor+Additions.h>
#import "MasterDataManager.h"
#import "Review.h"
#import "ReviewCell.h"
#import "UILabel+Borders.h"
#import <UIColor+Additions/UIColor+Additions.h>
#import "Constants.h"

@interface RideDetailsViewController ()
{
    __weak IBOutlet UIScrollView *contentView ;
    __weak IBOutlet UITableView *reviewList ;
    __weak IBOutlet UIButton *joinRideBtn ;
    
    __weak IBOutlet UILabel *FromRegionName ;
    __weak IBOutlet UILabel *ToRegionName ;
    __weak IBOutlet UILabel *startingTime ;
    __weak IBOutlet UILabel *availableDays ;
    
    __weak IBOutlet UILabel *language ;
    __weak IBOutlet UILabel *smoking ;
    __weak IBOutlet UILabel *nationality ;
    __weak IBOutlet UILabel *gender ;
    __weak IBOutlet UILabel *ageRange ;
    
    __weak IBOutlet UILabel *preferenceLbl ;
    __weak IBOutlet UILabel *reviewLbl ;
    __weak IBOutlet UIView *preferenceView ;
    __weak IBOutlet UIView *reviewsView ;
}

@property (nonatomic ,strong) NSMutableArray *reviews ;

@end

@implementation RideDetailsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"rideDetails", nil);
    
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    
    [contentView setScrollEnabled:YES];
    [contentView setContentSize:contentView.frame.size];
    
    [preferenceLbl addRightBorderWithColor:Red_UIColor];
    [preferenceLbl addLeftBorderWithColor:Red_UIColor];
    [reviewLbl addRightBorderWithColor:Red_UIColor];
    [reviewLbl addLeftBorderWithColor:Red_UIColor];

    
    preferenceView.layer.cornerRadius = 20;
    preferenceView.layer.borderWidth = 1;
    preferenceView.layer.borderColor = Red_UIColor.CGColor;
    
    reviewsView.layer.cornerRadius = 20;
    reviewsView.layer.borderWidth = 1;
    reviewsView.layer.borderColor = Red_UIColor.CGColor;
    
    FromRegionName.text = [NSString stringWithFormat:@"%@ : %@",_driverDetails.FromEmirateEnName,_driverDetails.FromRegionEnName];
    ToRegionName.text = [NSString stringWithFormat:@"%@ : %@",_driverDetails.ToEmirateEnName,_driverDetails.ToRegionEnName];
    startingTime.text = [NSString stringWithFormat:@"Time %@ : %@",_driverDetails.StartTime,_driverDetails.EndTime];
    availableDays.text = [NSString stringWithFormat:@"Ride Days : %@",[self getAvailableDays:self.driverDetails]];
    
    nationality.text = _driverDetails.NationalityEnName ;
    ageRange.text = _driverDetails.AgeRange ;
    
    if (_driverDetails.IsSmoking.boolValue) {
        smoking.text = @"Yes";
    }else{
        smoking.text = @"No";
    }
    
    language.text = _driverDetails.PrefLanguageEnName;
    gender.text = _driverDetails.PreferredGender;
    
    [self getReviews];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)getReviews
{
    __block RideDetailsViewController *blockSelf = self;
  
    [KVNProgress showWithStatus:NSLocalizedString(@"loading", nil)];
   
    [[MasterDataManager sharedMasterDataManager] getReviewList:_driverDetails.AccountId andRoute:_driverDetails.RouteId withSuccess:^(NSMutableArray *array) {
       
        blockSelf.reviews = array;
        
        if (array.count == 0) {
            reviewLbl.hidden = YES ;
        }
        [KVNProgress dismiss];
        [reviewList reloadData];
        
        reviewList.frame = CGRectMake(reviewList.frame.origin.x, reviewList.frame.origin.y, reviewList.frame.size.width,self.reviews.count * 146.0f);
        
        reviewsView.frame = CGRectMake(reviewsView.frame.origin.x, reviewsView.frame.origin.y, reviewsView.frame.size.width,self.reviews.count * 146.0f);
        
        joinRideBtn.frame = CGRectMake(joinRideBtn.frame.origin.x, reviewsView.frame.origin.y + reviewsView.frame.size.height + 15.0f, joinRideBtn.frame.size.width, joinRideBtn.frame.size.height);
        
        [contentView setContentSize:CGSizeMake(self.view.frame.size.width, reviewsView.frame.origin.y + (self.reviews.count * 146.0f) + joinRideBtn.frame.size.height + 25.0f)];

    } Failure:^(NSString *error) {
        
        NSLog(@"Error in Best Drivers");
        [KVNProgress dismiss];
        [KVNProgress showErrorWithStatus:@"Error"];
        [blockSelf performBlock:^{
            [KVNProgress dismiss];
        } afterDelay:3];
    }];
}

- (NSString *)getAvailableDays:(DriverDetails *)driverDetails
{
    NSMutableString *str = [[NSMutableString alloc] init];
    
    if (driverDetails.Saturday.boolValue) {
        [str appendString:NSLocalizedString(@"Sat ", nil)];
    }
    if (driverDetails.Sunday.boolValue) {
        [str appendString:NSLocalizedString(@"Sun ", nil)];
    }
    if (driverDetails.Monday.boolValue) {
        [str appendString:NSLocalizedString(@"Mon ", nil)];
    }
    if (driverDetails.Tuesday.boolValue) {
        [str appendString:NSLocalizedString(@"Tue ", nil)];
    }
    if (driverDetails.Wendenday.boolValue) {
        [str appendString:NSLocalizedString(@"Wed ", nil)];
        
    }
    if (driverDetails.Thrursday.boolValue) {
        [str appendString:NSLocalizedString(@"Thu ", nil)];
        
    }
    if (driverDetails.Friday.boolValue) {
        [str appendString:NSLocalizedString(@"Fri ", nil)];
    }
    
    return str ;
}

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.reviews.count;
}

- (ReviewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier  = @"ReviewCell";
    
    ReviewCell *reviewCell = (ReviewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (reviewCell == nil)
    {
        reviewCell = (ReviewCell *)[[[NSBundle mainBundle] loadNibNamed:@"ReviewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    Review *review = self.reviews[indexPath.row];
    [reviewCell setReview:review];
    
    return reviewCell ;
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
