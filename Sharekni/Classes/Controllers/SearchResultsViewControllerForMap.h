//
//  SearchResultsViewControllerForMap.h
//  sharekni
//
//  Created by killvak on 2/20/16.
//
//


#import <UIKit/UIKit.h>
#import "Emirate.h"
#import "Region.h"
#import "DriverDetails.h"

@interface SearchResultsViewControllerForMap : UIViewController

@property (nonatomic,strong) NSArray *results;

@property (nonatomic,strong) NSString *fromEmirate;
@property (nonatomic,strong) NSString *fromRegion;
@property (nonatomic,strong) NSString *toEmirate;
@property (nonatomic,strong) NSString *toRegion;

@property (nonatomic,strong) NSString *LanguageIs;

@property (nonatomic ,strong) DriverDetails *driverDetails;

@end