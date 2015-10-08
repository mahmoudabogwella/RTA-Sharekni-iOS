//
//  SearchResultsViewController.h
//  Sharekni
//
//  Created by ITWORX on 10/4/15.
//
//

#import <UIKit/UIKit.h>
#import "Emirate.h"
#import "Region.h"
@interface SearchResultsViewController : UIViewController

@property (nonatomic,strong) NSArray *results;
@property (nonatomic,strong) Emirate *fromEmirate;
@property (nonatomic,strong) Region *fromRegion;
@property (nonatomic,strong) Emirate *toEmirate;
@property (nonatomic,strong) Region *toRegion;

@end
