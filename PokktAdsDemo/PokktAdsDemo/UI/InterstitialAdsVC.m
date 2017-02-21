//
//  InterstitialAdsVC.m
//  PokktAdsDemo
//
//  Created by Pokkt on 16/01/17.
//  Copyright © 2017 Pokkt. All rights reserved.
//

#import "InterstitialAdsVC.h"

#define EarnedPoints @"InterstitialPoints"
#define userDefaluts [NSUserDefaults standardUserDefaults]

@interface InterstitialAdsVC ()
@property (nonatomic) float points;

@end

@implementation InterstitialAdsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBorderColor];
    [self setNavigationTitle];
    [self updateEarnedPoints];
    [self registerOrientationNotification];
    [self setUpConstraints];

    
    logoImgV.transform = CGAffineTransformMakeRotation(-M_1_PI);
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    
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
    
    [PokktInterstial setPokktInterstitialDelegate:self];
}

-(void)viewDidAppear:(BOOL)animated
{
    [scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width- 20, 141)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cacheRewardedInterstitialAd:(id)sender
{
    [self addSpinnerOnButton:cacheRewardedInt];
    [PokktInterstial cacheRewarded:screenTF.text];
}

-(IBAction)showRewardedInterstitialAd:(id)sender
{
    [PokktInterstial showRewarded:screenTF.text withViewController:self];
}

-(IBAction)cacheNonRewardedInterstitialAd:(id)sender
{
    [self addSpinnerOnButton:cacheNonRewardedInt];
    [PokktInterstial cacheNonRewarded:screenTF.text];
}

-(IBAction)showNonRewardedInterstitialAd:(id)sender
{
    [PokktInterstial showNonRewarded:screenTF.text withViewController:self];
}

#pragma mark Pokkt Interstitial Ads Delegates

- (void)interstitialCachingCompleted: (NSString *)screenName isRewarded: (BOOL)isRewarded reward: (float)reward
{
    NSString *msg = [NSString stringWithFormat:@"Interstitial ad caching complete for %@ with reward point is %f",screenName,reward];
    [self showAlertWithMessage:msg];
    
    [self stopSpinner:cacheNonRewardedInt];
    [self stopSpinner:cacheRewardedInt];
}

- (void)interstitialCachingFailed: (NSString *)screenName isRewarded: (BOOL)isRewarded errorMessage: (NSString *)errorMessage
{
    NSString *msg = [NSString stringWithFormat:@"Interstitial ad caching failed for %@ with error is %@",screenName,errorMessage];
    [self showAlertWithMessage:msg];
    [self stopSpinner:cacheNonRewardedInt];
    [self stopSpinner:cacheRewardedInt];

}

- (void)interstitialCompleted: (NSString *)screenName isRewarded: (BOOL)isRewarded;
{
    NSString *msg = [NSString stringWithFormat:@"Interstitial ad complete for %@",screenName];
    
    [self showAlertWithMessage:msg];
}

- (void)interstitialDisplayed: (NSString *)screenName isRewarded: (BOOL)isRewarded
{
    NSString *msg = [NSString stringWithFormat:@"Interstitial ad displayed for %@",screenName];
    [self showAlertWithMessage:msg];
}

- (void)interstitialGratified: (NSString *)screenName reward:(float)reward
{
    if([userDefaluts objectForKey:EarnedPoints])
    {
        self.points = [[userDefaluts objectForKey:EarnedPoints] floatValue];
    }
    if (reward > 0)
    {
        self.points += reward;
        [userDefaluts setValue:[NSString stringWithFormat:@"%f",self.points] forKey:EarnedPoints];
        [userDefaluts synchronize];
        [self updateEarnedPoints];
    }
    
    NSString *msg = [NSString stringWithFormat:@"Interstitial ad gratified for %@ with reward is %f",screenName,reward];
    [self showAlertWithMessage:msg];
}

- (void)interstitialSkipped: (NSString *)screenName isRewarded: (BOOL)isRewarded
{
    NSString *msg = [NSString stringWithFormat:@"Interstitial ad skipper for %@",screenName];
    [self showAlertWithMessage:msg];
    
}

- (void)interstitialClosed:(NSString *)screenName isRewarded: (BOOL)isRewarded
{
    NSString *msg = [NSString stringWithFormat:@"Interstitial ad closed for %@",screenName];
    [self showAlertWithMessage:msg];
    
}

- (void)interstitialAvailabilityStatus: (NSString *)screenName isRewarded: (BOOL)isRewarded isAdAvailable: (BOOL)isAdAvailable
{
    NSString *statusString = @"is available";
    if (!isAdAvailable) {
        statusString = @"is not available";
    }
    NSString *msg = [NSString stringWithFormat:@"Interstitial ad %@ for %@",statusString,screenName];
    [self showAlertWithMessage:msg];
}

- (void)interstitialFailedToShow: (NSString *)screenName isRewarded: (BOOL)isRewarded errorMessage: (NSString *)errorMessage
{
    NSString *msg = [NSString stringWithFormat:@"Interstitial ad falied to show for %@",screenName];
    [self showAlertWithMessage:msg];
}

#pragma mark set up UI elements

- (void)updateEarnedPoints
{
    if([userDefaluts objectForKey:EarnedPoints])
    {
        self.points = [[userDefaluts objectForKey:EarnedPoints] floatValue];
        earnedPointLbl.text = [NSString stringWithFormat:@"Earned Points: %.02f",self.points];
    }
}

-(void)showAlertWithMessage:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void)setBorderColor
{
    [cacheRewardedInt.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [cacheRewardedInt.layer setBorderWidth:1];
    
    [showRewardedInt.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [showRewardedInt.layer setBorderWidth:1];
    
    [cacheNonRewardedInt.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [cacheNonRewardedInt.layer setBorderWidth:1];
    
    [showNonRewardedInt.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [showNonRewardedInt.layer setBorderWidth:1];
}

-(void)setNavigationTitle{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"BankGothicBold" size:22];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor darkGrayColor];
    self.navigationItem.titleView = label;
    label.text = @"Interstitial Ads";
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
    
    [cacheRewardedInt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(scrollView.mas_top).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.height.equalTo(@45);
    }];
    
    [showRewardedInt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(cacheRewardedInt.mas_bottom).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.height.equalTo(@45);
        
    }];
    
    [cacheNonRewardedInt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(showRewardedInt.mas_bottom).with.offset(35);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.height.equalTo(@45);
        
    }];
    
    [showNonRewardedInt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(cacheNonRewardedInt.mas_bottom).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.height.equalTo(@45);
        
    }];
    
}



@end
