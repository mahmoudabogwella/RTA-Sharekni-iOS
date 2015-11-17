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
@interface SearchResultsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
    NSString *headerText = [NSString stringWithFormat:@"%@,%@ \n to \n %@,%@",self.fromEmirate.EmirateEnName,self.fromRegion.RegionEnName,self.toEmirate.EmirateEnName,self.toRegion.RegionEnName];
    self.headerLabel.text = headerText;
    self.headerLabel.numberOfLines = 3;

    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView registerClass:[SearchResultCell class] forCellReuseIdentifier:SearchResultCell_ID];
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchResultCell" bundle:nil] forCellReuseIdentifier:SearchResultCell_ID];
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

- (SearchResultCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResultCell *cell = (SearchResultCell*)[tableView dequeueReusableCellWithIdentifier:SearchResultCell_ID];
    if (cell == nil) {
        cell = [[SearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SearchResultCell_ID];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    DriverSearchResult *driver = [self.results objectAtIndex:indexPath.row];
    cell.item = driver;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SearchResultCell_HEIGHT;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}




@end
