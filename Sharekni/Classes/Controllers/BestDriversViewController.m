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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *driverIdentifier = @"BestDriverCell";
    UITableViewCell *driverCell = [tableView dequeueReusableCellWithIdentifier:driverIdentifier];
    if (driverCell == nil) {
        driverCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:driverIdentifier];
        driverCell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    
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
