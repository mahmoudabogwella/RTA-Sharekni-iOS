//
//  MapLookUp.h
//  Sharekni
//
//  Created by Ahmed Askar on 10/11/15.
//
//

#import <Foundation/Foundation.h>

@interface MapLookUp : NSObject


@property (nonatomic,strong) NSNumber *FromEmirateId;
@property (nonatomic,strong) NSString *FromEmirateNameAr;
@property (nonatomic,strong) NSString *FromEmirateNameEn;
@property (nonatomic,strong) NSString *FromEmirateNameFr;
@property (nonatomic,strong) NSString *FromEmirateNameCh;
@property (nonatomic,strong) NSString *FromEmirateNameUr;

@property (nonatomic,strong) NSNumber *FromRegionId;
@property (nonatomic,strong) NSString *FromRegionNameAr;
@property (nonatomic,strong) NSString *FromRegionNameEn;
@property (nonatomic,strong) NSString *FromRegionNameFr;
@property (nonatomic,strong) NSString *FromRegionNameCh;
@property (nonatomic,strong) NSString *FromRegionNameUr;

@property (nonatomic,strong) NSNumber *NoOfRoutes;
@property (nonatomic,strong) NSNumber *NoOfPassengers;
@property (nonatomic,strong) NSString *FromLat;
@property (nonatomic,strong) NSString *FromLng;
@end
