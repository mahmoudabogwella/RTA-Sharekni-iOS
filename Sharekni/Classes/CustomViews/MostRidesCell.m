//
//  MostRidesCell.m
//  Sharekni
//
//  Created by Ahmed Askar on 9/26/15.
//
//

#import "MostRidesCell.h"
#import "Constants.h"
#import <UIColor+Additions.h>
@implementation MostRidesCell

- (void)awakeFromNib {
    // Initialization code
    self.driversImage.layer.cornerRadius = self.driversImage.frame.size.width / 2.0f ;
    self.driversImage.layer.borderWidth = 3.0f;
    self.driversImage.layer.borderColor = Red_UIColor.CGColor;
    self.driversImage.clipsToBounds = YES ;
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
