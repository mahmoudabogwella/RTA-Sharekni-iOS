//
//  DriverRideCell.m
//  sharekni
//
//  Created by Ahmed Askar on 11/4/15.
//
//

#import "DriverRideCell.h"
#import "UILabel+Borders.h"
#import "Constants.h"
#import <UIColor+Additions/UIColor+Additions.h>

@implementation DriverRideCell

- (void)awakeFromNib {
    // Initialization code
    
    [_RouteName addRightBorderWithColor:Red_UIColor];
    [_RouteName addLeftBorderWithColor:Red_UIColor];
    
    _containerView.layer.cornerRadius = 20;
    _containerView.layer.borderWidth = 1;
    _containerView.layer.borderColor = Red_UIColor.CGColor;
}

- (void)setDriverRideDetails:(DriverDetails *)rideDetails
{
    _RouteName.text = rideDetails.RouteEnName ;
    _FromRegionName.text = [NSString stringWithFormat:@"%@ - %@",rideDetails.FromEmirateEnName,rideDetails.FromRegionEnName];
    _ToRegionName.text = [NSString stringWithFormat:@"To %@ - %@",rideDetails.ToEmirateEnName,rideDetails.ToRegionEnName];
}

- (NSString *)getAvailableDays:(DriverDetails *)rideDetails
{
    NSMutableString *str = [[NSMutableString alloc] init];
    
    if (rideDetails.Saturday.boolValue) {
        [str appendString:NSLocalizedString(@"Sat ", nil)];
    }
    if (rideDetails.Sunday.boolValue) {
        [str appendString:NSLocalizedString(@"Sun ", nil)];
    }
    if (rideDetails.Monday.boolValue) {
        [str appendString:NSLocalizedString(@"Mon ", nil)];
    }
    if (rideDetails.Tuesday.boolValue) {
        [str appendString:NSLocalizedString(@"Tue ", nil)];
    }
    if (rideDetails.Wendenday.boolValue) {
        [str appendString:NSLocalizedString(@"Wed ", nil)];
    }
    if (rideDetails.Thrursday.boolValue) {
        [str appendString:NSLocalizedString(@"Thu ", nil)];
    }
    if (rideDetails.Friday.boolValue) {
        [str appendString:NSLocalizedString(@"Fri ", nil)];
    }
    
    return str ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
