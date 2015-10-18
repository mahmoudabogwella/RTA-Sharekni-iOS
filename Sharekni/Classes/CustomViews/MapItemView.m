//
//  ServiceCenterView.m
//  Warshety
//
//  Created by Mohamed Abd El-latef on 11/4/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "MapItemView.h"
#import "HelpManager.h"
@interface MapItemView()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;
@end

@implementation MapItemView
- (instancetype) initWithLat:(NSString *)lat lng:(NSString *)lng address:(NSString *)address name:(NSString *)name{
    if (self = [super init]) {
        self.name = name;
        self.address = address;
        self.theCoordinate = CLLocationCoordinate2DMake(lat.floatValue, lng.floatValue);
        self.lat = lat;
        self.lng = lng;
    }
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _address;
}

- (CLLocationCoordinate2D)coordinate {
    return _theCoordinate;
}

@end
