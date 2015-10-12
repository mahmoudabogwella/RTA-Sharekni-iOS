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
    self.FromEmirateName.text = ride.FromEmirateNameEn;
    self.FromRegionName.text = ride.FromRegionNameEn;
    self.ToEmirateName.text = ride.ToEmirateNameEn;
    self.ToRegionName.text = ride.ToRegionNameEn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
