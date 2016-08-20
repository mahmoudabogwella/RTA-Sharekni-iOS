//
//  RideHistoryCell.h
//  sharekni
//
//  Created by Ahmed Askar on 11/23/15.
//
//

#import <UIKit/UIKit.h>
#import "Ride.h"
#import "CreatedRide.h"

@interface RideHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *FromLabel;
@property (weak, nonatomic) IBOutlet UILabel *ToLabel;

@property (nonatomic ,weak) IBOutlet UILabel *RouteName ;
@property (nonatomic ,weak) IBOutlet UIView *containerView ;
@property (nonatomic ,weak) IBOutlet UILabel *FromRegionName ;
@property (nonatomic ,weak) IBOutlet UILabel *ToRegionName ;

- (void)setJoinedRide:(Ride *)joinedRide ;
- (void)setCreatedRide:(CreatedRide *)createdRide ;

@end
