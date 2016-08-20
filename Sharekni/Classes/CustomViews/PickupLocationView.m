//
//  PickupLocationView.m
//  Sharekni
//
//  Created by ITWORX on 10/7/15.
//
//

#import "PickupLocationView.h"
#import "HelpManager.h"
#import "MasterDataManager.h"
#import "Region.h"
#import "Emirate.h"
#import "Constants.h"
#import <KVNProgress/KVNProgress.h>
#import "NSObject+Blocks.h"
#import <UIColor+Additions.h>
@interface PickupLocationView()
@property (weak, nonatomic) IBOutlet UITextField *emirateTextField;
@property (weak, nonatomic) IBOutlet UITextField *regionTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UILabel *regionView;
@property (weak, nonatomic) IBOutlet UILabel *emirateView;

@property (nonatomic,strong) NSArray *emirates;
@property (nonatomic,strong) NSArray *regions;
@property (nonatomic,strong) Emirate *selectedEmirate;
@property (nonatomic,strong) Emirate *selectedRegion;
@end
@implementation PickupLocationView

- (instancetype)init{
    self = [[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@",[PickupLocationView class]] owner:self options:nil] objectAtIndex:0];
    
    if(self){
        self.frame = CGRectMake(0, 0, 300, 200);
        [self configureData];
        [self configureUI];
    }
    return self;
}

- (void) configureData{
    __block PickupLocationView *blockSelf = self;
    [KVNProgress showWithStatus:GET_STRING(@"Loading...")];
 [[MasterDataManager sharedMasterDataManager] GetEmiratesWithSuccess:^(NSMutableArray *array) {
     blockSelf.emirates = array;
     [KVNProgress dismiss];
 } Failure:^(NSString *error) {
     NSLog(@"Error in Emirates");
     [KVNProgress dismiss];
     [KVNProgress showErrorWithStatus:@"Error"];
     [blockSelf performBlock:^{
         [KVNProgress dismiss];
     } afterDelay:3];
 }];
}

- (void) configureRegionsWithSelectedEmirate{
    if (self.selectedEmirate) {
        __block PickupLocationView *blockSelf = self;
        [KVNProgress showWithStatus:GET_STRING(@"Loading...")];
        [[MasterDataManager sharedMasterDataManager] GetRegionsByEmirateID:self.selectedEmirate.EmirateId withSuccess:^(NSMutableArray *array) {
            blockSelf.regions = array;
            [KVNProgress dismiss];
        } Failure:^(NSString *error) {
            [KVNProgress dismiss];
            [KVNProgress showErrorWithStatus:@"Error"];
            [blockSelf performBlock:^{
                [KVNProgress dismiss];
            } afterDelay:3];
        }];
    }
}

- (void) configureUI{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.emirateView.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerTopLeft)
                                           cornerRadii:CGSizeMake(5.0, 5.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.emirateView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.emirateView.layer.mask = maskLayer;
    
    
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.regionView.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerTopLeft)
                                           cornerRadii:CGSizeMake(5.0, 5.0)];
    
    maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.regionView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.regionView.layer.mask = maskLayer;
    
    
    self.emirateTextField.delegate = self;
    self.regionTextField.delegate = self;
    
    UITapGestureRecognizer *dismissGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissHandler)];
    [self addGestureRecognizer:dismissGestureRecognizer];
    
    self.searchButton.layer.cornerRadius = 8;
    [self.searchButton setBackgroundColor:Red_UIColor];
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
}

- (IBAction)search:(id)sender {
    
}

- (void) dismissHandler{
    [self endEditing:YES];
}

- (void) showEmiratePicker{
    __block PickupLocationView *blockSelf = self;
    RMAction * selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        UIPickerView *picker = ((RMPickerViewController *)controller).picker;
        blockSelf.selectedEmirate = [self.emirates objectAtIndex:[picker selectedRowInComponent:0]];
        [blockSelf configureRegionsWithSelectedEmirate];
        blockSelf.emirateTextField.text = blockSelf.selectedEmirate.EmirateArName;
    }];
    
    RMAction *cancelAction = [RMAction actionWithTitle:GET_STRING(@"Cancel") style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        NSLog(@"Row selection was canceled");
    }];
    
    //Create picker view controller
    RMPickerViewController *pickerController = [RMPickerViewController actionControllerWithStyle:RMActionControllerStyleDefault selectAction:selectAction andCancelAction:cancelAction];
    
    pickerController.picker.delegate = self;
    pickerController.picker.dataSource = self;
    
    [self.presenter presentViewController:pickerController animated:YES completion:nil];
}

#pragma PickerViewDeelgate&DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.emirates.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    Emirate *emirate = [self.emirates objectAtIndex:row];
    return  emirate.EmirateArName;
}


#pragma TextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == self.emirateTextField ){
        [self showEmiratePicker];
    }
    else if (textField == self.regionTextField){
        return YES;
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
