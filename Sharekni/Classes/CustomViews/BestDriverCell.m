//
//  BestDriverCell.m
//  Sharekni
//
//  Created by Ahmed Askar on 9/26/15.
//
//

#import "BestDriverCell.h"
#import "RZDataBinding.h"
#import "Constants.h"

@implementation BestDriverCell

- (void)awakeFromNib
{
    // Initialization code
    self.driverImage.layer.cornerRadius = self.driverImage.frame.size.width / 2.0f ;
    self.driverImage.clipsToBounds = YES ;
    self.CO2.text = GET_STRING(@"Co2 Saving");

    self.TLastSeen.text = GET_STRING(@"Last Seen");
    self.TPoints.text = GET_STRING(@"Points");
}

- (void)setDriver:(BestDriver *)driver
{
    _driver = driver;
    self.driverName.text = driver.AccountName ;
    self.driverCountry.text = (KIS_ARABIC)?driver.NationalityArName:driver.NationalityEnName ;
    self.LastSeen.text = driver.LastSeen;
    //GreenPoint
    NSNumber *test = driver.GreenPoints;
    NSNumber *test4 = driver.CO2Saved;
    
    int number = [test4 intValue];
    NSLog(@"CO2 Saved BEfore : %d",number);
    int Co2Saved = (number/1000);
    NSLog(@"CO2 Saved BEfore : %d",Co2Saved);
    
    NSString *StringScorePlayer = [test stringValue];
    NSString *StringScorePlayer4 = [NSString stringWithFormat:@"%d",Co2Saved];
    
    self.GreenPointPoints.text =  StringScorePlayer;
    self.GreenPointCo2.text = StringScorePlayer4;
    
//    if (([self.GreenPointCo2.text length] > 2) ){
//        // User cannot type more than 15 characters
//        self.GreenPointCo2.text = [self.GreenPointCo2.text substringToIndex:5];
//    } else if (([self.GreenPointPoints.text length] > 5) ){
//        // User cannot type more than 15 characters
//        self.GreenPointPoints.text = [self.GreenPointPoints.text substringToIndex:5];
//    }
    
    NSLog(@"GreenPoint : %@ and %@", StringScorePlayer,StringScorePlayer4);

    if (driver.image) {
        self.driverImage.image = self.driver.image;
    }
    else{
        self.driverImage.image = [UIImage imageNamed:@"thumbnail.png"];
        [self.driver rz_addTarget:self action:@selector(imageChanged) forKeyPathChange:@"driverImage" callImmediately:YES];
    }
   [self.driver rz_addTarget:self action:@selector(RatingChanged) forKeyPathChange:@"Rating" callImmediately:YES];
    self.phone = driver.AccountMobile ;
}

- (void) imageChanged{
     self.driverImage.image = self.driver.image;
}
- (void) RatingChanged{
     self.rateLbl.text = self.driver.Rating;
}


- (IBAction)sendMail:(id)sender
{
    [self.delegate sendSMSFromPhone:self.phone];
}

- (IBAction)call:(id)sender
{
    [self.delegate callMobileNumber:self.phone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
