//
//  MostRideDetailsForMap.m
//  sharekni
//
//  Created by killvak on 2/20/16.
//
//


#import "MostRideDetailsForMap.h"
#import "MasterDataManager.h"
#import "RZDataBinding.h"
#import "Constants.h"

static void* const MyKVOContext = (void *)&MyKVOContext;

@implementation MostRideDetailsForMap

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (IDIOM == IPAD) {
        if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        {
            self = (MostRideDetailsForMap *)[[[NSBundle mainBundle] loadNibNamed:@"MostRideDetailsForMap_Ipad" owner:nil options:nil] objectAtIndex:(KIS_ARABIC)?1:0];
            self.driverImage.layer.cornerRadius = self.driverImage.frame.size.width / 2.0f ;
            self.driverImage.clipsToBounds = YES ;
        }
    }else {
        if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        {
            self = (MostRideDetailsForMap *)[[[NSBundle mainBundle] loadNibNamed:@"MostRideDetailsForMap" owner:nil options:nil] objectAtIndex:(KIS_ARABIC)?1:0];
            self.driverImage.layer.cornerRadius = self.driverImage.frame.size.width / 2.0f ;
            self.driverImage.clipsToBounds = YES ;
        }
    }
   
    
    
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    self.driverImage.layer.cornerRadius = self.driverImage.frame.size.width / 2.0f ;
    self.driverImage.clipsToBounds = YES ;
    [_InviteButton setTitle:GET_STRING(@"Invite") forState:UIControlStateNormal ];
}

- (void)setMostRide:(MostRideDetailsDataForPassenger *)mostRide
{
    _mostRide = mostRide;
    self.driverName.text = mostRide.PassengerName ;
    self.country.text = [NSString stringWithFormat:@"%@" , mostRide.DriverInvitationStatus];
    NSLog(@"DriverInvitaion is : %@",self.country.text);
    //GonMake LastSeen Hidden
    self.driverImage.image = mostRide.PassengerImage;
    self.startingTime.text = [NSString stringWithFormat:@"%@",mostRide.AccountId];
    self.availableDays.text = [self getAvailableDays:mostRide];
    self.rate.text = mostRide.Rating;
    self.phone = mostRide.PassengerMobile ;
    [self.mostRide rz_addTarget:self action:@selector(imageChanged) forKeyPathChange:@"driverImage" callImmediately:YES];
    [self.mostRide rz_addTarget:self action:@selector(ratingChanged) forKeyPathChange:@"Rating" callImmediately:YES];
}

- (void)setDriver:(DriverSearchResult *)driver
{
    _InviteButton.hidden  = YES;
    _driver = driver;
    self.driverImage.image = driver.driverImage;
    
    self.driverName.text = driver.AccountName;
    self.country.text = (KIS_ARABIC)?driver.Nationality_ar:driver.Nationality_en;
    self.LastSeen.text = driver.LastSeen;
    self.phone = driver.AccountMobile ;
    self.startingTime.text = [NSString stringWithFormat:@"%@ %@",GET_STRING(@"Starting Time :"),driver.SDG_Route_Start_FromTime];
    
    NSString *daysText = @"";
    if (driver.SDG_RouteDays_Sunday.boolValue) {
        daysText = [daysText stringByAppendingString:GET_STRING(@"Sun ")];
    }
    if (driver.SDG_RouteDays_Monday.boolValue) {
        daysText = [daysText stringByAppendingString:GET_STRING(@"Mon ")];
    }
    if (driver.SDG_RouteDays_Tuesday.boolValue) {
        daysText = [daysText stringByAppendingString:GET_STRING(@"Tue ")];
    }
    if (driver.SDG_RouteDays_Wednesday.boolValue) {
        daysText = [daysText stringByAppendingString:GET_STRING(@"Wed ")];
    }
    if (driver.SDG_RouteDays_Thursday.boolValue) {
        daysText = [daysText stringByAppendingString:GET_STRING(@"Thu ")];
    }
    if (driver.SDG_RouteDays_Friday.boolValue) {
        daysText = [daysText stringByAppendingString:GET_STRING(@"Fri ")];
    }
    if (driver.Saturday.boolValue) {
        daysText = [daysText stringByAppendingString:GET_STRING(@"Sat ")];
    }
    if (daysText.length > 0) {
        self.availableDays.text = daysText;
    }
    
    [self.mostRide rz_addTarget:self action:@selector(imageChanged) forKeyPathChange:@"driverImage" callImmediately:YES];
    [self.mostRide rz_addTarget:self action:@selector(ratingChanged) forKeyPathChange:@"Rating" callImmediately:YES];
}

- (void) imageChanged
{
    if(self.mostRide)
    {
        self.driverImage.image = self.mostRide.PassengerImage;
    }
    else if (self.driver)
    {
        self.driverImage.image = self.driver.driverImage;
    }
    if (self.reloadHandler)
    {
        self.reloadHandler();
    }
}

- (void) ratingChanged
{
    if(self.mostRide)
    {
        self.rate.text = self.mostRide.Rating;
    }
    else if (self.driver)
    {
        self.rate.text = self.driver.Rating;
    }
    if (self.reloadHandler)
    {
        self.reloadHandler();
    }
}

- (IBAction)sendMail:(id)sender
{
    //    [self.delegate sendSMSFromPhone:self.phone];
}

- (IBAction)call:(id)sender
{
    [self.delegate callPhone:self.phone];
}

- (NSString *)getAvailableDays:(MostRideDetailsDataForPassenger *)mostRide{
    NSMutableString *str = [[NSMutableString alloc] init];
    
    if (mostRide.Saturday.boolValue) {
        [str appendString:GET_STRING(@"Sat ")];
    }
    if (mostRide.Sunday.boolValue) {
        [str appendString:GET_STRING(@"Sun ")];
    }
    if (mostRide.Monday.boolValue) {
        [str appendString:GET_STRING(@"Mon ")];
    }
    if (mostRide.Tuesday.boolValue) {
        [str appendString:GET_STRING(@"Tue ")];
    }
    if (mostRide.Wendenday.boolValue) {
        [str appendString:GET_STRING(@"Wed ")];
        
    }
    if (mostRide.Thrursday.boolValue) {
        [str appendString:GET_STRING(@"Thu ")];
        
    }
    if (mostRide.Friday.boolValue) {
        [str appendString:GET_STRING(@"Fri ")];
    }
    
    return str ;
}

@end
