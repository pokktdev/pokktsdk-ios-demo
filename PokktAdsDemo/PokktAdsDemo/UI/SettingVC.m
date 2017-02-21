//
//  SettingVC.m
//  PokktAdsDemo
//
//  Created by Pokkt on 16/01/17.
//  Copyright © 2017 Pokkt. All rights reserved.
//

#import "SettingVC.h"

@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationTitle];
    logoImgV.transform = CGAffineTransformMakeRotation(-M_1_PI);
    [exportLogBtn.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [exportLogBtn.layer setBorderWidth:1];
    
    [self setUpConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)exportLog:(id)sender
{
    [PokktDebugger exportLog:self];
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

-(void)setUpConstraints
{
    [logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(-50);
        make.right.equalTo(self.view.mas_right).with.offset(70);
        make.top.equalTo(self.view.mas_top).with.offset([UIScreen mainScreen].bounds.size.height/2 - 30);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-([UIScreen mainScreen].bounds.size.height - 100));
        
    }];
    
    [ipLbl mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(self.view.mas_top).with.offset(50);
    }];
    
    [ipAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(ipLbl.mas_bottom).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
    }];
    
    [appIdLbl mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(ipAddress.mas_bottom).with.offset(20);
    }];
    
    [appIdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(appIdLbl.mas_bottom).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
    }];
    
    [secKeyLbl mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(appIdTF.mas_bottom).with.offset(20);
    }];
    
    [secKeyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(secKeyLbl.mas_bottom).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
    }];
    
    [exportLogBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(secKeyTF.mas_bottom).with.offset(35);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.height.equalTo(@45);
        
    }];
    
}

-(void)setNavigationTitle
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"BankGothicBold" size:22];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor darkGrayColor];
    self.navigationItem.titleView = label;
    label.text = @"Settings";
    [label sizeToFit];
    
    [self.navigationController.navigationBar setTintColor:[UIColor darkGrayColor]];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{UITextAttributeTextColor:[UIColor darkGrayColor],
       UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
       UITextAttributeTextShadowColor:[UIColor whiteColor],
       UITextAttributeFont:[UIFont fontWithName:@"BankGothicBold" size:19]
       }
                                                                                            forState:UIControlStateNormal];
    
}




@end
