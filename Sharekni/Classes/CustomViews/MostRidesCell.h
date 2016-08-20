//
//  MostRidesCell.h
//  Sharekni
//
//  Created by Ahmed Askar on 9/26/15.
//
//

#import <UIKit/UIKit.h>
#import "MostRide.h"

#define RIDE_CELL_ID @"RIDE_CELL_ID"
@interface MostRidesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *TDrivers;
@property (nonatomic ,weak) IBOutlet UIImageView *driversImage;
@property (nonatomic ,weak) IBOutlet UILabel *FromEmirateName ;
@property (nonatomic ,weak) IBOutlet UILabel *FromRegionName ;
@property (nonatomic ,weak) IBOutlet UILabel *ToEmirateName ;
@property (nonatomic ,weak) IBOutlet UILabel *ToRegionName ;
@property (weak, nonatomic) IBOutlet UILabel *noOfDrivers;


- (void)setRide:(MostRide *)ride ;

@end
