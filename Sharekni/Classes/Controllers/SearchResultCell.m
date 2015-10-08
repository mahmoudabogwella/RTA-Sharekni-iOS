//
//  SearchResultCell.m
//  Sharekni
//
//  Created by ITWORX on 10/4/15.
//
//

#import "SearchResultCell.h"
#import <UIColor+Additions.h>
#import "Constants.h"
#import <LRImageManager.h>
#import <UIImageView+LRNetworking.h>
@implementation SearchResultCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
    self.profileImage.clipsToBounds = YES;
    
    self.historyButton.layer.cornerRadius = 8;
    self.reviewsButton.layer.cornerRadius = 8;
    
    [self.historyButton setBackgroundColor:Red_UIColor];
    [self.reviewsButton setBackgroundColor:Red_UIColor];
    [self.historyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.reviewsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.daysLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    self.nationalityLabel.textColor = [UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setItem:(DriverSearchResult *)item{
    _item = item;
}


@end
