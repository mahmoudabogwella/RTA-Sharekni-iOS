//
//  MJDetailViewController.h
//  MJPopupViewControllerDemo
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJDetailPopupDelegate;

@interface MJDetailViewController : UIViewController
{
    __weak IBOutlet UIView *viewTextTwo;
    __weak IBOutlet UILabel *textTwo;
    __weak IBOutlet UILabel *textOne;
    __weak IBOutlet UIButton *closeBtn;
}

@property (assign, nonatomic) id <MJDetailPopupDelegate> delegate;

@property (nonatomic, strong) NSString *orderID ;

@end

@protocol MJDetailPopupDelegate<NSObject>

@optional

- (void)cancelButtonClicked:(MJDetailViewController*)DetailViewController;

@end
