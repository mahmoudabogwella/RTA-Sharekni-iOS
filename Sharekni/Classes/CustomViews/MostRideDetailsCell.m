    //
//  MostRideDetailsCell.m
//  sharekni
//
//  Created by Ahmed Askar on 10/31/15.
//
//

#import "MostRideDetailsCell.h"
#import "MasterDataManager.h"
#import "RZDataBinding.h"
#import "Constants.h"

static void* const MyKVOContext = (void *)&MyKVOContext;

@implementation MostRideDetailsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        if (IDIOM == IPAD) {
            self = (MostRideDetailsCell *)[[[NSBundle mainBundle] loadNibNamed:@"MostRideDetailsCell_Ipad" owner:nil options:nil] objectAtIndex:(KIS_ARABIC)?1:0];
            self.driverImage.layer.cornerRadius = self.driverImage.frame.size.width / 2.0f ;
            self.driverImage.clipsToBounds = YES ;
            
        }else {
            self = (MostRideDetailsCell *)[[[NSBundle mainBundle] loadNibNamed:@"MostRideDetailsCell" owner:nil options:nil] objectAtIndex:(KIS_ARABIC)?1:0];
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
}

- (void)setMostRide:(MostRideDetails *)mostRide
{
    _mostRide = mostRide;
    self.driverName.text = mostRide.DriverName ;
    self.country.text = (KIS_ARABIC)?mostRide.NationalityArName:mostRide.NationlityEnName ;
    
    //GonMake LastSeen Hidden
//    _HideLastSeen.hidden = YES;
    self.LastSeen.text = mostRide.LastSeen;

    //GreenPoint
    NSNumber *test = mostRide.GreenPoints;
    NSNumber *test4 = mostRide.CO2Saved;
    
    int number = [test4 intValue];
    NSLog(@"CO2 Saved BEfore : %d",number);
    int Co2Saved = (number/1000);
    NSLog(@"CO2 Saved BEfore : %d",Co2Saved);
    
    NSString *StringScorePlayer = [test stringValue];
    NSString *StringScorePlayer4 = [NSString stringWithFormat:@"%d",Co2Saved];
    
    self.GreenPointPoints.text = StringScorePlayer;
    self.GreenPointCo2Saving.text = StringScorePlayer4;
    
//    if (([self.GreenPointCo2Saving.text length] > 5) ){
//        // User cannot type more than 15 characters
//        self.GreenPointCo2Saving.text = [self.GreenPointCo2Saving.text substringToIndex:5];
//    } else if (([self.GreenPointPoints.text length] > 4) ){
//        // User cannot type more than 15 characters
//        self.GreenPointPoints.text = [self.GreenPointPoints.text substringToIndex:4];
//    }
    
    self.driverImage.image = mostRide.driverImage;
    self.startingTime.text = [NSString stringWithFormat:@"%@ %@",GET_STRING(@"Starting Time :"),mostRide.StartTime];
    self.availableDays.text = [self getAvailableDays:mostRide];
    self.rate.text = mostRide.Rating;
    self.phone = mostRide.DriverMobile ;
    [self.mostRide rz_addTarget:self action:@selector(imageChanged) forKeyPathChange:@"driverImage" callImmediately:YES];
    [self.mostRide rz_addTarget:self action:@selector(ratingChanged) forKeyPathChange:@"Rating" callImmediately:YES];
}

- (void)setDriver:(DriverSearchResult *)driver
{
    _driver = driver;
    _HideLastSeen.hidden = NO;
    self.driverImage.image = driver.driverImage;
    //GreenPoint
    NSNumber *test = driver.GreenPoints;
    NSNumber *test4 = driver.CO2Saved;
    
    NSString *StringScorePlayer = [test stringValue];
    NSString *StringScorePlayer4 = [test4 stringValue];
    
    self.GreenPointCo2Saving.text = StringScorePlayer;
    self.GreenPointPoints.text = StringScorePlayer4;
    
    
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
        self.driverImage.image = self.mostRide.driverImage;
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
    [self.delegate sendSMSFromPhone:self.phone];
}

- (IBAction)call:(id)sender
{
    [self.delegate callPhone:self.phone];
}

- (NSString *)getAvailableDays:(MostRideDetails *)mostRide{
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
