//
//  BestDriver.h
//  Sharekni
//
//  Created by Ahmed Askar on 10/9/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BestDriver : NSObject

@property (nonatomic,strong) NSString *AccountId;
@property (nonatomic,strong) NSString *AccountName;
@property (nonatomic,strong) NSString *AccountPhoto;
@property (nonatomic,strong) NSString *AccountMobile;
@property (nonatomic,strong) NSString *NationalityArName;
@property (nonatomic,strong) NSString *NationalityEnName;
@property (nonatomic,strong) NSString *NationalityFrName;
@property (nonatomic,strong) NSString *NationalityChName;
@property (nonatomic,strong) NSString *NationalityUrName;
@property (nonatomic,strong) NSString* Rating;

@property (nonatomic ,strong) UIImage *image ;
@property (nonatomic ,strong) NSString *imagePath ;

//GreenPoint
@property (nonatomic,strong) NSNumber *GreenPoints;
@property (nonatomic,strong) NSNumber *CO2Saved;

//LastSeen
@property (nonatomic,strong) NSString* LastSeen;


@end