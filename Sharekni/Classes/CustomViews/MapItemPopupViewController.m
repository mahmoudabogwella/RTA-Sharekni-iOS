//
//  MapItemPopupViewController.m
//  Sharekni
//
//  Created by Mohamed Abd El-latef on 10/18/15.
//
//

#import "MapItemPopupViewController.h"
#import <UIColor+Additions.h>
#import "Constants.h"
@interface MapItemPopupViewController ()
@property (weak, nonatomic) IBOutlet UILabel *englishNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *arabicNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *coordinatesLabel;
@property (weak, nonatomic) IBOutlet UILabel *ridesLabel;
@property (weak, nonatomic) IBOutlet UILabel *passengersLabel;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *headerLabels;
@end

@implementation MapItemPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UILabel *label in self.headerLabels) {
        label.textColor = Red_UIColor;
    }
    self.arabicNameLabel.text = self.arabicName;
    self.englishNameLabel.text = self.englishName;
    self.ridesLabel.text = self.rides;
    self.coordinatesLabel.text = [NSString stringWithFormat:@"%@ , %@",self.lat,self.lng];
    self.time.text = self.comingRides;
    self.containerView.layer.cornerRadius = 5;
}

@end
