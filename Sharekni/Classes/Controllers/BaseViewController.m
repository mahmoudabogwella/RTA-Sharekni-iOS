//
//  BaseViewController.m
//  sharekni
//
//  Created by ITWORX on 10/31/15.
//
//

#import "BaseViewController.h"
#import <UIViewController+REFrostedViewController.h>
#import <REFrostedViewController.h>
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(menuItemTapped)];
    self.navigationItem.leftBarButtonItem = menuItem;
}

- (void) menuItemTapped{
    [self.frostedViewController presentMenuViewController];
}

@end
