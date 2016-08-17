//
//  HappyMeter.h
//  sharekni
//
//  Created by killvak on 7/1/16.
//
//

#import "UIViewController+MJPopupViewController.h"
#import <UIKit/UIKit.h>
//#import "MostRideDetailsDataForPassenger.h"

@protocol MJAddRemarkPopupDelegate;

@interface HappyMeter : UIViewController <UIWebViewDelegate>
{
    __weak IBOutlet UITextView *viewText;
}

@property (assign, nonatomic) id <MJAddRemarkPopupDelegate> delegate;

//@property (nonatomic ,strong) MostRideDetailsDataForPassenger *driverDetails;
@property (nonatomic ,strong) NSString *serviceProviderSecret ;
@property (nonatomic ,strong) NSString *clientID ;
@property (nonatomic ,strong) NSString *microApp ;
@property (nonatomic ,strong) NSString *serviceProvider ;

@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

- (IBAction)closePopup:(id)sender ;

@end


@protocol MJAddRemarkPopupDelegate<NSObject>

@optional

- (void)dismissButtonClick:(HappyMeter*)HappyMeter;

- (void)DidInvitedToTheRide;

@end