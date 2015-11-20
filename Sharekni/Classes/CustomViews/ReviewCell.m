//
//  ReviewCell.m
//  sharekni
//
//  Created by Ahmed Askar on 11/4/15.
//
//

#import "ReviewCell.h"

@implementation ReviewCell

- (void)awakeFromNib {
    // Initialization code
    self.driverPhoto.layer.cornerRadius = self.driverPhoto.frame.size.width / 2.0f ;
    self.driverPhoto.clipsToBounds = YES ;
    self.bgView.layer.cornerRadius = 3.0f;
}

- (void)setReview:(Review *)review
{
    self.driverPhoto.image = [UIImage imageNamed:@"BestDriverImage"];
    self.driverName.text = review.AccountName ;
    self.nationality.text = review.AccountNationalityEn ;
//    self.comment.text = review.Review ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
