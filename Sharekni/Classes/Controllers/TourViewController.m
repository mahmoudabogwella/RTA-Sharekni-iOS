//
//  TourViewController.m
//  sharekni
//
//  Created by Ahmed Askar on 11/26/15.
//
//

#import "TourViewController.h"
#import "PHPageScrollView.h"

@interface TourViewController () <PHPageScrollViewDataSource, PHPageScrollViewDelegate>

@property (weak, nonatomic) IBOutlet PHPageScrollView *pageScrollView;

@end

@implementation TourViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pageScrollView.delegate = self;
    self.pageScrollView.dataSource = self;
    [self.pageScrollView reloadData];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.translucent = YES;
//}

#pragma mark -

- (NSInteger)numberOfPageInPageScrollView:(PHPageScrollView*)pageScrollView
{
    return 6;
}

- (CGSize)sizeCellForPageScrollView:(PHPageScrollView*)pageScrollView
{
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
}

- (UIView*)pageScrollView:(PHPageScrollView*)pageScrollView viewForRowAtIndex:(int)index
{
    UIView * view = [[UIView alloc] initWithFrame:self.view.frame];
    UIImageView *image = [[UIImageView alloc] initWithFrame:view.frame];
    image.image = [UIImage imageNamed:[NSString stringWithFormat:@"iOS_%d.jpg",index]];
    [view addSubview:image];
    return view;
}

- (void)pageScrollView:(PHPageScrollView*)pageScrollView didScrollToPageAtIndex:(NSInteger)index
{
    
}

- (void)pageScrollView:(PHPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index
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
