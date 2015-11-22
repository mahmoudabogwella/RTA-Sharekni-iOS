//
//  PassengerCell.m
//  sharekni
//
//  Created by Mohamed Abd El-latef on 11/22/15.
//
//

#import "PassengerCell.h"

@implementation PassengerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)messageHandler:(id)sender {
    if (self.messageHandler) {
        self.messageHandler();
    }
}
- (IBAction)ratingHandler:(id)sender {
    if (self.ratingHandler) {
        self.ratingHandler();
    }
}
- (IBAction)deleteHandler:(id)sender {
    if (self.deleteHandler) {
        self.deleteHandler();
    }
}
- (IBAction)callHandler:(id)sender {
    if (self.callHandler) {
        self.callHandler();
    }
}

@end
