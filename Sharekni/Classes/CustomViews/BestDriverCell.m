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

- (void)setDriver:(NSString *)name andCountry:(NSString *)country
{
    self.driverName.text = name ;
    self.driverCountry.text = country ;
}

- (IBAction)sendMail:(id)sender
{

}

- (IBAction)call:(id)sender
{


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
