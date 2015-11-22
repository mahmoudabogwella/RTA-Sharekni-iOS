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
#import "UIView+Borders.h"
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
#import "MobAccountManager.h"
#import "PassengerCell.h"
#import "Passenger.h"

#define VERTICAL_SPACE 15
#define REVIEWS_CELL_HEIGHT  110
#define PASSENGER_ALERT_TAG  1199

@interface RideDetailsViewController ()<GMSMapViewDelegate,MJDetailPopupDelegate,MFMessageComposeViewControllerDelegate,UIAlertViewDelegate>
{
    __weak IBOutlet UIScrollView *contentView ;
    __weak IBOutlet UITableView *reviewList ;
    __weak IBOutlet UIView *passengersHeader;
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

    __weak IBOutlet UIView *locationsView;
    __weak IBOutlet UILabel *preferenceLbl ;
    __weak IBOutlet UILabel *reviewLbl ;
    __weak IBOutlet UIView *preferenceView ;
    __weak IBOutlet UIView *reviewsView ;
    __weak IBOutlet UITableView *passengersList;
    GMSMapView *_mapView;
    __weak IBOutlet UIView *passengersView;
}

@property (nonatomic ,strong) NSMutableArray *reviews ;
@property (nonatomic ,strong) NSMutableArray *markers ;
@property (nonatomic ,strong) NSArray *passengers ;
@property (nonatomic ,strong) Passenger *toBeDeletedpassenger ;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *passengersHeaderLabels;
@property (nonatomic ,strong) RouteDetails *routeDetails ;
@end

@implementation RideDetailsViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void) viewDidLoad
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
    preferenceView.layer.borderWidth  = 1;
    preferenceView.layer.borderColor  = Red_UIColor.CGColor;
    
    reviewsView.layer.cornerRadius = 20;
    reviewsView.layer.borderWidth  = 1;
    
    passengersHeader.backgroundColor = [UIColor whiteColor];
    
    reviewsView.layer.borderColor  = Red_UIColor.CGColor;
    
//    passengersView.layer.cornerRadius = 20;
//    passengersView.layer.borderWidth  = 1;
//    passengersView.layer.borderColor  = Red_UIColor.CGColor;
    
    [passengersHeader addBottomBorderWithColor:[UIColor lightGrayColor]];
    for (UILabel *label in self.passengersHeaderLabels) {
        [label setTextColor:Red_UIColor];
    }
    
    passengersList.separatorColor = [UIColor lightGrayColor];
    
    [passengersList registerClass:[PassengerCell class] forCellReuseIdentifier:PASSENGER_CELLID];
    [passengersList registerNib:[UINib nibWithNibName:@"PassengerCell" bundle:nil] forCellReuseIdentifier:PASSENGER_CELLID];
    

    [self configureMapView];
    [self configureData];
}


- (void) popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) showRideDetailsData{
    FromRegionName.text = [NSString stringWithFormat:@"%@ : %@",self.routeDetails.FromEmirateEnName,self.routeDetails.FromRegionEnName];
    ToRegionName.text = [NSString stringWithFormat:@"%@ : %@",self.routeDetails.ToEmirateEnName,self.routeDetails.ToRegionEnName];
    startingTime.text = [NSString stringWithFormat:@"Time %@ : %@",self.routeDetails.StartFromTime,self.routeDetails.EndFromTime];
    availableDays.text = [NSString stringWithFormat:@"Ride Days : %@",[self getAvailableDays]];
    
    if ([NSStringEmpty isNullOrEmpty:self.routeDetails.NationalityEnName])
    {
        nationality.text = @"Not Set";
    }
    else
    {
        nationality.text = self.routeDetails.NationalityEnName ;
    }
    
    if ([NSStringEmpty isNullOrEmpty:self.routeDetails.AgeRange])
    {
        ageRange.text = @"Not Set";
    }
    else
    {
        ageRange.text = self.routeDetails.AgeRange ;
    }
    
    if (_driverDetails.IsSmoking.boolValue) {
        smoking.text = @"Yes";
    }else{
        smoking.text = @"No";
    }
    
    if ([NSStringEmpty isNullOrEmpty:self.routeDetails.PrefLanguageEnName])
    {
        language.text = @"Not Set";
    }
    else
    {
        language.text = self.routeDetails.PrefLanguageEnName;
    }
    
    
    //Ask Question
    gender.text = @"Not Specified";
    
//    if ([NSStringEmpty isNullOrEmpty:self.routeDetails.PreferredGender])
//    {
//        gender.text = @"Not Set";
//    }
//    else
//    {
//        gender.text = self.routeDetails.PreferredGender;
//    }

}

- (void) configureData{
    __block RideDetailsViewController *blockSelf = self;
    __block UITableView *blockPassengersList = passengersList;
    __block UITableView *blockReviewsList = reviewList;
    [KVNProgress showWithStatus:NSLocalizedString(@"loading...", nil)];
    
    NSString *routeID;
    NSString *accountID ;
    if (self.driverDetails) {
        routeID = self.driverDetails.RouteId;
        accountID = self.driverDetails.ID;
    }
    else if (self.createdRide){
        routeID = self.createdRide.RouteID.stringValue;
        accountID = [[MobAccountManager sharedMobAccountManager] applicationUserID];
    }
    
   [[MasterDataManager sharedMasterDataManager] GetRouteByRouteId:routeID withSuccess:^(RouteDetails *routeDetails) {
       
       blockSelf.routeDetails = routeDetails;
       [blockSelf configurePins];
       [blockSelf focusMapToShowAllMarkers];
       [blockSelf showRideDetailsData];
       
       [[MasterDataManager sharedMasterDataManager] getPassengersByRouteId:routeID withSuccess:^(NSMutableArray *array) {
           blockSelf.passengers = array;
           [blockPassengersList reloadData];
           [[MasterDataManager sharedMasterDataManager] getReviewList:accountID andRoute:routeID withSuccess:^(NSMutableArray *array) {
               blockSelf.reviews = array;
               
               if (array.count == 0) {
                   reviewLbl.hidden = YES ;
               }
               [KVNProgress dismiss];
               [blockReviewsList reloadData];
               
               [blockSelf configureFrames];
               
           } Failure:^(NSString *error) {
               [blockSelf handleResponseError];
               [blockSelf configureFrames];
           }];
           
       } Failure:^(NSString *error) {
           [blockSelf handleResponseError];
           [blockSelf configureFrames];
       }];
    } Failure:^(NSString *error) {
       [blockSelf handleResponseError];
       [blockSelf configureFrames];
   }];
}

-(void) configureFrames{
    if(self.passengers.count > 0){
        CGRect passengersLabelFrame = passengersHeader.frame;
        passengersLabelFrame.origin.y = locationsView.frame.origin.y + locationsView.frame.size.height + VERTICAL_SPACE;
        passengersHeader.frame = passengersLabelFrame;
        
        CGRect passengersViewFrame = passengersView.frame;
        passengersViewFrame.origin.y = passengersHeader.frame.origin.y + passengersHeader.frame.size.height;
        passengersViewFrame.size.height = self.passengers.count * REVIEWS_CELL_HEIGHT + 10;
        passengersView.frame = passengersViewFrame;
        
        
        CGRect passengersListFrame = passengersList.frame;
        passengersListFrame.size.height = self.passengers.count *REVIEWS_CELL_HEIGHT;
        passengersList.frame = passengersListFrame;
        
        CGRect PreferencesLabelFrame = preferenceLbl.frame;
        PreferencesLabelFrame.origin.y = passengersView.frame.origin.y + passengersView.frame.size.height + VERTICAL_SPACE;
        preferenceLbl.frame = PreferencesLabelFrame;
    }
    else{
        passengersHeader.alpha = 0;
        passengersView.alpha = 0;
        
        CGRect PreferencesLabelFrame = preferenceLbl.frame;
        PreferencesLabelFrame.origin.y = locationsView.frame.origin.y + locationsView.frame.size.height + VERTICAL_SPACE;
        preferenceLbl.frame = PreferencesLabelFrame;
    }
    
    CGRect PreferencesViewFrame = preferenceView.frame;
    PreferencesViewFrame.origin.y = preferenceLbl.frame.origin.y + VERTICAL_SPACE;
    preferenceView.frame = PreferencesViewFrame;
    
    
    if(self.reviews.count > 0){
        CGRect reviewsLabelFrame = reviewLbl.frame;
        reviewsLabelFrame.origin.y = preferenceView.frame.origin.y + preferenceView.frame.size.height + VERTICAL_SPACE;
        reviewLbl.frame = reviewsLabelFrame;
        
        CGRect reviewsViewFrame = reviewsView.frame;
        reviewsViewFrame.origin.y = reviewLbl.frame.origin.y + VERTICAL_SPACE;
        reviewsViewFrame.size.height = (self.reviews.count * REVIEWS_CELL_HEIGHT) + 10;
        reviewsView.frame = reviewsViewFrame;
        
        CGRect reviewsListFrame = reviewList.frame;
        reviewsListFrame.size.height = self.reviews.count *REVIEWS_CELL_HEIGHT;
        reviewList.frame = reviewsListFrame;
        
        CGRect buttonFrame = joinRideBtn.frame;
        buttonFrame.origin.y = reviewsView.frame.origin.y + reviewsView.frame.size.height + VERTICAL_SPACE;
        joinRideBtn.frame = buttonFrame;
    }
    else{
        reviewLbl.hidden = YES;
        reviewsView.hidden = YES;
        
        CGRect buttonFrame = joinRideBtn.frame;
        buttonFrame.origin.y = preferenceView.frame.origin.y + preferenceView.frame.size.height + VERTICAL_SPACE;
        joinRideBtn.frame = buttonFrame;
    }
    
//    CGRect scrollViewFrame = contentView.frame;
//    scrollViewFrame.size.height = joinRideBtn.frame.origin.y + joinRideBtn.frame.size.height + VERTICAL_SPACE;
//    contentView.frame = scrollViewFrame;
    
    CGSize contentSize = contentView.contentSize ;
    contentSize.height = joinRideBtn.frame.origin.y + joinRideBtn.frame.size.height + VERTICAL_SPACE;
    contentView.contentSize = contentSize;

}

- (void) handleResponseError{
    NSLog(@"Error in Best Drivers");
    [KVNProgress dismiss];
    [KVNProgress showErrorWithStatus:@"Error"];
    [self performBlock:^{
        [KVNProgress dismiss];
    } afterDelay:3];
}

- (NSString *)getAvailableDays{
    NSMutableString *str = [[NSMutableString alloc] init];
    
    if (self.routeDetails.Saturday.boolValue) {
        [str appendString:NSLocalizedString(@"Sat ", nil)];
    }
    if (self.routeDetails.Sunday.boolValue) {
        [str appendString:NSLocalizedString(@"Sun ", nil)];
    }
    if (self.routeDetails.Monday.boolValue) {
        [str appendString:NSLocalizedString(@"Mon ", nil)];
    }
    if (self.routeDetails.Tuesday.boolValue) {
        [str appendString:NSLocalizedString(@"Tue ", nil)];
    }
    if (self.routeDetails.Wendenday.boolValue) {
        [str appendString:NSLocalizedString(@"Wed ", nil)];
        
    }
    if (self.routeDetails.Thrursday.boolValue) {
        [str appendString:NSLocalizedString(@"Thu ", nil)];
        
    }
    if (self.routeDetails.Friday.boolValue) {
        [str appendString:NSLocalizedString(@"Fri ", nil)];
    }
    
    return str ;
}

#pragma mark - Event Handler
- (IBAction)addReview:(id)sender{
    AddReviewViewController *addReview = [[AddReviewViewController alloc] initWithNibName:@"AddReviewViewController" bundle:nil];
    addReview.driverDetails = self.driverDetails ;
    addReview.delegate = self;
    [self presentPopupViewController:addReview animationType:MJPopupViewAnimationSlideBottomBottom];
}

- (void)cancelButtonClicked:(AddReviewViewController *)addReviewViewController{

    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
 
    [self configureData];
}

- (IBAction)joinThisRide:(id)sender{



}

- (void) deletePassenger:(Passenger *)passenger{
    __block RideDetailsViewController *blockSelf = self;
    
    [KVNProgress showWithStatus:NSLocalizedString(@"loading...", nil)];
    [[MasterDataManager sharedMasterDataManager] deletePassengerWithID:passenger.ID.stringValue withSuccess:^(NSString *response) {
        [KVNProgress dismiss];
        if([response containsString:@"1"]){
            [KVNProgress showSuccessWithStatus:NSLocalizedString(@"Passenger removed successfully", nil)];
            [blockSelf performBlock:^{
                [KVNProgress dismiss];
            } afterDelay:3];
        }
        else{
            [KVNProgress showErrorWithStatus:NSLocalizedString(@"Unable to remover passenger", nil)];
            [blockSelf performBlock:^{
                [KVNProgress dismiss];
            } afterDelay:3];
        }
    } Failure:^(NSString *error) {
        [blockSelf handleResponseError];
    }];
}


#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    if (tableView == reviewList) {
        return self.reviews.count;
    }
    else{
        return self.passengers.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == reviewList) {
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
    else{
        PassengerCell *passengerCell = (PassengerCell *)[tableView dequeueReusableCellWithIdentifier:PASSENGER_CELLID];
        
        if (passengerCell == nil)
        {
            passengerCell = [(PassengerCell *)[PassengerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PASSENGER_CELLID];
        }
        
        Passenger *passenger = self.passengers[indexPath.row];
        passengerCell.nameLabel.text = passenger.AccountName;
        passengerCell.nationalityLabel.text = passenger.AccountNationalityEn;
        __block Passenger*blockPasseger = passenger;
        __block RideDetailsViewController *blockSelf = self;
        [passengerCell setCallHandler:^{
            if(blockPasseger.AccountMobile.length > 0){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"tel:%@",blockPasseger.AccountMobile]]];
            }
            else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Account Mobile Number not avialable",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
        [passengerCell setMessageHandler:^{
            if(blockPasseger.AccountMobile.length > 0){
                [blockSelf sendSMSFromPhone:blockPasseger.AccountMobile];
            }
            else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Account Mobile Number not avialable",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
        [passengerCell setDeleteHandler:^{
            blockSelf.toBeDeletedpassenger = passenger;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"do you want to delete this passenger ?",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:@"Delete", nil];
            alertView.tag = PASSENGER_ALERT_TAG;
            [alertView show];
        }];
        [passengerCell setRatingHandler:^{
            
        }];
        return passengerCell ;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == reviewList) {
        return REVIEWS_CELL_HEIGHT;
    }
    else{
        return PASSENGER_CELLHEIGHT;
    }
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
    self.markers = [NSMutableArray array];
        CLLocationCoordinate2D startPosition = CLLocationCoordinate2DMake(self.routeDetails.StartLat.doubleValue, self.routeDetails.StartLng.doubleValue);
        GMSMarker *startMarker = [GMSMarker markerWithPosition:startPosition];
        MapItemView *startItem = [[MapItemView alloc] initWithLat:self.routeDetails.StartLat lng:self.routeDetails.StartLng address:self.routeDetails.FromStreetName name:self.routeDetails.FromEmirateEnName];
        startItem.arabicName = self.routeDetails.FromRegionArName;
        startItem.englishName = self.routeDetails.FromRegionEnName;
        startItem.rides = self.routeDetails.NoOfSeats.stringValue;
        startMarker.userData = startItem;
        startMarker.title = self.routeDetails.FromEmirateEnName;
        startMarker.icon = [UIImage imageNamed:@"Location"];
        startMarker.map = _mapView;
        [self.markers addObject:startMarker];
    
    CLLocationCoordinate2D endPosition = CLLocationCoordinate2DMake(self.routeDetails.EndLat.doubleValue, self.routeDetails.EndLng.doubleValue);
    GMSMarker *endMarker = [GMSMarker markerWithPosition:endPosition];
    MapItemView *endItem = [[MapItemView alloc] initWithLat:self.routeDetails.EndLat lng:self.routeDetails.EndLng address:self.routeDetails.ToStreetName name:self.routeDetails.ToEmirateEnName];
    endItem.arabicName = self.routeDetails.ToRegionArName;
    endItem.englishName = self.routeDetails.ToRegionEnName;
    endItem.rides = self.routeDetails.NoOfSeats.stringValue;
    endMarker.userData = endItem;
    endMarker.title = self.routeDetails.ToEmirateEnName;
    endMarker.icon = [UIImage imageNamed:@"Location"];
    endMarker.map = _mapView;
    [self.markers addObject:endMarker];
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
    
    [_mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:40.0f]];
}


#pragma mark - Message Delegate
- (void)sendSMSFromPhone:(NSString *)phone
{
    if(![MFMessageComposeViewController canSendText])
    {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSArray *recipents = @[phone];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

- (void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch(result)
    {
        case MessageComposeResultCancelled: break; //handle cancelled event
        case MessageComposeResultFailed: break; //handle failed event
        case MessageComposeResultSent: break; //handle sent event
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == PASSENGER_ALERT_TAG && buttonIndex == 1) {
        [self deletePassenger:self.toBeDeletedpassenger];
    }
}

@end
