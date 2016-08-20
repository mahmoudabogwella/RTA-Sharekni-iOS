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
#import "MapLookupForPassenger.h"
#import <WYPopoverController.h>
#import "MapItemView.h"
#import "MapItemPopupViewController.h"
#import "MapInfoWindow.h"
#import "MobDriverManager.h"
#import "SearchResultsViewController.h"
#import "HelpManager.h"
//MobAccountManager  MasterDataManager  MostRideDetailsViewControllerForPassenger
#import "MobAccountManager.h"
#import "MasterDataManager.h"
#import "MostRideDetailsViewControllerForPassenger.h"

@import GoogleMaps;
@interface MapLookupViewController ()<GMSMapViewDelegate,CLLocationManagerDelegate,MKMapViewDelegate>
{
    GMSMapView *mapView_;
    BOOL currentLocationEnabled;
    GMSMarker *userMarker;
    
    
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) NSArray *mapLookups;
@property (nonatomic,strong) NSArray *mapLookupsForPassenger; //ESK
@property (nonatomic,strong) NSString *LanguageIs; //ESK

@property (nonatomic,strong) WYPopoverController *popover;
@property (nonatomic,strong) NSMutableArray *markers;
@property (nonatomic,strong) CLLocationManager *locationManager;
@end

@implementation MapLookupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_mapView bringSubviewToFront:_TheMapSwitcherOutLet];
    
    User *applicationUser = [[MobAccountManager sharedMobAccountManager] applicationUser];
    if (applicationUser) {
        self.TheMapSwitcherOutLet.hidden = NO;

    }else {
        self.TheMapSwitcherOutLet.hidden = YES;

    }
    currentLocationEnabled = NO;
    self.title = GET_STRING(@"Map Lookup");
    switch ([[Languages sharedLanguageInstance] language]) {
            
            
        case Arabic:
            _LanguageIs = @"Arabic";
            break;
        case English:
            _LanguageIs = @"English";
            //        self.HindiButtonSelector.hidden = NO;
            
            break;
        default:
            NSLog(@"eror with the Language Picker in ShareForPassenger");
            break;
    }
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user-Location"] style:UIBarButtonItemStylePlain target:self action:@selector(currentLocationHanlder)];
    _MapDeciderForSwitch = @"Driver";
    _MapDeciderSwitchBoolean = YES;
    
    UIColor *subColor = [UIColor redColor];
    [_TheMapSwitcherOutLet setTintColor:subColor];

    [self configureMapView];
    [self configureData];
    
    
}

- (BOOL)shouldAutorotate
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait){
        // your code for portrait mode
        return NO ;
    }else{
        return YES ;
    }
}

- (void) currentLocationHanlder{
    CLLocationCoordinate2D myLocation = mapView_.myLocation.coordinate;
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:myLocation coordinate:myLocation];
    
    
    [mapView_ animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:10.0f]];
    [mapView_ setMinZoom:10 maxZoom:15]; //GonAdd Zoom To Current

}

- (void)viewWillAppear:(BOOL)animated {
    
   

    
    //    [mapView_ addObserver:self forKeyPath:@"myLocation" options:0 context:nil];
//    UISegmentedControl * cntrl = [[UISegmentedControl alloc]   initWithItems:@[[UIImage imageNamed:@"Circle"],@"2"]];
//    _mapView.frame = CGRectMake(30, 100, 200, 50);
//    [self.view addSubview:_TheMapSwitcherOutLet];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [mapView_ removeObserver:self forKeyPath:@"myLocation"];
}

#pragma mark - KVO updates

- (void) configureMapView{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_mapView.userLocation.coordinate.latitude longitude:_mapView.userLocation.coordinate.longitude zoom:14];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
        mapView_ = [GMSMapView mapWithFrame:CGRectMake(0,0, width, height) camera:camera];

    mapView_.myLocationEnabled = YES;
    [self.view addSubview:mapView_];
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });
    [self.view sendSubviewToBack:_mapView];
    [self.view sendSubviewToBack:mapView_];
    [self.view bringSubviewToFront:_TheMapSwitcherOutLet];
    [mapView_ bringSubviewToFront:_TheMapSwitcherOutLet];

//    [self.view addSubview:_TheMapSwitcherOutLet];
    mapView_.delegate = self;
}




- (IBAction)SwitcherBetweenTheMaps:(id)sender {
    
    /*
    if ([sender isSelected]) {
        [self.TheMapSwitcherOutLet setBackgroundImage:[UIImage imageNamed:@"DForMapLookUp"]forState:UIControlStateNormal];
        NSLog(@"Driver") ;
        _MapDeciderForSwitch = @"Driver";
        _MapDeciderSwitchBoolean = YES;
        //        [self configureMapView];
        [mapView_ clear];
        [self configureData];
    }else {
           NSLog(@"Passenger");
        [self.TheMapSwitcherOutLet setBackgroundImage:[UIImage imageNamed:@"PForMapLookUp"]forState:UIControlStateNormal];
        _MapDeciderForSwitch = @"Passenger";
        _MapDeciderSwitchBoolean = NO;
        //        [self configureMapView];
        [mapView_ clear];
        [self configureData];
    }
    */
    
    UIButton *btn = (UIButton *)sender;
    
    if( [[btn imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"DForMapLookUp"]])
    {
        [btn setImage:[UIImage imageNamed:@"PForMapLookUp"] forState:UIControlStateNormal];
        // other statements
        NSLog(@"Passenger");
        _MapDeciderForSwitch = @"Passenger";
        _MapDeciderSwitchBoolean = NO;
        //        [self configureMapView];
        [mapView_ clear];
        [self configureData];
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"DForMapLookUp"] forState:UIControlStateNormal];
        NSLog(@"Driver") ;
        _MapDeciderForSwitch = @"Driver";
        _MapDeciderSwitchBoolean = YES;
        //        [self configureMapView];
        [mapView_ clear];
        [self configureData];        // other statements
    }
    
    
}
- (void) configurePins{
    
    //GonMade NewMarkers in Map
    if ( _MapDeciderSwitchBoolean == YES && [_MapDeciderForSwitch  isEqual: @"Driver"]) {
        for (MapLookUp *mapLookUp in self.mapLookups) {
            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(mapLookUp.FromLat.doubleValue, mapLookUp.FromLng.doubleValue);
            NSString *addressArabic = [NSString stringWithFormat:@"%@ - %@",mapLookUp.FromEmirateNameAr,mapLookUp.FromRegionNameAr];
            NSString *addressEnglish = [NSString stringWithFormat:@"%@ - %@",mapLookUp.FromEmirateNameEn,mapLookUp.FromRegionNameEn];
            GMSMarker *startMarker = [GMSMarker markerWithPosition:position];
            MapItemView *startItem = [[MapItemView alloc] initWithLat:mapLookUp.FromLng lng:mapLookUp.FromLng address:mapLookUp.FromRegionNameEn name:mapLookUp.FromEmirateNameEn];
            startItem.arabicName = addressArabic;
            startItem.englishName = addressEnglish;
            startItem.passengers = mapLookUp.NoOfPassengers.stringValue;
            startItem.drivers = mapLookUp.NoOfRoutes.stringValue;
            
            startItem.lookup = mapLookUp;
            
            startMarker.userData = startItem;
            startMarker.title = addressEnglish;
            startMarker.icon = [UIImage imageNamed:@"Location"];
            startMarker.map = mapView_;
            [self.markers addObject:startMarker];
        }
        NSLog(@"Changing the Driver Pins");
        
    }
    
    if ( _MapDeciderSwitchBoolean == NO && [_MapDeciderForSwitch  isEqual: @"Passenger"]) {
        for (MapLookupForPassenger *mapLookUp in self.mapLookupsForPassenger) {
            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(mapLookUp.FromLat.doubleValue, mapLookUp.FromLng.doubleValue);
            NSString *addressArabic = [NSString stringWithFormat:@"%@ - %@",mapLookUp.FromEmirateArName,mapLookUp.FromRegionArName];
            NSString *addressEnglish = [NSString stringWithFormat:@"%@ - %@",mapLookUp.FromEmirateEnName,mapLookUp.FromRegionEnName];
            GMSMarker *startMarker = [GMSMarker markerWithPosition:position];
            MapItemView *startItem = [[MapItemView alloc] initWithLat:mapLookUp.FromLng lng:mapLookUp.FromLng address:mapLookUp.FromRegionEnName name:mapLookUp.FromEmirateEnName];
            startItem.arabicName = addressArabic;
            startItem.englishName = addressEnglish;
            startItem.passengers = mapLookUp.PassengersCount.stringValue;
            startItem.drivers = mapLookUp.NoOfRoutes.stringValue;

            startItem.lookupForPassenger = mapLookUp;
 

            /*
             
             @property (weak, nonatomic) IBOutlet UILabel *driversLabel;
             @property (weak, nonatomic) IBOutlet UILabel *driversLabel2;
             @property (weak, nonatomic) IBOutlet UILabel *passengersLabel;
             @property (weak, nonatomic) IBOutlet UILabel *time;
             
             @property (weak, nonatomic) IBOutlet UILabel *driverHeader;
             @property (weak, nonatomic) IBOutlet UILabel *ridesHeader;

            */
            startMarker.userData = startItem;
            startMarker.title = addressEnglish;
            
            startMarker.icon = [UIImage imageNamed:@"pinPass"];
            startMarker.map = mapView_;
            [self.markers addObject:startMarker];
        }
        NSLog(@"Changing the Passenger Pins");
    }
    
}


- (UIView *) mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    
    MapItemView *mapItem = (MapItemView *)marker.userData;
    if ([_LanguageIs isEqual:@"Arabic"]) {
        if (mapItem) {
            MapInfoWindow *infoWindow = [[MapInfoWindow alloc] initWithArabicName:mapItem.arabicName englishName:mapItem.englishName Type:_MapDeciderForSwitch passengers:mapItem.passengers drivers:mapItem.drivers lat:mapItem.lat lng:mapItem.lng time:mapItem.comingRides];
            return infoWindow;
        }
        else{
            return nil;
        }
    }else{
        if (mapItem) { //Type:(NSString *)Type
            MapInfoWindow *infoWindow = [[MapInfoWindow alloc] initWithArabicName:mapItem.arabicName englishName:mapItem.englishName Type:_MapDeciderForSwitch passengers:mapItem.passengers drivers:mapItem.drivers lat:mapItem.lat lng:mapItem.lng time:mapItem.comingRides];
            return infoWindow;
        }
        else{
            return nil;
        }
    }
    
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    [self showDetailsForMapItem:((MapItemView *)marker.userData)];
}

- (void) showDetailsForMapItem:(MapItemView *)mapitem{
    
    //Gonmade marks in Map
    
    if ( _MapDeciderSwitchBoolean == YES && [_MapDeciderForSwitch  isEqual: @"Driver"] ) {
        
        __block MapLookupViewController *blockSelf = self;
        [KVNProgress showWithStatus:GET_STRING(@"Loading...")];
        MapLookUp *lookup = mapitem.lookup;
        
        [[MobDriverManager sharedMobDriverManager] GetFromOnlyMostDesiredRidesDetails:lookup.FromEmirateId.stringValue andFromRegionID:lookup.FromRegionId.stringValue WithSuccess:^(NSArray *searchResults) {
            [KVNProgress dismiss];
            NSLog(@"GetFromOnlyMostDesiredRidesDetails Succeded");
            if(searchResults.count > 0){
                SearchResultsViewController *resultViewController = [[SearchResultsViewController alloc] initWithNibName:(KIS_ARABIC)?@"SearchResultsViewController_ar":@"SearchResultsViewController" bundle:nil];
                resultViewController.results = searchResults;
                resultViewController.fromEmirate = lookup.FromEmirateNameEn;
                resultViewController.fromRegion = lookup.FromRegionNameEn;
                [blockSelf.navigationController pushViewController:resultViewController animated:YES];
            }
            else{
                [[HelpManager sharedHelpManager] showAlertWithMessage:GET_STRING(@"No Rides Found")];
            }
        } Failure:^(NSString *error) {
            NSLog(@"GetFromOnlyMostDesiredRidesDetails Failed");
            [KVNProgress dismiss];
        }];
        /* //Old map WEb
        [[MobDriverManager sharedMobDriverManager] findRidesFromEmirateID:lookup.FromEmirateId.stringValue andFromRegionID:lookup.FromRegionId.stringValue toEmirateID:@"0" andToRegionID:@"0" PerfferedLanguageID:@"0" nationalityID:@"" ageRangeID:@"0" date:nil isPeriodic:nil saveSearch:nil WithSuccess:^(NSArray *searchResults) {
            
            [KVNProgress dismiss];
            if(searchResults){
                SearchResultsViewController *resultViewController = [[SearchResultsViewController alloc] initWithNibName:(KIS_ARABIC)?@"SearchResultsViewController_ar":@"SearchResultsViewController" bundle:nil];
                resultViewController.results = searchResults;
                resultViewController.fromEmirate = lookup.FromEmirateNameEn;
                resultViewController.toEmirate = nil;
                resultViewController.fromRegion = lookup.FromRegionNameEn;
                resultViewController.toRegion = nil;
                [blockSelf.navigationController pushViewController:resultViewController animated:YES];
            }
            else{
                [[HelpManager sharedHelpManager] showAlertWithMessage:GET_STRING(@"No Rides Found")];
            }
        } Failure:^(NSString *error) {
            [KVNProgress dismiss];
        }];
        */
        
        /*
         
         [[MasterDataManager sharedMasterDataManager] GetFromOnlyMostDesiredRidesDetails:@"0" FromEmirateID:lookup.FromEmirateId.stringValue FromRegionID:lookup.FromRegionId.stringValue WithSuccess:^(NSMutableArray *searchResults) {
         if(searchResults){
         SearchResultsViewController *resultViewController = [[SearchResultsViewController alloc] initWithNibName:(KIS_ARABIC)?@"SearchResultsViewController_ar":@"SearchResultsViewController" bundle:nil];
         resultViewController.results = searchResults;
         resultViewController.fromEmirate = lookup.FromEmirateNameEn;
         resultViewController.fromRegion = lookup.FromRegionNameEn;
         [blockSelf.navigationController pushViewController:resultViewController animated:YES];
         }
         else{
         [[HelpManager sharedHelpManager] showAlertWithMessage:GET_STRING(@"No Rides Found")];
         }
         } Failure:^(NSString *error) {
         [KVNProgress dismiss];
         }];
         */
        NSLog(@"Changing the Driver Navigation");
        
    }
    //MobAccountManager  MasterDataManager
    
    User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
    
    
    
    if ( _MapDeciderSwitchBoolean == NO && [_MapDeciderForSwitch  isEqual: @"Passenger"]) {
        
        __block MapLookupViewController *blockSelf = self;
        [KVNProgress showWithStatus:GET_STRING(@"Loading...")];
        MapLookupForPassenger *lookup = mapitem.lookupForPassenger;
        NSLog(@"DriverToute ID: %@",lookup.ToRegionId);
        NSLog(@"DriverToute2 %@",[NSString stringWithFormat:@"%@",lookup.ToEmirateId]);
        //        [[MasterDataManager sharedMasterDataManager] getRideDetailsFORPASSENGER:[NSString stringWithFormat:user.ID] FromEmirateID:lookup.FromEmirateId FromRegionID:@"0" ToEmirateID:@"0" ToRegionID:@"0" RouteID:@"0" WithSuccess:^(NSMutableArray *searchResults) {
        [[MasterDataManager sharedMasterDataManager] getRideDetailsFORPASSENGER:[NSString stringWithFormat:@"%@",user.ID] FromEmirateID:[NSString stringWithFormat:@"%@",lookup.FromEmirateId] FromRegionID:[NSString stringWithFormat:@"%@",lookup.FromRegionId] ToEmirateID:[NSString stringWithFormat:@"%@",lookup.ToEmirateId] ToRegionID:[NSString stringWithFormat:@"%@",lookup.ToRegionId] RouteID:[NSString stringWithFormat:@"%@",lookup.DriverRouteId] WithSuccess:^(NSMutableArray *searchResults) {
            
            [KVNProgress dismiss];
            if(searchResults.count > 0){
                //            SearchResultsViewControllerForMap *rideDetailsView = [[SearchResultsViewControllerForMap alloc] initWithNibName:(KIS_ARABIC)?@"SearchResultsViewControllerForMap":@"SearchResultsViewControllerForMap" bundle:nil];
                //            resultViewController.rides = searchResults;
                //            resultViewController.fromEmirate = lookup.FromEmirateNameEn;
                //            resultViewController.toEmirate = nil;
                //            resultViewController.fromRegion = lookup.FromRegionNameEn;
                //            resultViewController.toRegion = nil;
                
                MostRideDetailsViewControllerForPassenger *rideDetailsView = [[MostRideDetailsViewControllerForPassenger alloc] initWithNibName:@"MostRideDetailsViewControllerForPassenger" bundle:nil];
                
                rideDetailsView.toEmirate = [NSString stringWithFormat:@"%@ : %@" , (KIS_ARABIC)?lookup.FromEmirateArName:lookup.FromEmirateEnName , (KIS_ARABIC)?lookup.FromRegionArName:lookup.FromRegionEnName];
                rideDetailsView.fromEmirate = @" ";
                //            rideDetailsView.fromRegion = [NSString stringWithFormat:@"%@ : %@" , (KIS_ARABIC)?lookup.FromEmirateNameAr:lookup.FromEmirateNameEn , (KIS_ARABIC)?lookup.FromRegionNameAr:lookup.FromRegionNameEn];
                rideDetailsView.WebAccountID = [NSString stringWithFormat:@"%@",user.ID];
                rideDetailsView.ToEmirateID = [NSString stringWithFormat:@"%@",lookup.ToEmirateId];
                rideDetailsView.FromEmirateID = [NSString stringWithFormat:@"%@",lookup.FromEmirateId];
                rideDetailsView.FromRegionID = [NSString stringWithFormat:@"%@",lookup.FromRegionId];
                rideDetailsView.ToRegionID = [NSString stringWithFormat:@"%@",lookup.ToRegionId];
                rideDetailsView.TheFlag = @"MapLookUp";
                rideDetailsView.RouteIDString = [NSString stringWithFormat:@"%@",lookup.DriverRouteId];
                /*
                 rideDetailsView.fromRegion = [NSString stringWithFormat:@"%@ : %@",(KIS_ARABIC)?lookup.FromEmirateArName:lookup.FromEmirateEnName,(KIS_ARABIC)?lookup.FromRegionArName:lookup.FromRegionEnName];
                 rideDetailsView.fromEmirate = [NSString stringWithFormat:@"%@ : %@",(KIS_ARABIC)?self.routeDetails.ToEmirateArName:self.routeDetails.ToEmirateEnName,(KIS_ARABIC)?self.routeDetails.ToRegionArName:self.routeDetails.ToRegionEnName];
                 */
                
                [blockSelf.navigationController pushViewController:rideDetailsView animated:YES];
            }
            else{
                [[HelpManager sharedHelpManager] showAlertWithMessage:GET_STRING(@"No Rides Found")];
            }
        } Failure:^(NSString *error) {
            [KVNProgress dismiss];
        }];
        NSLog(@"Changing the Passenger Navigation");
        
    }
    /*
     if ( _MapDeciderSwitchBoolean == NO && [_MapDeciderForSwitch  isEqual: @"Passenger"]) {
     
     __block MapLookupViewController *blockSelf = self;
     [KVNProgress showWithStatus:GET_STRING(@"Loading...")];
     MapLookupForPassenger *lookup = mapitem.lookupForPassenger;
     [[MobDriverManager sharedMobDriverManager] findRidesFromEmirateID:lookup.FromEmirateId.stringValue andFromRegionID:lookup.FromRegionId.stringValue toEmirateID:@"0" andToRegionID:@"0" PerfferedLanguageID:@"0" nationalityID:@"" ageRangeID:@"0" date:nil isPeriodic:nil saveSearch:nil WithSuccess:^(NSArray *searchResults) {
     
     [KVNProgress dismiss];
     if(searchResults){
     SearchResultsViewControllerForMap *resultViewController = [[SearchResultsViewControllerForMap alloc] initWithNibName:(KIS_ARABIC)?@"SearchResultsViewControllerForMap_ar":@"SearchResultsViewControllerForMap" bundle:nil];
     resultViewController.results = searchResults;
     resultViewController.fromEmirate = lookup.FromEmirateNameEn;
     resultViewController.toEmirate = nil;
     resultViewController.fromRegion = lookup.FromRegionNameEn;
     resultViewController.toRegion = nil;
     [blockSelf.navigationController pushViewController:resultViewController animated:YES];
     }
     else{
     [[HelpManager sharedHelpManager] showAlertWithMessage:GET_STRING(@"No Rides Found")];
     }
     } Failure:^(NSString *error) {
     [KVNProgress dismiss];
     }];
     NSLog(@"Changing the Passenger Navigation");
     
     }
     */
    
    
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
//    CLLocationCoordinate2D myLocation = ((GMSMarker *)_markers.firstObject).position;
//    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:myLocation coordinate:myLocation];
    
//    for (GMSMarker *marker in self.markers)
//        bounds = [bounds includingCoordinate:marker.position];
    
//    [mapView_ animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:100.0f]];
    

    
    
    if([CLLocationManager locationServicesEnabled] &&
       [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        // show the map
        NSLog(@"GPS working and he allowes it");
        mapView_.myLocationEnabled = YES;
        CLLocation* myLoc = [mapView_ myLocation];
        NSLog(@"that is lat : %f and log : %f ",myLoc.coordinate.latitude,myLoc.coordinate.longitude);
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:myLoc.coordinate.latitude
                                                                longitude:myLoc.coordinate.longitude
                                                                     zoom:12];//GonZoom From Here
        [mapView_ setCamera:camera];
    } else {
        //        __block MapLookupViewController *blockSelf = self;
        //   [[HelpManager sharedHelpManager] showAlertWithMessage:GET_STRING(@"Please turn on GPS first")];
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //            [blockSelf.navigationController popViewControllerAnimated:YES];
        //
        //        });
        NSLog(@"GPS is not working");
        
        mapView_.myLocationEnabled = YES;
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:25.47425
                                                                longitude:55.70783
                                                                     zoom:7];//GonZoom From Here
        [mapView_ setCamera:camera];
        //
        
    }
    
 
}

- (void) popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) configureData{
    
    [KVNProgress showWithStatus:GET_STRING(@"Loading...")];
    __block MapLookupViewController *blockSelf = self;
    if ( _MapDeciderSwitchBoolean == YES && [_MapDeciderForSwitch  isEqual: @"Driver"]  ) {
        
        //    [KVNProgress showWithStatus:@"Loading..."];
        //    __block MapLookupViewController *blockSelf = self;
        [[MobDriverManager sharedMobDriverManager] getMapLookupWithSuccess:^(NSArray *items) {
            [KVNProgress dismiss];
            blockSelf.mapLookups = items;
            blockSelf.markers = [NSMutableArray array];
            [blockSelf configurePins];
            [blockSelf focusMapToShowAllMarkers];
        } Failure:^(NSString *error) {
            [KVNProgress dismiss];
        }];
        NSLog(@"Changing the Driver Block");
        
    }
    
    if (  _MapDeciderSwitchBoolean == NO && [_MapDeciderForSwitch  isEqual: @"Passenger"] ) {
        
        //        [KVNProgress showWithStatus:@"Loading..."];
        //        __block MapLookupViewController *blockSelf = self;
        //
        
        
        User *user = [[MobAccountManager sharedMobAccountManager] applicationUser];
        
      [[MobDriverManager sharedMobDriverManager] getMapLookupForPassengerWithSuccess:[NSString stringWithFormat:@"%@",user.ID] WithSuccess:^(NSArray *items) {
            NSLog(@"Succes");
            [KVNProgress dismiss];
            blockSelf.mapLookupsForPassenger = items; //ESA
          NSLog(@"that is the mapLookupsForPassenger : %@",blockSelf.mapLookupsForPassenger);
          NSLog(@"that is the items : %@",items);

            blockSelf.markers = [NSMutableArray array];
          NSLog(@"that is the marker : %@",blockSelf.markers);
            [blockSelf configurePins];
            [blockSelf focusMapToShowAllMarkers];
        } Failure:^(NSString *error) {
            NSLog(@"Failed");
            [KVNProgress dismiss];
        }];
        
        
       /*
        
        [[MobDriverManager sharedMobDriverManager] getMapLookupForPassenger:[NSString stringWithFormat:@"%@",user.ID] WithSuccess:^(NSArray *items) {
            [KVNProgress dismiss];
            blockSelf.mapLookupsForPassenger = items; //ESA
            blockSelf.markers = [NSMutableArray array];
            [blockSelf configurePins];
            [blockSelf focusMapToShowAllMarkers];
        } Failure:^(NSString *error) {
            [KVNProgress dismiss];
        }];*/
        NSLog(@"Changing the Passenger BLOCK");
        
    }
    
    
    
    
}

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        //Configure Accuracy depending on your needs, default is kCLLocationAccuracyBest
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager startUpdatingLocation];
        [_locationManager startMonitoringSignificantLocationChanges];
        [_locationManager startUpdatingLocation];
    }
    return _locationManager;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    [self addUserLocation:location];
}

- (void) addUserLocation:(CLLocation *)location{
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    
    userMarker = [GMSMarker markerWithPosition:position];
    userMarker.userData = nil;
    userMarker.title = @"Current Location";
    userMarker.icon = [UIImage imageNamed:@"CurrentLocation"];
    userMarker.map = mapView_;
    //    [self.markers addObject:userMarker];
}

@end
