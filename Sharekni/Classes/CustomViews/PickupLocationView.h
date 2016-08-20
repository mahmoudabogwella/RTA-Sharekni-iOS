//
//  PickupLocationView.h
//  Sharekni
//
//  Created by ITWORX on 10/7/15.
//
//

#import <UIKit/UIKit.h>
#import <RMActionController.h>
#import <RMPickerViewController.h>
@interface PickupLocationView : UIView <UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic)  UIViewController *presenter;

@property (nonatomic,strong) NSString *title;
@end
