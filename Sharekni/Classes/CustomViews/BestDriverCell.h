//
//  BestDriverCell.h
//  Sharekni
//
//  Created by Ahmed Askar on 9/26/15.
//
//

#import <UIKit/UIKit.h>
#import "BestDriver.h"

@protocol SendSMSDelegate <NSObject>
- (void)sendSMSFromPhone:(NSString *)phone;
@end

@interface BestDriverCell : UITableViewCell

@property (nonatomic ,weak) id <SendSMSDelegate> delegate ;

@property (nonatomic ,weak) IBOutlet UIImageView *driverImage ;
@property (nonatomic ,weak) IBOutlet UILabel *driverName ;
@property (nonatomic ,weak) IBOutlet UILabel *driverCountry ;

@property (nonatomic ,strong) NSString *phone;

- (IBAction)sendMail:(id)sender ;
- (IBAction)call:(id)sender ;

- (void)setDriver:(BestDriver *)driver;

@end
