//
//  VideoAdsVC.m
//  PokktAdsDemo
//
//  Created by Pokkt on 16/01/17.
//  Copyright © 2017 Pokkt. All rights reserved.
//

#import "VideoAdsVC.h"

#define EarnedPoints @"Points"
#define userDefaluts [NSUserDefaults standardUserDefaults]

@interface VideoAdsVC ()

@property (nonatomic) float points;
@end

@implementation VideoAdsVC

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

    [PokktVideoAds setPokktVideoAdsDelegate:self];
}

-(void)viewDidAppear:(BOOL)animated
{
    [scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width- 20, 141)];
}

-(IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cacheRewardedVideoAd:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [self addSpinnerOnButton:btn];
    
    [PokktVideoAds cacheRewarded:screenTF.text];
}

-(IBAction)showRewardedVideoAd:(id)sender
{
    [PokktVideoAds showRewarded:screenTF.text withViewController:self];
}

-(IBAction)cacheNonRewardedVideoAd:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [self addSpinnerOnButton:btn];
    [PokktVideoAds cacheNonRewarded:screenTF.text];
}

-(IBAction)showNonRewardedVideoAd:(id)sender
{
    [PokktVideoAds showNonRewarded:screenTF.text withViewController:self];
}

#pragma mark Pokkt Video Ads Delegates

- (void)videoAdCachingCompleted: (NSString *)screenName isRewarded: (BOOL)isRewarded reward: (float)reward
{
    NSString *msg = [NSString stringWithFormat:@"Video ad caching complete for %@ with reward point is %f",screenName,reward];
    [self showAlertWithMessage:msg];
    
    [self stopSpinner:cacheRewardedVdo];
    [self stopSpinner:cacheNonRewardedVdo];
}

- (void)videoAdCachingFailed: (NSString *)screenName isRewarded: (BOOL)isRewarded errorMessage: (NSString *)errorMessage
{
    NSString *msg = [NSString stringWithFormat:@"Video ad caching failed for %@ with error is %@",screenName,errorMessage];
    [self showAlertWithMessage:msg];
    [self stopSpinner:cacheRewardedVdo];
    [self stopSpinner:cacheNonRewardedVdo];
}

- (void)videoAdCompleted: (NSString *)screenName isRewarded: (BOOL)isRewarded
{
    NSString *msg = [NSString stringWithFormat:@"Video ad complete for %@",screenName];
    
    [self showAlertWithMessage:msg];
}

- (void)videoAdDisplayed: (NSString *)screenName isRewarded: (BOOL)isRewarded
{
    NSString *msg = [NSString stringWithFormat:@"Video ad displayed for %@",screenName];
    [self showAlertWithMessage:msg];
}

- (void)videoAdGratified: (NSString *)screenName reward:(float)reward
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
    
    NSString *msg = [NSString stringWithFormat:@"Video ad gratified for %@ with reward is %f",screenName,reward];
    [self showAlertWithMessage:msg];
}

- (void)videoAdSkipped: (NSString *)screenName isRewarded: (BOOL)isRewarded
{
    NSString *msg = [NSString stringWithFormat:@"Video ad skipper for %@",screenName];
    [self showAlertWithMessage:msg];
}

- (void)videoAdClosed:(NSString *)screenName isRewarded: (BOOL)isRewarded
{
    NSString *msg = [NSString stringWithFormat:@"Video ad closed for %@",screenName];
    [self showAlertWithMessage:msg];
}

- (void)videoAdAvailabilityStatus: (NSString *)screenName isRewarded: (BOOL)isRewarded isAdAvailable: (BOOL)isAdAvailable
{
    NSString *statusString = @"is available";
    if (!isAdAvailable) {
        statusString = @"is not available";
    }
    NSString *msg = [NSString stringWithFormat:@"Video ad %@ for %@",statusString,screenName];
    [self showAlertWithMessage:msg];
}

- (void)videoAdFailedToShow: (NSString *)screenName isRewarded: (BOOL)isRewarded errorMessage: (NSString *)errorMessage
{
    NSString *msg = [NSString stringWithFormat:@"Video ad falied to show for %@",screenName];
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
    [cacheRewardedVdo.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [cacheRewardedVdo.layer setBorderWidth:1];
    
    [showRewardedVdo.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [showRewardedVdo.layer setBorderWidth:1];
    
    [cacheNonRewardedVdo.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [cacheNonRewardedVdo.layer setBorderWidth:1];
    
    [showNonRewardedVdo.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [showNonRewardedVdo.layer setBorderWidth:1];
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

-(void)setNavigationTitle{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"BankGothicBold" size:22];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor darkGrayColor];
    self.navigationItem.titleView = label;
    label.text = @"Video Ads";
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
    
    [cacheRewardedVdo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(scrollView.mas_top).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.height.equalTo(@45);
    }];
    
    [showRewardedVdo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(cacheRewardedVdo.mas_bottom).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.height.equalTo(@45);
        
    }];
    
    [cacheNonRewardedVdo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(showRewardedVdo.mas_bottom).with.offset(35);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.height.equalTo(@45);
        
    }];
    
    [showNonRewardedVdo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.top.equalTo(cacheNonRewardedVdo.mas_bottom).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.height.equalTo(@45);
        
    }];

}




@end
