//
//  SearchResultsViewController.m
//  Sharekni
//
//  Created by ITWORX on 10/4/15.
//
//

#import "SearchResultsViewController.h"
#import "SearchResultCell.h"
#import "DriverSearchResult.h"
#import "MostRideDetailsCell.h"
#import "DriverDetailsViewController.h"
@interface SearchResultsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;

@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@end

@implementation SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void) configureUI{
    
   self.title = NSLocalizedString(@"Search Results", nil);
    self.fromLabel.text = [NSString stringWithFormat:@"%@ , %@",self.fromEmirate , self.fromRegion];
    self.toLabel.text = (self.toEmirate&&self.toRegion) ? [NSString stringWithFormat:@"%@ , %@",self.toEmirate , self.toRegion] : @"Not specified";

    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView registerClass:[MostRideDetailsCell class] forCellReuseIdentifier:MOST_RIDE_DETAILS_CELLID];
    [self.tableView registerNib:[UINib nibWithNibName:MOST_RIDE_DETAILS_CELLID bundle:nil] forCellReuseIdentifier:SearchResultCell_ID];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
}

#pragma mark - Methods
- (void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    return self.results.count;
}

- (MostRideDetailsCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   MostRideDetailsCell *cell = (MostRideDetailsCell*)[tableView dequeueReusableCellWithIdentifier:MOST_RIDE_DETAILS_CELLID];
    if (cell == nil) {
        cell = (MostRideDetailsCell *)[[[NSBundle mainBundle] loadNibNamed:@"MostRideDetailsCell" owner:nil options:nil] objectAtIndex:0];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    DriverSearchResult *driver = [self.results objectAtIndex:indexPath.row];
    [cell setDriver:driver];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 147;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DriverDetailsViewController *driverDetails = [[DriverDetailsViewController alloc] initWithNibName:@"DriverDetailsViewController" bundle:nil];
    DriverSearchResult *driver = [self.results objectAtIndex:indexPath.row];
    driverDetails.driverSearchResult = driver;
    [self.navigationController pushViewController:driverDetails animated:YES];
}




@end
