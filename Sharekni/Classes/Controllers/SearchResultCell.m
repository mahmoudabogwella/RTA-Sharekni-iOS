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
#import "MasterDataManager.h"
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
    
    [[MasterDataManager sharedMasterDataManager] GetPhotoWithName:item.AccountPhoto withSuccess:^(UIImage *image, NSString *filePath) {
        
    } Failure:^(NSString *error) {
        
    }];
    
    self.nameLabel.text = item.AccountName;
    self.nationalityLabel.text = item.Nationality_ar;
    
    NSString *daysText = @"";
    if (item.SDG_RouteDays_Sunday.boolValue) {
        daysText = [daysText stringByAppendingString:NSLocalizedString(@"Sun,", nil)];
    }
    
    if (item.SDG_RouteDays_Monday.boolValue) {
        daysText = [daysText stringByAppendingString:NSLocalizedString(@"Mon,", nil)];
    }
    if (item.SDG_RouteDays_Monday.boolValue) {
        daysText = [daysText stringByAppendingString:NSLocalizedString(@"Mon,", nil)];
    }
    if (item.SDG_RouteDays_Tuesday.boolValue) {
        daysText = [daysText stringByAppendingString:NSLocalizedString(@"Mon,", nil)];
    }
    if (item.SDG_RouteDays_Wednesday.boolValue) {
        daysText = [daysText stringByAppendingString:NSLocalizedString(@"Mon,", nil)];
    }
    if (item.SDG_RouteDays_Thursday.boolValue) {
        daysText = [daysText stringByAppendingString:NSLocalizedString(@"Mon,", nil)];
    }
    if (item.SDG_RouteDays_Friday.boolValue) {
        daysText = [daysText stringByAppendingString:NSLocalizedString(@"Mon,", nil)];
    }
    if (item.SDG_RouteDays_Thursday.boolValue) {
        daysText = [daysText stringByAppendingString:NSLocalizedString(@"Mon,", nil)];
    }
    
}


@end
