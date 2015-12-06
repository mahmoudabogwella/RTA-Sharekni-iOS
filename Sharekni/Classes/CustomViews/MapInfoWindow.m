//
//  MapInfoWindow.m
//  sharekni
//
//  Created by Mohamed Abd El-latef on 11/6/15.
//
//

#import "MapInfoWindow.h"
#import <UIColor+Additions.h>
#import "Constants.h"
@interface MapInfoWindow ()
@property (weak, nonatomic) IBOutlet UILabel *englishNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *arabicNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *coordinatesLabel;
@property (weak, nonatomic) IBOutlet UILabel *driversLabel;
@property (weak, nonatomic) IBOutlet UILabel *passengersLabel;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *driverHeader;
@property (weak, nonatomic) IBOutlet UILabel *passengerHeader;
@property (weak, nonatomic) IBOutlet UILabel *ridesHeader;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *headerLabels;
@end
@implementation MapInfoWindow

-(instancetype)initWithArabicName:(NSString *)arabicName englishName:(NSString *)englishName passengers:(NSString *)passengers drivers:(NSString *)drivers lat:(NSString *)lat lng:(NSString *)lng time:(NSString *)comingRides {
    self =  [[[NSBundle mainBundle] loadNibNamed:@"MapInfoWindow" owner:self options:nil] objectAtIndex:0];
    if (self) {
        self.arabicName = arabicName;
        self.englishName = englishName;
        self.lat = [lat substringToIndex:6];
        self.lng = [lng substringToIndex:5];
        self.passengers = passengers;
        self.driversCount = drivers;
        self.comingRides = comingRides;
        [self configureUI];
    }
    return self;
}


- (void)configureUI
{
    self.layer.cornerRadius = 3.0f;
    
    self.driverHeader.text = NSLocalizedString(@"Drivers :", nil);
    self.passengerHeader.text = NSLocalizedString(@"Passengers :", nil);
    self.ridesHeader.text = NSLocalizedString(@"Coming Rides :", nil);
    
        for (UILabel *label in self.headerLabels) {
            label.textColor = Red_UIColor;
        }
        self.arabicNameLabel.text = self.arabicName;
        self.englishNameLabel.text = self.englishName;
        self.driversLabel.text = self.driversCount;
        self.coordinatesLabel.text = [NSString stringWithFormat:@"%@ , %@",self.lat,self.lng];
        self.time.text = self.comingRides;
        self.passengersLabel.text = self.passengers;
        self.containerView.layer.cornerRadius = 5;
}

@end
