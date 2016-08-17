//
//  FAQ.m
//  sharekni
//
//  Created by killvak on 7/9/16.
//
//

#import "FAQ.h"


#import "User.h"

@interface FAQ ()
    

@end

@implementation FAQ

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (KIS_ARABIC){
        _LangIs = @"ar";
    }else{
        _LangIs = @"en";
    }

    NSString *lanUrl = [NSString stringWithFormat:@"http://sharekni-web.sdg.ae/mob/%@/Accordion.aspx",_LangIs];
    
    NSString *fullURL = lanUrl ;
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
    
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
