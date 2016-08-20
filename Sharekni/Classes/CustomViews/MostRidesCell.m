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
    self.FromEmirateName.text = GET_STRING(@"From");
    self.ToEmirateName.text = GET_STRING(@"To");
    self.TDrivers.text = GET_STRING(@"Drivers");
//        if ([[Languages sharedLanguageInstance] language] == Philippine ||[[Languages sharedLanguageInstance] language] == Urdu ) {
//            self.FromEmirateName.textAlignment = NSTextAlignmentRight ;
//            self.ToEmirateName.textAlignment = NSTextAlignmentRight ;
//        }else {
//            self.FromEmirateName.textAlignment = NSTextAlignmentRight ;
//            self.ToEmirateName.textAlignment = NSTextAlignmentRight ;
//        }
}

- (void)setRide:(MostRide *)ride
{
    if (KIS_ARABIC)
    {
        self.FromRegionName.text = [NSString stringWithFormat:@"%@ : %@",ride.FromEmirateNameAr,ride.FromRegionNameAr];
        self.ToRegionName.text = [NSString stringWithFormat:@"%@ : %@",ride.ToEmirateNameAr,ride.ToRegionNameAr];
    }else{
        self.FromRegionName.text = [NSString stringWithFormat:@"%@ : %@",ride.FromEmirateNameEn,ride.FromRegionNameEn];
        self.ToRegionName.text = [NSString stringWithFormat:@"%@ : %@",ride.ToEmirateNameEn,ride.ToRegionNameEn];
    }
    self.noOfDrivers.text = [NSString stringWithFormat:@"%ld",ride.RoutesCount] ;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
