//
//  selectLocationViewController.m
//  Sharekni
//
//  Created by ITWORX on 10/7/15.
//
//

#import "SelectLocationViewController.h"
#import "HelpManager.h"
#import "MasterDataManager.h"
#import "Region.h"
#import "Emirate.h"
#import "Constants.h"
#import <KVNProgress/KVNProgress.h>
#import "NSObject+Blocks.h"
#import <UIColor+Additions.h>
#import <RMActionController.h>
#import <RMPickerViewController.h>

@interface SelectLocationViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *emirateTextField;
@property (weak, nonatomic) IBOutlet UITextField *regionTextField;
@property (weak, nonatomic) IBOutlet UIButton *DoneButton;
@property (weak, nonatomic) IBOutlet UILabel *regionView;
@property (weak, nonatomic) IBOutlet UILabel *emirateView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,strong) NSArray *emirates;
@property (nonatomic,strong) NSArray *regions;
@property (nonatomic,strong) Emirate *selectedEmirate;
@property (nonatomic,strong) Emirate *selectedRegion;

@end

@implementation SelectLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureData];
    [self configureUI];
}


- (void) configureData{
    __block SelectLocationViewController *blockSelf = self;
    [KVNProgress showWithStatus:@"Loading"];
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
        __block SelectLocationViewController *blockSelf = self;
        [KVNProgress showWithStatus:@"Loading"];
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
    [self.view addGestureRecognizer:dismissGestureRecognizer];
    
    self.DoneButton.layer.cornerRadius = 8;
    [self.DoneButton setBackgroundColor:Red_UIColor];
    [self.DoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.titleLabel.textColor = Red_UIColor;
}

- (IBAction)DoneAction:(id)sender {
    
}

- (void) dismissHandler{
    [self.view endEditing:YES];
}

- (void) showEmiratePicker{
    __block SelectLocationViewController *blockSelf = self;
    RMAction * selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        UIPickerView *picker = ((RMPickerViewController *)controller).picker;
        blockSelf.selectedEmirate = [self.emirates objectAtIndex:[picker selectedRowInComponent:0]];
        [blockSelf configureRegionsWithSelectedEmirate];
        blockSelf.emirateTextField.text = blockSelf.selectedEmirate.EmirateArName;
    }];
    
    RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        NSLog(@"Row selection was canceled");
    }];
    
    //Create picker view controller
    RMPickerViewController *pickerController = [RMPickerViewController actionControllerWithStyle:RMActionControllerStyleDefault selectAction:selectAction andCancelAction:cancelAction];
    
    pickerController.picker.delegate = self;
    pickerController.picker.dataSource = self;
    
    [self presentViewController:pickerController animated:YES completion:nil];
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
