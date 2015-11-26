//
//  MapInfoWindow.h
//  sharekni
//
//  Created by Mohamed Abd El-latef on 11/6/15.
//
//

#import <UIKit/UIKit.h>

@interface MapInfoWindow : UIView
@property (nonatomic,strong) NSString *arabicName;
@property (nonatomic,strong) NSString *englishName;
@property (nonatomic,strong) NSString *lat;
@property (nonatomic,strong) NSString *lng;
@property (nonatomic,strong) NSString *driversCount;
@property (nonatomic,strong) NSString *passengers;
@property (nonatomic,strong) NSString *comingRides;

-(instancetype)initWithArabicName:(NSString *)arabicName englishName:(NSString *)englishName passengers:(NSString *)passengers drivers:(NSString *)drivers lat:(NSString *)lat lng:(NSString *)lng time:(NSString *)comingRides ;
@end
