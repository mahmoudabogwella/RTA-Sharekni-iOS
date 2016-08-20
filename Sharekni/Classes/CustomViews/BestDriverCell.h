//
//  BestDriverCell.h
//  Sharekni
//
//  Created by Ahmed Askar on 9/26/15.
//
//

#import <UIKit/UIKit.h>
#import "BestDriver.h"

@protocol SendSMSDelegate <NSObject>
- (void)sendSMSFromPhone:(NSString *)phone;
- (void)callMobileNumber:(NSString *)phone;

@end

@interface BestDriverCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TPoints;
@property (weak, nonatomic) IBOutlet UILabel *CO2;
@property (weak, nonatomic) IBOutlet UILabel *TLastSeen;

@property (nonatomic ,weak) id <SendSMSDelegate> delegate ;
@property (weak, nonatomic) IBOutlet UILabel *LastSeen;

@property (nonatomic ,weak) IBOutlet UIImageView *driverImage ;
@property (nonatomic ,weak) IBOutlet UILabel *driverName ;
@property (nonatomic ,weak) IBOutlet UILabel *driverCountry ;
@property (nonatomic ,weak) IBOutlet UILabel *rateLbl ;
@property (weak, nonatomic) IBOutlet UILabel *GreenPointPoints;
@property (weak, nonatomic) IBOutlet UILabel *GreenPointCo2;

@property (nonatomic ,strong) NSString *phone;
@property (nonatomic ,strong) BestDriver *driver;

- (IBAction)sendMail:(id)sender ;
- (IBAction)call:(id)sender ;


@end
