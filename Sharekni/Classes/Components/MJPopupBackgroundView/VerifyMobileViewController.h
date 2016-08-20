//
//  VerifyMobileViewController.h
//  sharekni
//
//  Created by Ahmed Askar on 12/8/15.
//
//

#import <UIKit/UIKit.h>

@protocol VerifyMobilePopupDelegate;

@interface VerifyMobileViewController : UIViewController
{
    __weak IBOutlet UITextField *verificationCodeTxt;
}

@property (assign, nonatomic) id <VerifyMobilePopupDelegate> delegate;

@property (strong , nonatomic) NSString *accountID;
@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@property (weak, nonatomic) IBOutlet UILabel *headerTitle2;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *resendBtn;
@property (weak, nonatomic) IBOutlet UIView *container;

@end


@protocol VerifyMobilePopupDelegate<NSObject>

@optional

- (void)dismissButtonClicked:(VerifyMobileViewController*)verifyMobileNumber;

@end
