//
//  Review.h
//  sharekni
//
//  Created by Ahmed Askar on 11/4/15.
//
//

#import <Foundation/Foundation.h>

@interface Review : NSObject

@property (nonatomic,strong) NSString *ReviewId;
@property (nonatomic,strong) NSString *Review;
@property (nonatomic,strong) NSString *AccountId;
@property (nonatomic,strong) NSString *AccountName;
@property (nonatomic,strong) NSString *AccountPhoto;
@property (nonatomic,strong) NSString *AccountNationalityAr;
@property (nonatomic,strong) NSString *AccountNationalityEn;
@property (nonatomic,strong) NSString *AccountNationalityFr;
@property (nonatomic,strong) NSString *AccountNationalityUr;
@property (nonatomic,strong) NSString *AccountNationalityCh;

@end