//
//  MapLookupViewController.m
//  Sharekni
//
//  Created by Mohamed Abd El-latef on 10/18/15.
//
//

#import "MapLookupViewController.h"
#import <MapKit/MapKit.h>
#import "MobDriverManager.h"
#import <KVNProgress.h>
#import "MapLookUp.h"
#import <WYPopoverController.h>
#import "MapItemView.h"
#import "MapItemPopupViewController.h"
#import "MapInfoWindow.h"
@import GoogleMaps;
@interface MapLookupViewController ()<GMSMapViewDelegate>
{
    GMSMapView *mapView_;    
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) NSArray *mapLookups;
@property (nonatomic,strong) WYPopoverController *popover;
@property (nonatomic,strong) NSMutableArray *markers;
@end

@implementation MapLookupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Map Lookup", nil);
    
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    [self configureMapView];
    [self configureData];
}

- (void) configureMapView{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:24.4667
                                                            longitude:54.3667
                                                                 zoom:15];
    mapView_ = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    mapView_.myLocationEnabled = YES;
    [self.view addSubview:mapView_];

    mapView_.delegate = self;

}

- (void) configurePins{
    for (MapLookUp *mapLookUp in self.mapLookups) {
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(mapLookUp.StartLatitude.doubleValue, mapLookUp.StartLongitude.doubleValue);
        GMSMarker *startMarker = [GMSMarker markerWithPosition:position];
        MapItemView *startItem = [[MapItemView alloc] initWithLat:mapLookUp.StartLatitude lng:mapLookUp.StartLongitude address:mapLookUp.FromStreetName name:mapLookUp.FromEmirateArName];
        startItem.arabicName = mapLookUp.FromRegionArName;
        startItem.englishName = mapLookUp.FromRegionEnName;
        startItem.rides = mapLookUp.NoOfSeats;
        startMarker.userData = startItem;
        startMarker.title = mapLookUp.FromEmirateArName;
        startMarker.icon = [UIImage imageNamed:@"Location"];
        startMarker.map = mapView_;
        [self.markers addObject:startMarker];
        
        CLLocationCoordinate2D endPosition = CLLocationCoordinate2DMake(mapLookUp.StartLatitude.doubleValue, mapLookUp.StartLongitude.doubleValue);
        GMSMarker *endMarker = [GMSMarker markerWithPosition:endPosition];
        MapItemView *endItem = [[MapItemView alloc] initWithLat:mapLookUp.EndLatitude lng:mapLookUp.EndLongitude address:mapLookUp.ToStreetName name:mapLookUp.ToEmirateArName];
        endItem.arabicName = mapLookUp.ToRegionArName;
        endItem.englishName = mapLookUp.ToRegionEnName;
        endItem.rides = mapLookUp.NoOfSeats;
        endMarker.userData = endItem;
        endMarker.title = mapLookUp.ToEmirateArName;
        endMarker.icon = [UIImage imageNamed:@"Location"];
        endMarker.map = mapView_;
        [self.markers addObject:endMarker];
    }
}

- (UIView *) mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    MapItemView *mapItem = (MapItemView *)marker.userData;
    MapInfoWindow *infoWindow = [[MapInfoWindow alloc] initWithArabicName:mapItem.arabicName englishName:mapItem.englishName rides:mapItem.rides lat:mapItem.lat lng:mapItem.lng time:mapItem.comingRides];
    return infoWindow;
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    CGPoint point = [mapView.projection pointForCoordinate:marker.position];
    point.y = point.y - 100;
    GMSCameraUpdate *camera =
    [GMSCameraUpdate setTarget:[mapView.projection coordinateForPoint:point]];
    [mapView animateWithCameraUpdate:camera];
    
    mapView.selectedMarker = marker;
    return YES;
}

- (void)focusMapToShowAllMarkers{
    CLLocationCoordinate2D myLocation = ((GMSMarker *)_markers.firstObject).position;
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:myLocation coordinate:myLocation];
    
    for (GMSMarker *marker in self.markers)
        bounds = [bounds includingCoordinate:marker.position];
    
    [mapView_ animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:15.0f]];
}

- (void) popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) configureData{
    [KVNProgress showWithStatus:@"Loading..."];
    __block MapLookupViewController *blockSelf = self;
    [[MobDriverManager sharedMobDriverManager] getMapLookupWithSuccess:^(NSArray *items) {
        [KVNProgress dismiss];
        blockSelf.mapLookups = items;
        blockSelf.markers = [NSMutableArray array];
        [blockSelf configurePins];
        [blockSelf focusMapToShowAllMarkers];
    } Failure:^(NSString *error) {
        [KVNProgress dismiss];
    }];
}
/*
- (void) fitAllPins{
    CLLocationDegrees maxLat = -90.0f;
    CLLocationDegrees maxLon = -180.0f;
    CLLocationDegrees minLat = 90.0f;
    CLLocationDegrees minLon = 180.0f;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        CLLocationDegrees lat = annotation.coordinate.latitude;
        CLLocationDegrees lon = annotation.coordinate.longitude;
        
        maxLat = MAX(maxLat, lat);
        maxLon = MAX(maxLon, lon);
        minLat = MIN(minLat, lat);
        minLon = MIN(minLon, lon);
    }
    MKCoordinateRegion region;
    region.center.latitude     = (maxLat + minLat) / 2;
    region.center.longitude    = (maxLon + minLon) / 2;
    region.span.latitudeDelta  = maxLat - minLat + 1;
    region.span.longitudeDelta = maxLon - minLon + 1;
    
    [self.mapView setRegion:region animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MapItemView class]]) {
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = NO;
            annotationView.image = [UIImage imageNamed:@"Location"];
            
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    [self.mapView deselectAnnotation:view.annotation animated:YES];
    if([view.annotation isKindOfClass:[MapItemView class]]) {
        MapItemView *annotation = view.annotation;
        MapItemPopupViewController *viewController = [[MapItemPopupViewController alloc] initWithNibName:@"MapItemPopupViewController" bundle:nil];
        viewController.arabicName = annotation.arabicName;
        viewController.englishName = annotation.englishName;
        viewController.rides = annotation.rides;
        viewController.lat = annotation.lat;
        viewController.lng = annotation.lng;
        
        self.popover = [[WYPopoverController alloc] initWithContentViewController:viewController];
        self.popover.popoverContentSize = CGSizeMake(200, 226);
        self.popover.theme = [WYPopoverTheme themeForIOS7];
        [self.popover presentPopoverFromRect:view.bounds inView:view permittedArrowDirections:WYPopoverArrowDirectionAny animated:TRUE  options:WYPopoverAnimationOptionFadeWithScale];
    }
}
*/
@end
