//
//  TourViewController.m
//  sharekni
//
//  Created by Ahmed Askar on 11/26/15.
//
//

#import "TourViewController.h"
#import "SMPageControl.h"
#import "EAIntroPage.h"
#import "EAIntroView.h"

@interface TourViewController () <EAIntroDelegate>
{
    UIView *rootView;
    EAIntroView *_intro;
}

@end

@implementation TourViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    rootView = self.navigationController.view;

    [self showIntroWithCustomPages];

}

- (void)showIntroWithCustomPages {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Splash1"]];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.titlePositionY = self.view.bounds.size.height/2 - 10;
    page2.descPositionY = self.view.bounds.size.height/2 - 50;
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splash2"]];
    page2.titleIconPositionY = 70;
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.titleFont = [UIFont fontWithName:@"Georgia-BoldItalic" size:20];
    page3.titlePositionY = 220;
    page3.descFont = [UIFont fontWithName:@"Georgia-Italic" size:18];
    page3.descPositionY = 200;
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Splash1"]];
    page3.titleIconPositionY = 100;
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splash2"]];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:@[page1,page2,page3,page4]];
//    intro.bgImage = [UIImage imageNamed:@"bg2"];
    
    intro.pageControlY = 250.f;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(0, 0, 230, 40)];
    [btn setTitle:@"SKIP NOW" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.borderWidth = 2.f;
    btn.layer.cornerRadius = 10;
    btn.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    intro.skipButton = btn;
    intro.skipButtonY = 60.f;
    intro.skipButtonAlignment = EAViewAlignmentCenter;
    
    [intro setDelegate:self];
    [intro showInView:rootView animateDuration:0.3];
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
