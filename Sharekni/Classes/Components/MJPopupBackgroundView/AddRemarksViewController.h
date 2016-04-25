//
//  AddRemarksViewController.h
//  sharekni
//
//  Created by Ahmed Askar on 11/20/15.
//
//

#import <UIKit/UIKit.h>
#import "DriverDetails.h"

@protocol MJAddRemarkPopupDelegate;

@interface AddRemarksViewController : UIViewController
{
    __weak IBOutlet UITextView *viewText;
}

@property (assign, nonatomic) id <MJAddRemarkPopupDelegate> delegate;

@property (nonatomic ,strong) DriverDetails *driverDetails;
@property (nonatomic ,strong) NSString *accountID ;

@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@property (weak, nonatomic) IBOutlet UILabel *headerTitle2;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end


@protocol MJAddRemarkPopupDelegate<NSObject>

@optional

- (void)dismissButtonClicked:(AddRemarksViewController*)addRemarksViewController;
- (void)didJoinToRideSuccesfully;

@end