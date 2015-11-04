//
//  MostRideDetailsCell.h
//  sharekni
//
//  Created by Ahmed Askar on 10/31/15.
//
//

#import <UIKit/UIKit.h>
#import "MostRideDetails.h"

@protocol SendMSGDelegate <NSObject>

- (void)sendSMSFromPhone:(NSString *)phone;
@end

@interface MostRideDetailsCell : UITableViewCell

@property (nonatomic ,weak) id <SendMSGDelegate> delegate ;

@property (nonatomic ,weak) IBOutlet UILabel *startingTime ;
@property (nonatomic ,weak) IBOutlet UILabel *availableDays ;
@property (nonatomic ,weak) IBOutlet UIImageView *driverImage ;
@property (nonatomic ,weak) IBOutlet UILabel *driverName ;
@property (nonatomic ,weak) IBOutlet UILabel *country ;
@property (nonatomic ,weak) IBOutlet UILabel *rate ;
@property (nonatomic ,strong) NSString *phone;

- (IBAction)call:(id)sender ;
- (IBAction)sendMail:(id)sender ;

- (void)setMostRide:(MostRideDetails *)mostRide;

@end
