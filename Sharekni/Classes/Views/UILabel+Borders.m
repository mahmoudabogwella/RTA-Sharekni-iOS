//
//  UILabel+Borders.m
//  sharekni
//
//  Created by Mohamed Abd El-latef on 10/24/15.
//
//

#import "UILabel+Borders.h"

@implementation UILabel (Borders)
- (void) addRightBorder:(UIColor *)color{
    CALayer *rightBorder = [CALayer layer];
    rightBorder.backgroundColor = [color CGColor];
    rightBorder.frame = CGRectMake(CGRectGetWidth(self.frame), 0, 1, CGRectGetHeight(self.frame));
    [self.layer addSublayer:rightBorder];
}
- (void)addLeftBorderWithColor:(UIColor *)color{
    CALayer *leftBorder = [CALayer layer];
    leftBorder.backgroundColor = [color CGColor];
    leftBorder.frame = CGRectMake(0, 0, 1, CGRectGetHeight(self.frame));
    [self.layer addSublayer:leftBorder];
}
@end
