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

@property (nonatomic,strong) NSString *fromEmirate;
@property (nonatomic,strong) NSString *fromRegion;
@property (nonatomic,strong) NSString *toEmirate;
@property (nonatomic,strong) NSString *toRegion;

@end
