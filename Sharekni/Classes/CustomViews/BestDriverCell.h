//
//  BestDriverCell.h
//  Sharekni
//
//  Created by Ahmed Askar on 9/26/15.
//
//

#import <UIKit/UIKit.h>

@interface BestDriverCell : UITableViewCell

@property (nonatomic ,weak) IBOutlet UIImageView *driverImage ;
@property (nonatomic ,weak) IBOutlet UILabel *driverName ;
@property (nonatomic ,weak) IBOutlet UILabel *driverCountry ;

- (IBAction)sendMail:(id)sender ;
- (IBAction)call:(id)sender ;

@end
