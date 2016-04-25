//
//  PermitCell.h
//  sharekni
//
//  Created by Ahmed Askar on 11/22/15.
//
//

#import <UIKit/UIKit.h>
#import "Permit.h"

@interface PermitCell : UITableViewCell

@property (nonatomic ,weak) IBOutlet UILabel *routeName ;
@property (nonatomic ,weak) IBOutlet UILabel *passengerNo ;
@property (nonatomic ,weak) IBOutlet UILabel *issueDate ;
@property (nonatomic ,weak) IBOutlet UILabel *expireDate ;
@property (nonatomic ,weak) IBOutlet UIView *containerView ;
- (void)setPermit:(Permit *)permit ;

@end
