//
//  MapLookupViewController.h
//  Sharekni
//
//  Created by Mohamed Abd El-latef on 10/18/15.
//
//

#import <UIKit/UIKit.h>

@interface MapLookupViewController : UIViewController
//@property (weak, nonatomic) IBOutlet UISegmentedControl *TheMapSwitcherOutLet;
@property (weak, nonatomic) IBOutlet UIButton *TheMapSwitcherOutLet;


@property (strong , nonatomic) NSString * MapDeciderForSwitch ;
@property (assign, nonatomic)  BOOL MapDeciderSwitchBoolean;

@end
