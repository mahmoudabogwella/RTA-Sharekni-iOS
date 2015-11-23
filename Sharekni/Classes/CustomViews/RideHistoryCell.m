//
//  RideHistoryCell.m
//  sharekni
//
//  Created by Ahmed Askar on 11/23/15.
//
//

#import "RideHistoryCell.h"

@implementation RideHistoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setJoinedRide:(Ride *)joinedRide
{
    _RouteName.text = joinedRide.Name_en;
    _FromRegionName.text = [NSString stringWithFormat:@"%@ - %@",joinedRide.FromEmirateEnName,joinedRide.FromRegionEnName];
    _ToRegionName.text = [NSString stringWithFormat:@"%@ - %@",joinedRide.ToEmirateEnName,joinedRide.ToRegionEnName];
}

- (void)setCreatedRide:(CreatedRide *)createdRide
{
    _RouteName.text = createdRide.Name_en;
    _FromRegionName.text = [NSString stringWithFormat:@"%@ - %@",createdRide.FromEmirateEnName,createdRide.FromRegionEnName];
    _ToRegionName.text = [NSString stringWithFormat:@"%@ - %@",createdRide.ToEmirateEnName,createdRide.ToRegionEnName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
