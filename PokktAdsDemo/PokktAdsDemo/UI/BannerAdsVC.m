//
//  BannerAdsVC.m
//  PokktAdsDemo
//
//  Created by Pokkt on 16/01/17.
//  Copyright © 2017 Pokkt. All rights reserved.
//

#import "BannerAdsVC.h"

@interface BannerAdsVC ()
@property (nonatomic,retain) NSString *screenName;

@end

@implementation BannerAdsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBorderColor];
    [self setNavigationTitle];
    [self registerOrientationNotification];
    [self setUpConstraints];

    logoImgV.transform = CGAffineTransformMakeRotation(-M_1_PI);

    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    self.screenName = [settings objectForKey:@"screenname"];
    NSString *appId = [settings objectForKey:@"appId"];
    NSString *securityKey = [settings objectForKey:@"secKey"];
    
    /**
     * In [PokktAds setPokktConfig: securityKey:]
     * Replace "AppID" and "SecurityKey"  with the one assigned to you by Pokkt.
     *
     */

    [PokktAds setPokktConfigWithAppId:appId securityKey:securityKey];
    
    // optional, set it to true if you want to enable logs for PokktSDK
    
    [PokktDebugger setDebug:YES];
    
    // OPTIONAL but we SUGGEST you to implement delegates as it will help you to determine the status of your request
    
    [PokktBanner setPokktBannerDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width- 20, 141)];
}

#pragma mark Banner ad methods

-(IBAction)loadBannerAdTop:(id)sender
{
    banner_top = [PokktBanner initWithBannerAdSize:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    [banner_top setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:banner_top];
    
    [self addSpinnerOnButton:loadBanner_top];
    [PokktBanner loadBanner:banner_top withScreenName:screenTF.text rootViewContorller:self];
    [PokktBanner setBannerAutoRefresh:YES];
    
}

-(IBAction)destroyBannerAd_Top:(id)sender
{
    [PokktBanner destroyBanner:banner_top];
}

-(IBAction)loadBannerAdBottom:(id)sender
{
    banner_bottom = [PokktBanner initWithBannerAdSize:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 50)];
        
    [banner_bottom setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:banner_bottom];
    
    [self addSpinnerOnButton:loadBanner_bottom];
    [PokktBanner loadBanner:banner_bottom withScreenName:screenTF.text rootViewContorller:self];
    [PokktBanner setBannerAutoRefresh:YES];
    
    [banner_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.width.equalTo(@320);
        make.height.equalTo(@50);
    }];

}

-(IBAction)destroyBannerAdBotton:(id)sender
{
    [PokktBanner destroyBanner:banner_bottom];
}


#pragma mark Pokkt Banner Ads Delegates

- (void)bannerLoaded:(NSString *)screenName
{
    NSString *msg = [NSString stringWithFormat:@"Banner loaded successfully for %@",screenName];
    [self showAlertWithMessage:msg];
    
    [self stopSpinner:loadBanner_top];
    [self stopSpinner:loadBanner_bottom];
    
}

- (void)bannerLoadFailed:(NSString *)screenName errorMessage:(NSString *)errorMessage
{
    NSString *msg = [NSString stringWithFormat:@"Banner loaded failed for screen  %@ with error is %@",screenName,errorMessage];
    [self showAlertWithMessage:msg];
    [self stopSpinner:loadBanner_top];
    [self stopSpinner:loadBanner_bottom];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark set up UI elements

-(void)showAlertWithMessage:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void)setBorderColor
{
    [loadBanner_top.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [loadBanner_top.layer setBorderWidth:1];
    
    [destroyBanner_top.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [destroyBanner_top.layer setBorderWidth:1];
    
    [loadBanner_bottom.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [loadBanner_bottom.layer setBorderWidth:1];
    
    [destroyBanner_bottom.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [destroyBanner_bottom.layer setBorderWidth:1];
}

-(void)setNavigationTitle{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"BankGothicBold" size:22];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor darkGrayColor];
    self.navigationItem.titleView = label;
    label.text = @"Banner Ads";
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

-(void)addSpinnerOnButton:(UIButton *)button
{
    UIControl *layer  = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height)];
    [layer setTag:button.tag+2000];
    [layer setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
    [button addSubview:layer];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.alpha = 1.0;
    activityIndicator.tag = button.tag + 1000;
    [button addSubview:activityIndicator];
    activityIndicator.center = CGPointMake(button.frame.size.width/2, button.frame.size.height/2);
    [activityIndicator startAnimating];
}

-(void)stopSpinner:(UIButton *)button
{
    UIActivityIndicatorView *spinner = [button viewWithTag:button.tag+1000];
    
    if (spinner != nil)
    {
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        spinner = nil;
    }
    
    UIControl *layer = (UIControl *)[button viewWithTag:button.tag+2000];
    
    if (layer != nil)
    {
        [layer removeFromSuperview];
        layer = nil;
    }
}

#pragma mark - Orienation

-(void)registerOrientationNotification
{
    UIDeviceOrientation  m_CurrentOrientation = [[UIDevice currentDevice] orientation];
    
    if (m_CurrentOrientation == UIDeviceOrientationLandscapeLeft
        || m_CurrentOrientation == UIDeviceOrientationLandscapeRight )
    {
        
    }
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)deviceOrientationDidChange:(NSNotification *)notification
{
    UIDeviceOrientation  m_CurrentOrientation = [[UIDevice currentDevice] orientation];
    if (m_CurrentOrientation == UIDeviceOrientationLandscapeLeft || m_CurrentOrientation == UIDeviceOrientationLandscapeRight)
    {
        [scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 341)];
    }
    else if (m_CurrentOrientation == UIDeviceOrientationPortrait || m_CurrentOrientation == UIDeviceOrientationPortraitUpsideDown)
    {
        [scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 241)];
    }
}


-(void)setUpConstraints
{
    [logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(-50);
        make.right.equalTo(self.view.mas_right).with.offset(70);
        make.top.equalTo(self.view.mas_top).with.offset([UIScreen mainScreen].bounds.size.height/2 - 30);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-([UIScreen mainScreen].bounds.size.height - 100));
        
    }];
    
    [screenNameLbl mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(self.view.mas_top).with.offset(50);
    }];
    
    [screenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(screenNameLbl.mas_bottom).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
    }];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(2);
        make.right.equalTo(self.view.mas_right).with.offset(-2);
        make.top.equalTo(screenTF.mas_bottom).with.offset(15);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
    }];
        
    [loadBanner_top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(scrollView.mas_top).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.height.equalTo(@45);
    }];
    
    [destroyBanner_top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(loadBanner_top.mas_bottom).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.height.equalTo(@45);
        
    }];
    
    [loadBanner_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(destroyBanner_top.mas_bottom).with.offset(35);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.height.equalTo(@45);
        
    }];
    
    [destroyBanner_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(loadBanner_bottom.mas_bottom).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.height.equalTo(@45);
        
    }];
}

@end
