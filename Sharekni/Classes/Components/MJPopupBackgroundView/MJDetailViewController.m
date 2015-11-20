//
//  MJDetailViewController.m
//  MJPopupViewControllerDemo
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import "MJDetailViewController.h"
#import "LanguageModel.h"

@implementation MJDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 3.0f;
    viewTextTwo.layer.cornerRadius = 3.0f;
    closeBtn.layer.cornerRadius = 3.0f;
    closeBtn.clipsToBounds = YES ;
    [closeBtn setTitle:NSLocalizedString(@"ok", nil) forState:UIControlStateNormal];
    if ([[[LanguageModel sharedObject] currentLanguageShortName]  isEqual:@"ar"])
    {
        textOne.font = [UIFont fontWithName:@"GESSTwoBold-Bold" size:17.0f];
    }
    textOne.textAlignment = NSTextAlignmentNatural ;
    textTwo.textAlignment = NSTextAlignmentNatural ;
    textOne.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"addOrderSuccess", nil),self.orderID];
    textTwo.text = NSLocalizedString(@"addOrderSuccessMsg", nil);
}

- (IBAction)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}

@end