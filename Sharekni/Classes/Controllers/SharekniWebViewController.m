//
//  SharekniWebViewController.m
//  sharekni
//
//  Created by Mohamed Abd El-latef on 11/14/15.
//
//

#import "SharekniWebViewController.h"
#import <UIColor+Additions.h>
#import <KVNProgress.h>
#import <KVNProgressConfiguration.h>

@interface SharekniWebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation SharekniWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

- (void) configureUI{
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.title = self.type == WebViewPrivacyType ? NSLocalizedString(@"Policy",nil) : NSLocalizedString(@"Terms And Conditions",nil);
    
    [self.acceptButton setBackgroundColor:Red_UIColor];
    NSString *acceptTitle = self.type == WebViewPrivacyType ? NSLocalizedString(@"Accept", nil) :NSLocalizedString(@"Accept", nil);
    [self.acceptButton setTitle:acceptTitle forState:UIControlStateNormal];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.type == WebViewPrivacyType ? @"policy" : @"terms_en" ofType:@"html"]isDirectory:NO]]];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    KVNProgressConfiguration *progressConfiguration = [KVNProgress configuration];
    progressConfiguration.fullScreen = NO;
    [KVNProgress setConfiguration:progressConfiguration];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    KVNProgressConfiguration *progressConfiguration = [KVNProgress configuration];
    progressConfiguration.fullScreen = NO;
    [KVNProgress setConfiguration:progressConfiguration];
}
- (IBAction)acceptAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    

    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [KVNProgress showWithStatus:NSLocalizedString(@"Loading...", nil)];
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [KVNProgress dismiss];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [KVNProgress dismiss];
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
