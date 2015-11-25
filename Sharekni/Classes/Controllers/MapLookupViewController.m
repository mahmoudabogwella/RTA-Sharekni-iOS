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
#import "MobDriverManager.h"
#import "SearchResultsViewController.h"
#import "HelpManager.h"

@import GoogleMaps;
@interface MapLookupViewController ()<GMSMapViewDelegate>
{
    GMSMapView *mapView_;
    BOOL firstLocationUpdate_;
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user-Location"] style:UIBarButtonItemStylePlain target:self action:@selector(currentLocationHanlder)];
    [self configureMapView];
    [self configureData];
}

- (void) currentLocationHanlder{

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.mapView removeObserver:self forKeyPath:@"myLocation"];
}

#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate_) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        firstLocationUpdate_ = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:10];
    }
}

- (void) configureMapView{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:24.4667
                                                            longitude:54.3667
                                                                 zoom:14];
    mapView_ = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    mapView_.myLocationEnabled = YES;
    [self.view addSubview:mapView_];
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    
    // Listen to the myLocation property of GMSMapView.
//    [mapView_ addObserver:self
//               forKeyPath:@"myLocation"
//                  options:NSKeyValueObservingOptionNew
//                  context:NULL];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });
    mapView_.delegate = self;
}

- (void) configurePins{
    for (MapLookUp *mapLookUp in self.mapLookups) {
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(mapLookUp.FromLat.doubleValue, mapLookUp.FromLng.doubleValue);
        NSString *addressArabic = [NSString stringWithFormat:@"%@ - %@",mapLookUp.FromEmirateNameAr,mapLookUp.FromRegionNameAr];
        NSString *addressEnglish = [NSString stringWithFormat:@"%@ - %@",mapLookUp.FromEmirateNameEn,mapLookUp.FromRegionNameEn];
        GMSMarker *startMarker = [GMSMarker markerWithPosition:position];
        MapItemView *startItem = [[MapItemView alloc] initWithLat:mapLookUp.FromLng lng:mapLookUp.FromLng address:mapLookUp.FromRegionNameEn name:mapLookUp.FromEmirateNameEn];
        startItem.arabicName = addressArabic;
        startItem.englishName = addressEnglish;
        startItem.rides = mapLookUp.NoOfPassengers.stringValue;
        startItem.lookup = mapLookUp;
        startMarker.userData = startItem;
        startMarker.title = addressEnglish;
        startMarker.icon = [UIImage imageNamed:@"Location"];
        startMarker.map = mapView_;
        [self.markers addObject:startMarker];
    }
}

- (UIView *) mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    MapItemView *mapItem = (MapItemView *)marker.userData;
    MapInfoWindow *infoWindow = [[MapInfoWindow alloc] initWithArabicName:mapItem.arabicName englishName:mapItem.englishName rides:mapItem.rides lat:mapItem.lat lng:mapItem.lng time:mapItem.comingRides];
    return infoWindow;
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    [self showDetailsForMapItem:((MapItemView *)marker.userData)];
}

- (void) showDetailsForMapItem:(MapItemView *)mapitem{
    __block MapLookupViewController *blockSelf = self;
    [KVNProgress showWithStatus:@"Loading..."];
    MapLookUp *lookup = mapitem.lookup;
    [[MobDriverManager sharedMobDriverManager] findRidesFromEmirateID:lookup.FromEmirateId.stringValue andFromRegionID:lookup.FromRegionId.stringValue toEmirateID:@"0" andToRegionID:@"0" PerfferedLanguageID:@"0" nationalityID:@"" ageRangeID:@"0" date:nil isPeriodic:nil saveSearch:nil WithSuccess:^(NSArray *searchResults) {
        
        [KVNProgress dismiss];
        if(searchResults){
            SearchResultsViewController *resultViewController = [[SearchResultsViewController alloc] initWithNibName:@"SearchResultsViewController" bundle:nil];
            resultViewController.results = searchResults;
            resultViewController.fromEmirate = lookup.FromEmirateNameEn;
            resultViewController.toEmirate = nil;
            resultViewController.fromRegion = lookup.FromRegionNameEn;
            resultViewController.toRegion = nil;
            [blockSelf.navigationController pushViewController:resultViewController animated:YES];
        }
        else{
            [[HelpManager sharedHelpManager] showAlertWithMessage:NSLocalizedString(@"No Rides Found ",nil)];
        }
    } Failure:^(NSString *error) {
        [KVNProgress dismiss];
    }];


}

- (BOOL) mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    CGPoint point = [mapView.projection pointForCoordinate:marker.position];
    point.y = point.y - 100;
    GMSCameraUpdate *camera =
    [GMSCameraUpdate setTarget:[mapView.projection coordinateForPoint:point]];
    [mapView animateWithCameraUpdate:camera];
    
    mapView.selectedMarker = marker;
    return YES;
}

- (void) focusMapToShowAllMarkers{
    CLLocationCoordinate2D myLocation = ((GMSMarker *)_markers.firstObject).position;
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:myLocation coordinate:myLocation];
    
    for (GMSMarker *marker in self.markers)
        bounds = [bounds includingCoordinate:marker.position];
    
    [mapView_ animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:100.0f]];
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
@end
