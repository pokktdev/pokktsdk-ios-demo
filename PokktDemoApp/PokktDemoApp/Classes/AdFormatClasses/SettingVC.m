#import "SettingVC.h"

@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    logoImgV.transform = CGAffineTransformMakeRotation(-M_1_PI);
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    appIdTF.text = [settings objectForKey:@"appId"];
    secKeyTF.text = [settings objectForKey:@"secKey"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setValue:appIdTF.text forKey:@"appId"];
    [settings setValue:secKeyTF.text forKey:@"secKey"];
    [settings synchronize];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
