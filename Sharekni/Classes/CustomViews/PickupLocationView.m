//
//  PickupLocationView.m
//  Sharekni
//
//  Created by ITWORX on 10/7/15.
//
//

#import "PickupLocationView.h"
#import "HelpManager.h"
#import "MasterDataManager.h"
#import "Region.h"
#import "Emirate.h"


@implementation PickupLocationView

- (instancetype)init{
    self = [[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@",[PickupLocationView class]] owner:self options:nil] objectAtIndex:0];
    
    if(self){

        
    }
    return self;
}

- (void) configureUI{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.emirateView.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerTopLeft)
                                           cornerRadii:CGSizeMake(5.0, 5.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.emirateView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.emirateView.layer.mask = maskLayer;
    
    
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.regionView.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerTopLeft)
                                           cornerRadii:CGSizeMake(5.0, 5.0)];
    
    maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.regionView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.regionView.layer.mask = maskLayer;
    
    
    self.emirateTextField.delegate = self;
    self.regionTextField.delegate = self;
    
    UITapGestureRecognizer *dismissGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissHandler)];
    [self addGestureRecognizer:dismissGestureRecognizer];
}

- (IBAction)search:(id)sender {
    
}

- (void) dismissHandler{
    [self endEditing:YES];
}


@end
