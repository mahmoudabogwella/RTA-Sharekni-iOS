//
//  MostRideDetailsCell.h
//  sharekni
//
//  Created by Ahmed Askar on 10/31/15.
//
//


#import <UIKit/UIKit.h>
#import "MostRideDetails.h"
#import "DriverSearchResult.h"

#define MOST_RIDE_DETAILS_CELLID @"MostRideDetailsCell"

@protocol SendMSGDelegate <NSObject>

- (void)callPhone:(NSString *)phone;
- (void)sendSMSFromPhone:(NSString *)phone;

@end

@interface MostRideDetailsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *CO2;
@property (weak, nonatomic) IBOutlet UILabel *TPoints;
@property (weak, nonatomic) IBOutlet UILabel *GreenPointCo2Saving;
@property (weak, nonatomic) IBOutlet UILabel *GreenPointPoints;

@property (nonatomic ,weak) id <SendMSGDelegate> delegate ;

@property (nonatomic ,weak) IBOutlet UILabel *startingTime ;
@property (nonatomic ,weak) IBOutlet UILabel *availableDays ;
@property (weak, nonatomic) IBOutlet UILabel *HideLastSeen;
@property (nonatomic ,weak) IBOutlet UIImageView *driverImage ;
@property (nonatomic ,weak) IBOutlet UILabel *driverName ;
@property (nonatomic ,weak) IBOutlet UILabel *country ;
@property (nonatomic ,weak) IBOutlet UILabel *rate ;
@property (nonatomic ,strong) NSString *phone;
@property (weak, nonatomic) IBOutlet UILabel *LastSeen;

@property (nonatomic ,strong) DriverSearchResult *driver;
@property (nonatomic ,strong) MostRideDetails *mostRide;

@property (nonatomic, copy) void (^reloadHandler)(void);
@property (weak, nonatomic) IBOutlet UIView *GreenPointBox;


- (IBAction)call:(id)sender ;
- (IBAction)sendMail:(id)sender ;


@end
