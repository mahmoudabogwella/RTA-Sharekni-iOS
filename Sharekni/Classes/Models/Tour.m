//
//  Tour.m
//  KaizenCare
//
//  Created by Askar on 11/20/13.
//  Copyright (c) 2013 Askar. All rights reserved.
//

#import "Tour.h"
#import "Constants.h"

#define IMAGESCOUNT 6

Tour *tourInstance = nil ;

@implementation Tour

- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self)
    {
        _image = image ;
    }
    return self ;
}

+ (Tour *)getInstance
{
    if (tourInstance == nil) {
        tourInstance = [[Tour alloc] init];
    }
    return tourInstance ;
}

- (NSArray *)getTourImages
{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];

    for (int i = 0; i < IMAGESCOUNT; i++)
    {
        NSString *imageName = [NSString stringWithFormat:(KIS_ARABIC)?@"tourar_%d":@"touren_%d",i];
        UIImage *image = [UIImage imageNamed:imageName];
        Tour *tourObject = [[Tour alloc] initWithImage:image];
        [resultArray addObject:tourObject];
    }
    return resultArray ;
}

@end
