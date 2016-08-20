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
@property (weak, nonatomic) IBOutlet UILabel *passengerHeader;
@property (weak, nonatomic) IBOutlet UIView *UiGrayView;

@property (weak, nonatomic) IBOutlet UIImageView *CarIcon;

@property (weak, nonatomic) IBOutlet UILabel *driversLabel;
@property (weak, nonatomic) IBOutlet UILabel *driversLabel2;
@property (weak, nonatomic) IBOutlet UILabel *passengersLabel;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *GoogleMapItem;

@property (weak, nonatomic) IBOutlet UILabel *driverHeader;
@property (weak, nonatomic) IBOutlet UILabel *ridesHeader;
@property (weak, nonatomic) IBOutlet UILabel *NewPassengerNum4P;
@property (weak, nonatomic) IBOutlet UILabel *NewPssengerLab4P;
@property (weak, nonatomic) IBOutlet UIView *myView;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *headerLabels;
@end
@implementation MapInfoWindow

-(instancetype)initWithArabicName:(NSString *)arabicName englishName:(NSString *)englishName Type:(NSString *)Type passengers:(NSString *)passengers drivers:(NSString *)drivers lat:(NSString *)lat lng:(NSString *)lng time:(NSString *)comingRides {
    self =  [[[NSBundle mainBundle] loadNibNamed:@"MapInfoWindow" owner:self options:nil] objectAtIndex:0];
    if (self) {
        self.arabicName = arabicName;
        self.englishName = englishName;
        self.lat = [lat substringToIndex:6];
        self.lng = [lng substringToIndex:5];
        self.passengers = passengers;
        self.driversCount = drivers;
        self.comingRides = comingRides;
        self.Type = Type;
        
        if ([self.Type isEqual:@"Passenger"]) {

            CGRect newFrame = self.myView.frame;
            
            newFrame.size.height = 140;
            [self setFrame:newFrame];
            
            self.NewPassengerNum4P.hidden = false;
            self.NewPssengerLab4P.hidden = false;
            _UiGrayView.hidden = false;
            self.time.hidden = true;
            self.driverHeader.hidden = true;
            self.CarIcon.hidden = true;
            self.driversLabel.hidden = true;
            self.driversLabel2.hidden = true;
            self.ridesHeader.hidden = true;
            self.CarIcon.hidden = true;
        }
        [self configureUI];
    }
    return self;
}


- (void)configureUI
{
    self.layer.cornerRadius = 15.0f;
    
    self.driverHeader.text = GET_STRING(@"Drivers :");
    self.passengerHeader.text = GET_STRING(@"Passengers :");
    self.ridesHeader.text = GET_STRING(@"Coming Rides :");
    
    
    
    for (UILabel *label in self.headerLabels)
    {
        label.textColor = Red_UIColor;
    }
    self.arabicNameLabel.text = self.arabicName;
    self.englishNameLabel.text = self.englishName;
    self.driversLabel.text = self.driversCount;
    self.driversLabel2.text = self.driversCount;
    self.coordinatesLabel.text = [NSString stringWithFormat:@"%@ , %@",self.lat,self.lng];
    self.time.text = self.comingRides;
    self.passengersLabel.text = self.passengers;
    self.containerView.layer.cornerRadius = 7;
    self.containerView.layer.borderWidth = 2 ;
    self.containerView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.NewPassengerNum4P.text = self.passengers;
    if ([self.Type isEqual:@"Passenger"]) {
        self.containerView.layer.borderColor = [[UIColor clearColor] CGColor];

    }

}

@end
