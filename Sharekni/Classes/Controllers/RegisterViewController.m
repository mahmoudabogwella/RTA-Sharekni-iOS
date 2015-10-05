//
//  RegisterViewController.m
//  Sharekni
//
//  Created by Ahmed Askar on 9/25/15.
//
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
{
    
    __weak IBOutlet UIButton *driverBtn;
    __weak IBOutlet UIButton *passengerBtn;
    __weak IBOutlet UIButton *bothBtn;
    __weak IBOutlet UITextField *firstNametxt;
    __weak IBOutlet UITextField *lastNametxt;
    __weak IBOutlet UITextField *mobileNumberTxt;
    __weak IBOutlet UITextField *usernameTxt;
    __weak IBOutlet UITextField *passwordTxt;
    __weak IBOutlet UITextField *nationalityTxt;
    __weak IBOutlet UITextField *preferredLanguageTxt;
    __weak IBOutlet UILabel *dateLbl;
    __weak IBOutlet UIView *datePickerView;
    __weak IBOutlet UIButton *switchBtn;
    
    
    
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = NO ;
    
    [self configureUI];
    
    
}

- (void)configureUI
{
    [driverBtn    setBackgroundImage:[UIImage imageNamed:@"DriverUnActive"]    forState:UIControlStateNormal];
    [driverBtn    setBackgroundImage:[UIImage imageNamed:@"DriverActive"]      forState:UIControlStateSelected];
    [driverBtn    setSelected:NO];
   
    [passengerBtn setBackgroundImage:[UIImage imageNamed:@"PassengerUnActive"] forState:UIControlStateNormal];
    [passengerBtn setBackgroundImage:[UIImage imageNamed:@"PassengerActive"]   forState:UIControlStateSelected];
    [passengerBtn    setSelected:NO];

    [bothBtn      setBackgroundImage:[UIImage imageNamed:@"BothUnActive"]      forState:UIControlStateNormal];
    [bothBtn      setBackgroundImage:[UIImage imageNamed:@"BothActive"]        forState:UIControlStateSelected];
    [bothBtn    setSelected:NO];

    [switchBtn    setBackgroundImage:[UIImage imageNamed:@"select_Left"]       forState:UIControlStateNormal];
    [switchBtn    setBackgroundImage:[UIImage imageNamed:@"select_right"]      forState:UIControlStateSelected];
    [switchBtn    setSelected:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
