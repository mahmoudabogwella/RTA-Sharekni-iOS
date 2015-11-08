//
//  BestDriverCell.m
//  Sharekni
//
//  Created by Ahmed Askar on 9/26/15.
//
//

#import "BestDriverCell.h"

@implementation BestDriverCell

- (void)awakeFromNib
{
    // Initialization code
    self.driverImage.layer.cornerRadius = self.driverImage.frame.size.width / 2.0f ;
    self.driverImage.clipsToBounds = YES ;
}

- (void)setDriver:(BestDriver *)driver
{
    self.driverName.text = driver.AccountName ;
    self.driverCountry.text = driver.NationalityEnName ;
    self.driverImage.image = [UIImage imageNamed:@"BestDriverImage"];
    self.phone = driver.AccountMobile ;
    self.rateLbl.text = [NSString stringWithFormat:@"%ld",driver.Rating];
}

- (IBAction)sendMail:(id)sender
{
    [self.delegate sendSMSFromPhone:self.phone];
}

- (IBAction)call:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"tel:%@",self.phone]]];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
