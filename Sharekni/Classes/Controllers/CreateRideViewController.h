//
//  CreateRideViewController.h
//  sharekni
//
//  Created by Mohamed Abd El-latef on 10/24/15.
//
//

#import <UIKit/UIKit.h>
#import "CreateRideViewController.h"
#import "CreatedRide.h"

@interface CreateRideViewController : UIViewController

@property (nonatomic,strong) CreatedRide *ride;
@property (nonatomic, copy) void (^doneHandler)(void);

@end
