    //
//  MostRideDetailsCell.m
//  sharekni
//
//  Created by Ahmed Askar on 10/31/15.
//
//

#import "MostRideDetailsCell.h"
#import "MasterDataManager.h"
static void* const MyKVOContext = (void *)&MyKVOContext;

@implementation MostRideDetailsCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self = (MostRideDetailsCell *)[[[NSBundle mainBundle] loadNibNamed:@"MostRideDetailsCell" owner:nil options:nil] objectAtIndex:0];
        self.driverImage.layer.cornerRadius = self.driverImage.frame.size.width / 2.0f ;
        self.driverImage.clipsToBounds = YES ;
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
    self.driverImage.layer.cornerRadius = self.driverImage.frame.size.width / 2.0f ;
    self.driverImage.clipsToBounds = YES ;
}

- (void)setMostRide:(MostRideDetails *)mostRide{
    _mostRide = mostRide;
    self.driverName.text = mostRide.DriverName ;
    self.country.text = mostRide.NationalityArName ;
    self.driverImage.image = mostRide.driverImage;
    self.startingTime.text = [NSString stringWithFormat:@"Starting Time : %@",mostRide.StartTime];
    self.availableDays.text = [self getAvailableDays:mostRide];
    self.rate.text = mostRide.Rating; //[NSString stringWithFormat:@"%@",];
    self.phone = mostRide.DriverMobile ;
    [self.mostRide addObserver:self forKeyPath:@"driverImage" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:MyKVOContext];
}

- (void)setDriver:(DriverSearchResult *)driver{
    _driver = driver;
    self.driverImage.image = [UIImage imageNamed:@"thumbnail.png"];

    
    self.driverName.text = driver.AccountName;
    self.country.text = driver.Nationality_en;
    self.phone = driver.AccountMobile ;
    self.startingTime.text = [NSString stringWithFormat:@"Starting Time : %@",driver.SDG_Route_Start_FromTime];

    NSString *daysText = @"";
    if (driver.SDG_RouteDays_Sunday.boolValue) {
        daysText = [daysText stringByAppendingString:NSLocalizedString(@"Sun,", nil)];
    }
    if (driver.SDG_RouteDays_Monday.boolValue) {
        daysText = [daysText stringByAppendingString:NSLocalizedString(@"Mon,", nil)];
    }
    if (driver.SDG_RouteDays_Tuesday.boolValue) {
        daysText = [daysText stringByAppendingString:NSLocalizedString(@"Tue,", nil)];
    }
    if (driver.SDG_RouteDays_Wednesday.boolValue) {
        daysText = [daysText stringByAppendingString:NSLocalizedString(@"Wed,", nil)];
    }
    if (driver.SDG_RouteDays_Thursday.boolValue) {
        daysText = [daysText stringByAppendingString:NSLocalizedString(@"Thu,", nil)];
    }
    if (driver.SDG_RouteDays_Friday.boolValue) {
        daysText = [daysText stringByAppendingString:NSLocalizedString(@"Fri,", nil)];
    }
    if (driver.Saturday.boolValue) {
        daysText = [daysText stringByAppendingString:NSLocalizedString(@"Sat,", nil)];
    }
    if (daysText.length > 0) {
        self.availableDays.text = daysText;        
    }
}

- (IBAction)sendMail:(id)sender{
    [self.delegate sendSMSFromPhone:self.phone];
}

- (IBAction)call:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"tel:%@",[NSString stringWithFormat:@"0%@",self.phone]]]];
}

- (NSString *)getAvailableDays:(MostRideDetails *)mostRide{
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


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object change:(NSDictionary *)change
                       context:(void *)context
{
    if ( context == MyKVOContext ) {
        if ( [object isEqual:self.mostRide] ) {
            if ( [keyPath isEqualToString:@"driverImage"] ) {
                self.driverImage.image = self.mostRide.driverImage;
            }
            else if ( [keyPath isEqualToString:@"Rating"] ) {
                // onSwitch is a UISwitch
                self.rate.text = self.mostRide.Rating;
            }
        }
    }
    else {
        // if the context doesn’t match, pass it up to super in case the superclass is observing this key path as well
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)prepareForReuse{
    [super prepareForReuse];
    if (self.mostRide) {
        [self.mostRide removeObserver:self.mostRide forKeyPath:@"driverImage"];
        [self.mostRide removeObserver:self.mostRide forKeyPath:@"Rating"];
    }
}

@end
