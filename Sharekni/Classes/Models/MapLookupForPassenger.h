//
//  MapLookupForPassenger.h
//  sharekni
//
//  Created by killvak on 2/18/16.
//
//

#import <Foundation/Foundation.h>

@interface MapLookupForPassenger : NSObject


@property (nonatomic,strong) NSNumber *FromEmirateId;
@property (nonatomic,strong) NSString *FromEmirateArName;
@property (nonatomic,strong) NSString *FromEmirateEnName;
@property (nonatomic,strong) NSString *FromEmirateNameFr;
@property (nonatomic,strong) NSString *FromEmirateNameCh;
@property (nonatomic,strong) NSString *FromEmirateNameUr;

@property (nonatomic,strong) NSNumber *FromRegionId;
@property (nonatomic,strong) NSString *FromRegionArName;
@property (nonatomic,strong) NSString *FromRegionEnName;
@property (nonatomic,strong) NSString *FromRegionNameFr;
@property (nonatomic,strong) NSString *FromRegionNameCh;
@property (nonatomic,strong) NSString *FromRegionNameUr;

@property (nonatomic,strong) NSNumber *NoOfRoutes;
@property (nonatomic,strong) NSNumber *PassengersCount;
@property (nonatomic,strong) NSString *FromLat;
@property (nonatomic,strong) NSString *FromLng;

//@property (nonatomic,strong) NSString *FromEmirateName;
//@property (nonatomic,strong) NSString *FromRegionName;
//NewMap
@property (nonatomic,strong) NSString *ToEmirateId;
@property (nonatomic,strong) NSString *ToRegionId;
@property (nonatomic,strong) NSString *DriverRouteId;



@end
