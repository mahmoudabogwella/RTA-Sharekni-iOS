//
//  MostRidesCell.h
//  Sharekni
//
//  Created by Ahmed Askar on 9/26/15.
//
//

#import <UIKit/UIKit.h>
#import "MostRide.h"

@interface MostRidesCell : UITableViewCell

@property (nonatomic ,weak) IBOutlet UILabel *drivers ;
@property (nonatomic ,weak) IBOutlet UILabel *FromEmirateName ;
@property (nonatomic ,weak) IBOutlet UILabel *FromRegionName ;
@property (nonatomic ,weak) IBOutlet UILabel *ToEmirateName ;
@property (nonatomic ,weak) IBOutlet UILabel *ToRegionName ;


- (void)setRide:(MostRide *)ride ;

@end
