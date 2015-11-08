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
@property (weak, nonatomic) IBOutlet UILabel *ridesLabel;
@property (weak, nonatomic) IBOutlet UILabel *passengersLabel;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *headerLabels;
@end
@implementation MapInfoWindow

-(instancetype)initWithArabicName:(NSString *)arabicName englishName:(NSString *)englishName rides:(NSString *)rides lat:(NSString *)lat lng:(NSString *)lng time:(NSString *)comingRides {
    self =  [[[NSBundle mainBundle] loadNibNamed:@"MapInfoWindow" owner:self options:nil] objectAtIndex:0];
    if (self) {
        self.arabicName = arabicName;
        self.englishName = englishName;
        self.lat = lat;
        self.lng = lng;
        self.rides = rides;
        self.comingRides = comingRides;
        [self configureUI];
    }
    return self;
}

- (void)configureUI{

        for (UILabel *label in self.headerLabels) {
            label.textColor = Red_UIColor;
        }
        self.arabicNameLabel.text = self.arabicName;
        self.englishNameLabel.text = self.englishName;
        self.ridesLabel.text = [NSString stringWithFormat:@"%@ Rides",self.rides];
        self.coordinatesLabel.text = [NSString stringWithFormat:@"%@ , %@",self.lat,self.lng];
        self.time.text = self.comingRides;
        self.containerView.layer.cornerRadius = 5;
}

@end
