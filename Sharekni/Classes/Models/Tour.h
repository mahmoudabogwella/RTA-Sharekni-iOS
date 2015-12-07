//
//  Tour.h
//  KaizenCare
//
//  Created by Askar on 11/20/13.
//  Copyright (c) 2013 Askar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tour : NSObject

@property (nonatomic , copy , readonly) UIImage *image ;

+ (Tour *)getInstance ;
- (id)initWithImage:(UIImage *)image ;
- (NSArray *)getTourImages ;

@end
