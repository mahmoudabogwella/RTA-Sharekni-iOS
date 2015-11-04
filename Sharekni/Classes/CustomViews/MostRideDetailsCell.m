    //
//  MostRideDetailsCell.m
//  sharekni
//
//  Created by Ahmed Askar on 10/31/15.
//
//

#import "MostRideDetailsCell.h"

@implementation MostRideDetailsCell

- (void)awakeFromNib {
    // Initialization code
    self.driverImage.layer.cornerRadius = self.driverImage.frame.size.width / 2.0f ;
    self.driverImage.clipsToBounds = YES ;
}

- (void)setMostRide:(MostRideDetails *)mostRide
{
    self.driverName.text = mostRide.DriverName ;
    self.country.text = mostRide.NationalityArName ;
    self.driverImage.image = [UIImage imageNamed:@"BestDriverImage"];
    self.startingTime.text = [NSString stringWithFormat:@"Starting Time : %@ - End Time : %@",mostRide.StartTime,mostRide.EndTime];
    self.availableDays.text = [self getAvailableDays:mostRide];
    self.rate.text = [NSString stringWithFormat:@"%ld",mostRide.Rating];
    self.phone = mostRide.DriverMobile ;
}

- (IBAction)sendMail:(id)sender
{
    [self.delegate sendSMSFromPhone:self.phone];
}

- (IBAction)call:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"tel:%@",self.phone]]];
}

- (NSString *)getAvailableDays:(MostRideDetails *)mostRide
{
    NSMutableString *str = [[NSMutableString alloc] init];
    
    if (mostRide.Saturday.boolValue) {
        [str appendString:NSLocalizedString(@"Sat ", nil)];
    }
    if (mostRide.Sunday.boolValue) {
        [str appendString:NSLocalizedString(@"Sun ", nil)];
    }
    if (mostRide.Monday.boolValue) {
        [str appendString:NSLocalizedString(@"Mon ", nil)];
    }
    if (mostRide.Tuesday.boolValue) {
        [str appendString:NSLocalizedString(@"Tue ", nil)];
    }
    if (mostRide.Wendenday.boolValue) {
        [str appendString:NSLocalizedString(@"Wed ", nil)];

    }
    if (mostRide.Thrursday.boolValue) {
        [str appendString:NSLocalizedString(@"Thu ", nil)];

    }
    if (mostRide.Friday.boolValue) {
        [str appendString:NSLocalizedString(@"Fri ", nil)];
    }
    
    return str ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
