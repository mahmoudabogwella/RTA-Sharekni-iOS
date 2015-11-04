//
//  MostRidesCell.m
//  Sharekni
//
//  Created by Ahmed Askar on 9/26/15.
//
//

#import "MostRidesCell.h"

@implementation MostRidesCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setRide:(MostRide *)ride
{
    self.FromEmirateName.text = @"From";
    self.FromRegionName.text = [NSString stringWithFormat:@"%@ : %@",ride.FromEmirateNameEn,ride.FromRegionNameEn];
    self.ToEmirateName.text = @"To";
    self.ToRegionName.text = [NSString stringWithFormat:@"%@ : %@",ride.ToEmirateNameEn,ride.ToRegionNameEn];
    self.noOfDrivers.text = [NSString stringWithFormat:@"%ld",ride.RoutesCount] ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
