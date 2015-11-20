//
//  RideDetailsViewController.m
//  sharekni
//
//  Created by Ahmed Askar on 10/31/15.
//
//

#import "RideDetailsViewController.h"
#import "MessageUI/MessageUI.h"
#import "Constants.h"
#import <KVNProgress/KVNProgress.h>
#import "NSObject+Blocks.h"
#import <UIColor+Additions.h>
#import "MasterDataManager.h"
#import "Review.h"
#import "ReviewCell.h"
#import "UILabel+Borders.h"
#import <UIColor+Additions/UIColor+Additions.h>
#import "Constants.h"
#import "NSStringEmpty.h"
#import "MapItemView.h"
#import "MapItemPopupViewController.h"
#import "MapInfoWindow.h"
#import "RouteDetails.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AddReviewViewController.h"
#import "UIViewController+MJPopupViewController.h"


@interface RideDetailsViewController ()<GMSMapViewDelegate,MJDetailPopupDelegate>
{
    __weak IBOutlet UIScrollView *contentView ;
    __weak IBOutlet UITableView *reviewList ;
    __weak IBOutlet UIButton *joinRideBtn ;
    
    __weak IBOutlet UILabel *FromRegionName ;
    __weak IBOutlet UILabel *ToRegionName ;
    __weak IBOutlet UILabel *startingTime ;
    __weak IBOutlet UILabel *availableDays ;
    
    __weak IBOutlet UILabel *language ;
    __weak IBOutlet UILabel *smoking ;
    __weak IBOutlet UILabel *nationality ;
    __weak IBOutlet UILabel *gender ;
    __weak IBOutlet UILabel *ageRange ;
    
    __weak IBOutlet MKMapView *_MKmapView;

    __weak IBOutlet UILabel *preferenceLbl ;
    __weak IBOutlet UILabel *reviewLbl ;
    __weak IBOutlet UIView *preferenceView ;
    __weak IBOutlet UIView *reviewsView ;
    GMSMapView *_mapView;
}

@property (nonatomic ,strong) NSMutableArray *reviews ;
@property (nonatomic ,strong) NSMutableArray *markers ;
@property (nonatomic ,strong) RouteDetails *routeDetails ;
@end

@implementation RideDetailsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"rideDetails", nil);
    
//    reviewList.rowHeight = UITableViewAutomaticDimension ;
//    reviewList.estimatedRowHeight = 55;
    
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 22, 22);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Back_icn"] forState:UIControlStateNormal];
    [_backBtn setHighlighted:NO];
    [_backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    
    [contentView setScrollEnabled:YES];
    [contentView setContentSize:contentView.frame.size];
    
    [preferenceLbl addRightBorderWithColor:Red_UIColor];
    [preferenceLbl addLeftBorderWithColor:Red_UIColor];
    [reviewLbl addRightBorderWithColor:Red_UIColor];
    [reviewLbl addLeftBorderWithColor:Red_UIColor];

    
    preferenceView.layer.cornerRadius = 20;
    preferenceView.layer.borderWidth = 1;
    preferenceView.layer.borderColor = Red_UIColor.CGColor;
    
    reviewsView.layer.cornerRadius = 20;
    reviewsView.layer.borderWidth = 1;
    reviewsView.layer.borderColor = Red_UIColor.CGColor;
    
    FromRegionName.text = [NSString stringWithFormat:@"%@ : %@",_driverDetails.FromEmirateEnName,_driverDetails.FromRegionEnName];
    ToRegionName.text = [NSString stringWithFormat:@"%@ : %@",_driverDetails.ToEmirateEnName,_driverDetails.ToRegionEnName];
    startingTime.text = [NSString stringWithFormat:@"Time %@ : %@",_driverDetails.StartTime,_driverDetails.EndTime];
    availableDays.text = [NSString stringWithFormat:@"Ride Days : %@",[self getAvailableDays:self.driverDetails]];
    
    if ([NSStringEmpty isNullOrEmpty:_driverDetails.NationalityEnName])
    {
        nationality.text = @"Not Set";
    }
    else
    {
        nationality.text = _driverDetails.NationalityEnName ;
    }
    
    if ([NSStringEmpty isNullOrEmpty:_driverDetails.AgeRange])
    {
        ageRange.text = @"Not Set";
    }
    else
    {
        ageRange.text = _driverDetails.AgeRange ;
    }
    
    if (_driverDetails.IsSmoking.boolValue) {
        smoking.text = @"Yes";
    }else{
        smoking.text = @"No";
    }
    
    if ([NSStringEmpty isNullOrEmpty:_driverDetails.PrefLanguageEnName])
    {
        language.text = @"Not Set";
    }
    else
    {
        language.text = _driverDetails.PrefLanguageEnName;
    }
    
    if ([NSStringEmpty isNullOrEmpty:_driverDetails.PreferredGender])
    {
        gender.text = @"Not Set";
    }
    else
    {
        gender.text = _driverDetails.PreferredGender;
    }
    
    
    [self configureMapView];
    [self configureData];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)configureData
{
    __block RideDetailsViewController *blockSelf = self;
  
    [KVNProgress showWithStatus:NSLocalizedString(@"loading", nil)];
   
   [[MasterDataManager sharedMasterDataManager] GetRouteByRouteId:_driverDetails.RouteId withSuccess:^(RouteDetails *routeDetails) {
       
       blockSelf.routeDetails = routeDetails;
       [blockSelf configurePins];
       [[MasterDataManager sharedMasterDataManager] getReviewList:_driverDetails.AccountId andRoute:_driverDetails.RouteId withSuccess:^(NSMutableArray *array) {
           blockSelf.reviews = array;
           
           if (array.count == 0) {
               reviewLbl.hidden = YES ;
           }
           [KVNProgress dismiss];
           [reviewList reloadData];
           
           reviewsView.frame = CGRectMake(reviewsView.frame.origin.x, reviewsView.frame.origin.y, reviewsView.frame.size.width,self.reviews.count *110);
           
           reviewList.frame = CGRectMake(reviewList.frame.origin.x, reviewList.frame.origin.y + 15, reviewList.frame.size.width,reviewsView.frame.size.height - 30.0f);
           
           joinRideBtn.frame = CGRectMake(joinRideBtn.frame.origin.x, reviewsView.frame.origin.y + reviewsView.frame.size.height + 15.0f, joinRideBtn.frame.size.width, joinRideBtn.frame.size.height);
           
           [contentView setContentSize:CGSizeMake(self.view.frame.size.width, reviewsView.frame.origin.y + reviewsView.frame.size.height + joinRideBtn.frame.size.height + 55.0f)];

       } Failure:^(NSString *error) {
           [blockSelf handleResponseError];
       }];
   } Failure:^(NSString *error) {
       [blockSelf handleResponseError];
   }];
}

- (void) handleResponseError{
    NSLog(@"Error in Best Drivers");
    [KVNProgress dismiss];
    [KVNProgress showErrorWithStatus:@"Error"];
    [self performBlock:^{
        [KVNProgress dismiss];
    } afterDelay:3];
}

- (NSString *)getAvailableDays:(DriverDetails *)driverDetails
{
    NSMutableString *str = [[NSMutableString alloc] init];
    
    if (driverDetails.Saturday.boolValue) {
        [str appendString:NSLocalizedString(@"Sat ", nil)];
    }
    if (driverDetails.Sunday.boolValue) {
        [str appendString:NSLocalizedString(@"Sun ", nil)];
    }
    if (driverDetails.Monday.boolValue) {
        [str appendString:NSLocalizedString(@"Mon ", nil)];
    }
    if (driverDetails.Tuesday.boolValue) {
        [str appendString:NSLocalizedString(@"Tue ", nil)];
    }
    if (driverDetails.Wendenday.boolValue) {
        [str appendString:NSLocalizedString(@"Wed ", nil)];
        
    }
    if (driverDetails.Thrursday.boolValue) {
        [str appendString:NSLocalizedString(@"Thu ", nil)];
        
    }
    if (driverDetails.Friday.boolValue) {
        [str appendString:NSLocalizedString(@"Fri ", nil)];
    }
    
    return str ;
}

#pragma mark - Event Handler
- (IBAction)addReview:(id)sender
{
    AddReviewViewController *addReview = [[AddReviewViewController alloc] initWithNibName:@"AddReviewViewController" bundle:nil];
    addReview.driverDetails = self.driverDetails ;
    addReview.delegate = self;
    [self presentPopupViewController:addReview animationType:MJPopupViewAnimationSlideBottomBottom];
}

- (void)cancelButtonClicked:(AddReviewViewController *)addReviewViewController
{

    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
 
    [self configureData];
}

- (IBAction)joinThisRide:(id)sender
{



}


#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.reviews.count;
}

- (ReviewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier  = @"ReviewCell";
    
    ReviewCell *reviewCell = (ReviewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (reviewCell == nil)
    {
        reviewCell = (ReviewCell *)[[[NSBundle mainBundle] loadNibNamed:@"ReviewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    Review *review = self.reviews[indexPath.row];
    [reviewCell setReview:review];

    return reviewCell ;
}

#pragma mark -
#pragma mark GOOGLE_MAPS

- (void) configureMapView{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:24.4667
                                                            longitude:54.3667
                                                                 zoom:15];
    CGRect frame = _MKmapView.frame;
    _mapView = [GMSMapView mapWithFrame:frame camera:camera];
    _mapView.myLocationEnabled = YES;
    _mapView.delegate = self;
    [contentView addSubview:_mapView];
    [_MKmapView removeFromSuperview];
}


- (void) configurePins{

        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(self.routeDetails.StartLat.doubleValue, self.routeDetails.StartLng.doubleValue);
        GMSMarker *startMarker = [GMSMarker markerWithPosition:position];
        MapItemView *startItem = [[MapItemView alloc] initWithLat:self.routeDetails.StartLat lng:self.routeDetails.StartLng address:self.routeDetails.FromStreetName name:self.routeDetails.FromEmirateEnName];
        startItem.arabicName = self.routeDetails.FromRegionArName;
        startItem.englishName = self.routeDetails.FromRegionEnName;
        startItem.rides = self.routeDetails.NoOfSeats.stringValue;
        startMarker.userData = startItem;
        startMarker.title = self.routeDetails.FromEmirateEnName;
        startMarker.icon = [UIImage imageNamed:@"Location"];
        startMarker.map = _mapView;
        [self.markers addObject:startMarker];
    
    GMSMarker *endMarker = [GMSMarker markerWithPosition:position];
    MapItemView *endItem = [[MapItemView alloc] initWithLat:self.routeDetails.EndLat lng:self.routeDetails.EndLng address:self.routeDetails.ToStreetName name:self.routeDetails.ToEmirateEnName];
    endItem.arabicName = self.routeDetails.ToRegionArName;
    endItem.englishName = self.routeDetails.ToRegionEnName;
    endItem.rides = self.routeDetails.NoOfSeats.stringValue;
    endMarker.userData = endItem;
    endMarker.title = self.routeDetails.ToEmirateEnName;
    endMarker.icon = [UIImage imageNamed:@"Location"];
    endMarker.map = _mapView;
    [self.markers addObject:endItem];
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
    
    [_mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:15.0f]];
}

@end
