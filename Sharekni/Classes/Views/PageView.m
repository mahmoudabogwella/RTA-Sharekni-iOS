//
//  PageView.m
//  KaizenCare
//
//  Created by Askar on 11/20/13.
//  Copyright (c) 2013 Askar. All rights reserved.
//

#import "PageView.h"
#import "Constants.h"

@implementation PageView

- (id)initWithFrame:(CGRect)frame tour:(Tour*)tour
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *backgroundImage = [[UIImageView alloc] init];
        backgroundImage.frame = frame ;
        backgroundImage.image = tour.image ;
        [self addSubview:backgroundImage];
    }
    return self ;
}

- (void)openLink:(id)sender
{
    NSString *link = linkable ;
    NSLog(@"link %@",link);
    NSURL *url = [NSURL URLWithString:link];
    [[UIApplication sharedApplication] openURL:url];
}

@end
