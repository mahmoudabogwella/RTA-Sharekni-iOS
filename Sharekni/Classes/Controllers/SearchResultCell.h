//
//  SearchResultCell.h
//  Sharekni
//
//  Created by ITWORX on 10/4/15.
//
//

#import <UIKit/UIKit.h>
#define SearchResultCell_ID @"SearchResultCell"
#define SearchResultCell_HEIGHT 100

#import "DriverSearchResult.h"

@protocol SendSMSSearchResultDelegate <NSObject>

- (void)sendSMSFromPhone:(NSString *)phone;

@end


@interface SearchResultCell : UITableViewCell

@property (nonatomic ,weak) id <SendSMSSearchResultDelegate> delegate ;

@property (nonatomic,strong) DriverSearchResult *item;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *reviewsButton;
@property (weak, nonatomic) IBOutlet UILabel *nationalityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *callIcon;
@property (weak, nonatomic) IBOutlet UIButton *historyButton;
@property (weak, nonatomic) IBOutlet UIImageView *messageIcon;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (nonatomic ,strong) NSString *phone;

@end
