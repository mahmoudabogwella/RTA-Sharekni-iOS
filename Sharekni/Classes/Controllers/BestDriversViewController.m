//
//  BestDriversViewController.m
//  Sharekni
//
//  Created by Ahmed Askar on 9/26/15.
//
//

#import "BestDriversViewController.h"
#import "BestDriverCell.h"

@interface BestDriversViewController ()

@end

@implementation BestDriversViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;
}

- (BestDriverCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *driverIdentifier = @"BestDriverCell";
    BestDriverCell *driverCell = (BestDriverCell*)[tableView dequeueReusableCellWithIdentifier:driverIdentifier];
    if (driverCell == nil) {
        driverCell = [[BestDriverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:driverIdentifier];
        driverCell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    [driverCell setDriver:@"Ahmed" andCountry:@"Dubai"];
    
    return driverCell ;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
