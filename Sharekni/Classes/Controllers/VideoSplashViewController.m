//
//  VideoSplashViewController.m
//  sharekni
//
//  Created by Ahmed Askar on 10/27/15.
//
//

#import "VideoSplashViewController.h"
#import "WelcomeViewController.h"
#import <AVFoundation/AVFoundation.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface VideoView : UIView

@end

@implementation VideoView

+ (Class)layerClass{
    
    return [AVPlayerLayer class];
}

@end

@interface VideoSplashViewController ()
{
    BOOL videoIsLoaded ;
}

@property (nonatomic, strong) AVPlayer *avplayer;
@property (strong, nonatomic) IBOutlet UIView *movieView;

@end

@implementation VideoSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES ;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;

    videoIsLoaded = NO ;
    [self prefersStatusBarHidden];
    [self setUpPlayer];
}

- (BOOL)prefersStatusBarHidden{
    
    if (!videoIsLoaded) {
        return YES;
    }else{
        return NO ;
    }
}

- (void)setUpPlayer
{
    //Not affecting background music playing
    NSError *sessionError = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&sessionError];
    [[AVAudioSession sharedInstance] setActive:YES error:&sessionError];
    
    //Set up player
    NSURL *movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Final_Intro" ofType:@"mp4"]];
    AVAsset *avAsset = [AVAsset assetWithURL:movieURL];
    AVPlayerItem *avPlayerItem =[[AVPlayerItem alloc]initWithAsset:avAsset];
    self.avplayer = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem];
    AVPlayerLayer *avPlayerLayer =[AVPlayerLayer playerLayerWithPlayer:self.avplayer];
    [avPlayerLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [avPlayerLayer setFrame:[[UIScreen mainScreen] bounds]];
    [self.movieView.layer addSublayer:avPlayerLayer];
    
    //Config player
    [self.avplayer seekToTime:kCMTimeZero];
    [self.avplayer setVolume:0.0f];
    [self.avplayer setActionAtItemEnd:AVPlayerActionAtItemEndNone];
    [self.avplayer play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.avplayer currentItem]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerStartPlaying)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification
{    
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
    [self.avplayer setRate:0.0];
    videoIsLoaded = YES ;
    [self prefersStatusBarHidden];
    self.navigationController.navigationBarHidden = NO ;
   
    WelcomeViewController *welcomeView = [[WelcomeViewController alloc] initWithNibName:@"WelcomeViewController" bundle:nil];
    [self.navigationController pushViewController:welcomeView animated:NO];
}

- (void)playerStartPlaying
{
    [self.avplayer play];
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
