//
//  DriverRideCell.m
//  sharekni
//
//  Created by Ahmed Askar on 11/4/15.
//
//

#import "DriverRideCell.h"

@implementation DriverRideCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setDriverRideDetails:(DriverDetails *)rideDetails
{
    _RouteName.text = rideDetails.RouteEnName ;
    _FromRegionName.text = [NSString stringWithFormat:@"From %@ - %@",rideDetails.FromEmirateEnName,rideDetails.FromRegionEnName];
    _ToRegionName.text = [NSString stringWithFormat:@"To %@ - %@",rideDetails.ToEmirateEnName,rideDetails.ToRegionEnName];
    _startingTime.text = [NSString stringWithFormat:@"Starting Time : %@ - End Time : %@",rideDetails.StartTime,rideDetails.EndTime];
    _availableDays.text = [self getAvailableDays:rideDetails];
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
