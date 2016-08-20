//
//  RideHistoryCell.m
//  sharekni
//
//  Created by Ahmed Askar on 11/23/15.
//
//

#import "RideHistoryCell.h"
#import "Constants.h"

@implementation RideHistoryCell

- (void)awakeFromNib {
    // Initialization code
    self.FromLabel.text = GET_STRING(@"From");
    self.ToLabel.text = GET_STRING(@"To");
}

- (void)setJoinedRide:(Ride *)joinedRide
{
    _RouteName.text = joinedRide.Name_en;
    _FromRegionName.text = [NSString stringWithFormat:@"%@ - %@",(KIS_ARABIC)?joinedRide.FromEmirateArName:joinedRide.FromEmirateEnName,(KIS_ARABIC)?joinedRide.FromRegionArName:joinedRide.FromRegionEnName];
    
    _ToRegionName.text = [NSString stringWithFormat:@"%@ - %@",(KIS_ARABIC)?joinedRide.ToEmirateArName:joinedRide.ToEmirateEnName,(KIS_ARABIC)?joinedRide.ToRegionArName:joinedRide.ToRegionEnName];
}

- (void)setCreatedRide:(CreatedRide *)createdRide
{
    _RouteName.text = createdRide.Name_en;
    _FromRegionName.text = [NSString stringWithFormat:@"%@ - %@",(KIS_ARABIC)?createdRide.FromEmirateArName:createdRide.FromEmirateEnName,(KIS_ARABIC)?createdRide.FromRegionArName:createdRide.FromRegionEnName];
    _ToRegionName.text = [NSString stringWithFormat:@"%@ - %@",(KIS_ARABIC)?createdRide.ToEmirateArName:createdRide.ToEmirateEnName,(KIS_ARABIC)?createdRide.ToRegionArName:createdRide.ToRegionEnName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
