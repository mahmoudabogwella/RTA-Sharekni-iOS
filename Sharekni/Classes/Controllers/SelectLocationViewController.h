//
//  selectLocationViewController.h
//  Sharekni
//
//  Created by ITWORX on 10/7/15.
//
//

#import <UIKit/UIKit.h>
#import "Emirate.h"
#import "Region.h"
@interface SelectLocationViewController : UIViewController
{
    float animatedDistance ;
}
@property (nonatomic,strong) NSString *viewTitle;
@property (strong, nonatomic) void (^selectionHandler) (Emirate*,Region*,Emirate*,Region*) ;
@property (nonatomic,assign) BOOL validateDestination;

@end
