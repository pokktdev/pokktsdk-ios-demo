//
//  PokktDemoOptionVC.m
//  PokktAdsDemo
//
//  Created by Pokkt on 16/01/17.
//  Copyright © 2017 Pokkt. All rights reserved.
//

#import "PokktDemoOptionVC.h"
#import "VideoAdsVC.h"
#import "BannerAdsVC.h"
#import "InterstitialAdsVC.h"
#import "SettingVC.h"

@interface PokktDemoOptionVC ()
@end


@implementation PokktDemoOptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBorderColor];

    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setValue:@"a2717a45b835b5e9f50284a38d62a74e" forKey:@"appId"];
    [settings setValue:@"iJ02lJss0M" forKey:@"secKey"];
    [settings synchronize];
    
    logoImgV.transform = CGAffineTransformMakeRotation(-M_1_PI);
    
    [self registerOrientationNotification];
    
    [logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.view.mas_left).with.offset(-50);
       make.right.equalTo(self.view.mas_right).with.offset(70);
        make.top.equalTo(self.view.mas_top).with.offset([UIScreen mainScreen].bounds.size.height/2 -100);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-([UIScreen mainScreen].bounds.size.height - 100));
        
    }];
    
    sdkVersion.text = [NSString stringWithFormat:@"v%@",[PokktAds getSDKVersion]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 141)];
}

-(IBAction)videoAdsDemo:(id)sender
{
    VideoAdsVC *video = [[VideoAdsVC alloc] initWithNibName:@"VideoAdsVC" bundle:nil];
    [self.navigationController pushViewController:video animated:YES];
}

-(IBAction)interstitialAdsDemo:(id)sender
{
    InterstitialAdsVC *interstitial = [[InterstitialAdsVC alloc] initWithNibName:@"InterstitialAdsVC" bundle:nil];
    [self.navigationController pushViewController:interstitial animated:YES];
}

-(IBAction)bannerAdsDemo:(id)sender
{
    BannerAdsVC *banner = [[BannerAdsVC alloc] initWithNibName:@"BannerAdsVC" bundle:nil];
    [self.navigationController pushViewController:banner animated:YES];
}

-(IBAction)settingVC:(id)sender
{
    SettingVC *setting = [[SettingVC alloc] initWithNibName:@"SettingVC" bundle:nil];
    [self.navigationController pushViewController:setting animated:YES];
}

-(void)setBorderColor
{
    [videoAdsBtn.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [videoAdsBtn.layer setBorderWidth:1];
    
    [interstitialAdsBtn.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [interstitialAdsBtn.layer setBorderWidth:1];
    
    [bannerAdsBtn.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [bannerAdsBtn.layer setBorderWidth:1];
    
    [settingBtn.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [settingBtn.layer setBorderWidth:1];
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
        [scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 441)];
    }
    else if (m_CurrentOrientation == UIDeviceOrientationPortrait || m_CurrentOrientation == UIDeviceOrientationPortraitUpsideDown)
    {
        [scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 241)];
    }
}


@end
