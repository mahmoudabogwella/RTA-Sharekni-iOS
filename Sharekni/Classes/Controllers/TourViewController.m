//
//  TourViewController.m
//  sharekni
//
//  Created by Ahmed Askar on 11/26/15.
//
//

#import "TourViewController.h"
#import "PHPageScrollView.h"
#import "KCHorizontalScroller.h"
#import "Constants.h"
#import "Tour.h"
#import "PageView.h"

@interface TourViewController () <KCHorizontalScrollerDataSource ,KCHorizontalScrollerDelegate>
{
    NSArray *allImages;
    KCHorizontalScroller *scroller ;
}
@end

@implementation TourViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Take a tour", nil);
    
    allImages = [[Tour getInstance] getTourImages];

    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:NSLocalizedString(@"Back_icn",nil)] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    
    [self setScrollUserGuide];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setScrollUserGuide
{
    scroller = [[KCHorizontalScroller alloc] initWithFrame:CGRectMake(0,0,375,667)];
    scroller.dataSource = self ;
    scroller.delegate = self ;
    scroller.scrollWidth = 375;
    [self.view addSubview:scroller];
}


#pragma mark - KCHorizontalScrollerDelegate
- (void) horizontalScrollerDidScrollView:(float)fractional
{
    
}

- (void)horizontalScroller:(KCHorizontalScroller *)scroller clickedViewAtIndex:(int)index
{
    NSLog(@"index %d",index);
}

#pragma mark - KCHorizontalScrollerDataSource
- (NSInteger)numberOfViewsForHorizontalScroller:(KCHorizontalScroller*)scroller
{
    return allImages.count;
}

- (UIView *)horizontalScroller:(KCHorizontalScroller*)scroller viewAtIndex:(int)index
{
    Tour *tourObj = [allImages objectAtIndex:index];
    return [[PageView alloc] initWithFrame:CGRectMake(0,0,375,667-64) tour:tourObj];
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
