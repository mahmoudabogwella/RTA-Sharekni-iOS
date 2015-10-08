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

}


- (void) configureUI{
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView registerClass:[SearchResultCell class] forCellReuseIdentifier:SearchResultCell_ID];
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchResultCell" bundle:nil] forCellReuseIdentifier:SearchResultCell_ID];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.results.count;
}

- (SearchResultCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
