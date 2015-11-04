//
//  MostRide.h
//  Sharekni
//
//  Created by Ahmed Askar on 10/10/15.
//
//

#import <Foundation/Foundation.h>

@interface MostRide : NSObject

@property (nonatomic,strong) NSString *FromEmirateNameAr;
@property (nonatomic,strong) NSString *FromEmirateNameEn;
@property (nonatomic,strong) NSString *FromRegionNameAr;
@property (nonatomic,strong) NSString *FromRegionNameEn;
@property (nonatomic,strong) NSString *ToEmirateNameAr;
@property (nonatomic,strong) NSString *ToEmirateNameEn;
@property (nonatomic,strong) NSString *ToRegionNameAr;
@property (nonatomic,strong) NSString *ToRegionNameEn;

@property (nonatomic,strong) NSString *FromEmirateId;
@property (nonatomic,strong) NSString *ToEmirateId;
@property (nonatomic,strong) NSString *FromRegionId;
@property (nonatomic,strong) NSString *ToRegionId;

@property (nonatomic,assign) long RoutesCount;

@end