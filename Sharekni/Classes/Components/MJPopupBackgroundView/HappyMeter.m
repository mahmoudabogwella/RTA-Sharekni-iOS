//
//  HappyMeter.m
//  sharekni
//
//  Created by killvak on 7/1/16.
//
//



#import "HappyMeter.h"
#import "MobAccountManager.h"
#import "Constants.h"
#import <KVNProgress/KVNProgress.h>
#import "User.h"
#import "NSString+DSGHappinessCrypto.h"
#import "Util.h"
#import "Header.h"
#import "UserH.h"
#import "Application.h"
#import "Transaction.h"
#import "VotingRequest.h"
#import "VotingManager.h"

@interface HappyMeter (){
    
    //    NSString *serviceProviderSecret;
    //    NSString *clientID;
    //    NSString *microApp;
    NSString *microAppDisplay;
    //    NSString *serviceProvider;
    NSString *lang;
    
    REQUEST_TYPE request_type;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *LoadingInd;
@property(nonatomic , weak)IBOutlet UISegmentedControl *segmentedControl;

@property(nonatomic , weak)IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *ThisappB;
@property (weak, nonatomic) IBOutlet UIButton *MicroAppB;
@property (weak, nonatomic) IBOutlet UIButton *TransationB;

@end

@implementation HappyMeter


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    switch ([[Languages sharedLanguageInstance] language]) {
            case English:
            break;
        case Arabic:
            break;
        case Philippine:
            break;
        case Chines:
            break;
        case Indian:
            break;
        
    }
    [_ThisappB setTitle:GET_STRING(@"This app") forState:UIControlStateNormal];
    [_MicroAppB setTitle:GET_STRING(@"Micro app") forState:UIControlStateNormal];
    [_TransationB setTitle:GET_STRING(@"Transation") forState:UIControlStateNormal];

    [_LoadingInd startAnimating];
    [viewText becomeFirstResponder];
    
    
    
    if (KIS_ARABIC)
    {
        viewText.textAlignment = NSTextAlignmentRight ;
        lang = @"ar";
    }else{
        lang = @"en"; 
    }
    
    [self.headerTitle setText:(@"Happy Meter")];
    //    [self.headerTitle2 setText:GET_STRING(@"Your Remarks")];
    //    [self.submitBtn setTitle:GET_STRING(@"Submit") forState:UIControlStateNormal];
    
    //stop webview bouncing
    self.webView.scrollView.bounces = NO;
    
    //add tap gesture recignizer to stop webview loading if user taps any where outisde the webview durign loading
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(actionTapGesturePerformed:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapRecognizer];
    
    
    
    request_type = 1;
    
    [self logRequestWithVotingManager];
    NSLog(@"_serviceProviderSecret  :  %@",_serviceProviderSecret );
    NSLog(@"_clientID  :  %@",_clientID );
    NSLog(@"_microApp  :  %@",_microApp );
    NSLog(@"_serviceProvider  :  %@",_serviceProvider );
    
    
}

- (void)HideKeyboard
{
    [viewText resignFirstResponder];
}

-(IBAction)actionTapGesturePerformed:(id)sender {
    [self calcelWebviewRequest];
}

- (IBAction)closePopup:(id)sender
{
    
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    NSLog(@"that is the Button Tage Number  : %ld ",(long)tag);
    request_type = tag;
    
    [self logRequestWithVotingManager];
    
    
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

-(void)logRequestWithVotingManager {
    
    //set your preferred language accordingly. e.g. ar, en
//    lang = (self.segmentedControl.selectedSegmentIndex == 0) ? @"en" : @"ar";
    
    //To be replaced by the English/Arabic micro app display name.
    microAppDisplay = ([lang  isEqual: @"en"]) ? @"Micro App" : @"مايكرو آب";
    //To be replaced by the credentials if present.
    UserH *user = [[UserH alloc] initWithPrams:@"ANONYMOUS" username:@"" email:@"" mobile:@""];
    
    //set themeColor as per your requirements e.g. #ff0000, #00ff00
    Header *header = [[Header alloc] initWithPrams:[Util currentTimestamp]
                                   serviceProvider:_serviceProvider
                                      request_type:request_type
                                          microApp:_microApp
                                   microAppDisplay:microAppDisplay
                                        themeColor:@"#ff0000"];
    
    //To be replaced by the credentials if present.
    Application *application = [[Application alloc] initWithPrams:@"12345"
                                                             type:@"SMARTAPP"
                                                         platform:@"ANDROID"
                                                              url:@"http://mpay.qa.dubai.ae"
                                                            notes:@"MobileSDK Vote"];
    
    //To be replaced by the credentials if present.
    Transaction *transaction = [[Transaction alloc] initWithPrams:@"SAMPLE123-REPLACEWITHACTUAL!"
                                                      gessEnabled:@"false"
                                                      serviceCode:@""
                                               serviceDescription:@"demo transaction"
                                                          channel:@"WEB"];
    
    //create the voting request
    VotingRequest *votingRequest = [[VotingRequest alloc] initWithPrams:user
                                                                 header:header
                                                            application:application
                                                            transaction:transaction];
    
    //init voting manager to execute the request
    VotingManager *votingManager = [[VotingManager alloc] initWithPrams:_serviceProviderSecret clientID:_clientID lang:lang];
    
    [votingManager loadRequestWithWebView:self.webView usingVotignRequest:votingRequest];
    
    self.webView.alpha = 1.0f;
}

//calcel the webview request
-(void)calcelWebviewRequest {
    
    //load blank page
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    
    //hide webview
    self.webView.alpha = 0.0f;
    [self.delegate dismissButtonClick:self];
    
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    [_LoadingInd stopAnimating];
    if([[request.URL absoluteString] containsString:@"happiness://done"]) {
        [self calcelWebviewRequest];
    }
    
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [_LoadingInd stopAnimating];
    NSLog(@"didFailLoadWithError: %@", error);
}



@end
