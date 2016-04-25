//
//  MostRideDetailsForMap.h
//  sharekni
//
//  Created by killvak on 2/20/16.
//
//


#import <UIKit/UIKit.h>
#import "MostRideDetailsDataForPassenger.h"
#import "DriverSearchResult.h"

#define MOST_RIDE_DETAILS_CELLID @"MostRideDetailsForMap"

@protocol SendMSGDelegate <NSObject>

- (void)callPhone:(NSString *)phone;
- (void)sendSMSFromPhone:(NSString *)phone;

@end

@interface MostRideDetailsForMap : UITableViewCell

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
@property (nonatomic ,strong) MostRideDetailsDataForPassenger *mostRide;

@property (nonatomic, copy) void (^reloadHandler)(void);

@property (weak, nonatomic) IBOutlet UIButton *InviteButton;

- (IBAction)call:(id)sender ;
- (IBAction)sendMail:(id)sender ;


@end
