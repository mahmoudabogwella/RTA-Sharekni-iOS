//
//  PickupLocationView.h
//  Sharekni
//
//  Created by ITWORX on 10/7/15.
//
//

#import <UIKit/UIKit.h>

@interface PickupLocationView : UIView <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emirateTextField;
@property (weak, nonatomic) IBOutlet UITextField *regionTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UILabel *regionView;
@property (weak, nonatomic) IBOutlet UILabel *emirateView;

@end
