//
//  AddRemarksViewControllerForMap.h
//  sharekni
//
//  Created by killvak on 2/21/16.
//
//

#import <UIKit/UIKit.h>
#import "MostRideDetailsDataForPassenger.h"

@protocol MJAddRemarkPopupDelegate;

@interface AddRemarksViewControllerForMap : UIViewController
{
    __weak IBOutlet UITextView *viewText;
}

@property (assign, nonatomic) id <MJAddRemarkPopupDelegate> delegate;

@property (nonatomic ,strong) MostRideDetailsDataForPassenger *driverDetails;
@property (nonatomic ,strong) NSString *accountID ;
@property (nonatomic ,strong) NSString *RouteID ;

@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@property (weak, nonatomic) IBOutlet UILabel *headerTitle2;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end


@protocol MJAddRemarkPopupDelegate<NSObject>

@optional

- (void)dismissButtonClicked:(AddRemarksViewControllerForMap*)addRemarksViewController;
- (void)DidInvitedToTheRide;

@end