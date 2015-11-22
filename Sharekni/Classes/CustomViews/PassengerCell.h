//
//  PassengerCell.h
//  sharekni
//
//  Created by Mohamed Abd El-latef on 11/22/15.
//
//

#import <UIKit/UIKit.h>

#define PASSENGER_CELLID @"PassengerCell"
#define PASSENGER_CELLHEIGHT 85

@interface PassengerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nationalityLabel;


@property (nonatomic, copy) void (^callHandler)(void);
@property (nonatomic, copy) void (^messageHandler)(void);
@property (nonatomic, copy) void (^deleteHandler)(void);
@property (nonatomic, copy) void (^ratingHandler)(void);

@end
