//
//  PageView.h
//  KaizenCare
//
//  Created by Askar on 11/20/13.
//  Copyright (c) 2013 Askar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tour.h"

@interface PageView : UIView
{
    NSString *linkable ;
}

- (id)initWithFrame:(CGRect)frame tour:(Tour*)tour;

@end
