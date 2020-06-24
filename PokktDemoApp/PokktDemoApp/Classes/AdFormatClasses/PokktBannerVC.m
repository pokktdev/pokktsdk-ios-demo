#import "PokktBannerVC.h"
#import "PokktSpinnerUtils.h"

@interface PokktBannerVC ()

@end

@implementation PokktBannerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    logoImgV.transform = CGAffineTransformMakeRotation(-M_1_PI);
    [self configurePokktSDK];
    screenTF.text =@"982affdc0f14ce349c62aab7e00c7bdd";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)configurePokktSDK
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    
    NSString *appId = [settings objectForKey:@"appId"];
    NSString *securityKey = [settings objectForKey:@"secKey"];
    
    /**
     * In [PokktAds setPokktConfig: securityKey:]
     * Replace "AppID" and "SecurityKey"  with the one assigned to you by Pokkt.
     */
    
    [PokktAds setPokktConfigWithAppId:appId securityKey:securityKey];
    
    // optional, set it to true if you want to enable logs for PokktSDK
    [PokktDebugger setDebug:YES];
}


#pragma mark Banner ad methods

-(IBAction)loadBannerAdTop:(id)sender
{
    CGRect adSize = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 50);
    self.banner_top = [[UIView alloc] initWithFrame:adSize];
    [self.banner_top setTag:1221];
    [self.banner_top setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.banner_top];
    
    [PokktSpinnerUtils addSpinnerOnButton:loadBanner_top];
    [PokktAds showAd:screenTF.text withDelegate:self inContainer:self.banner_top];

}

-(IBAction)destroyBannerAd_Top:(id)sender
{
    [PokktAds dismissAd:screenTF.text];
}

-(IBAction)loadBannerAdBottom:(id)sender
{
    CGRect adSize = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 50);
    self.banner_bottom = [[UIView alloc] initWithFrame:adSize];
    [self.banner_bottom setTag:1223];
    
    [self.banner_bottom setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.banner_bottom];
    
    [PokktSpinnerUtils addSpinnerOnButton:loadBanner_bottom];
    [PokktAds showAd:screenTF.text withDelegate:self inContainer:self.banner_bottom];
}

-(IBAction)destroyBannerAdBotton:(id)sender
{
    [PokktAds dismissAd:screenTF.text];
}

#pragma mark Pokkt Banner Ads Delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)adClicked:(NSString *)screenId
{
    NSString *msg = [NSString stringWithFormat:@"Banner Clicked for %@", screenId];
    [PokktDebugger showToast:msg viewController:self];
}

- (void)adReady:(NSString *)screenId withNativeAd:(PokktNativeAd *)pokktNativeAd
{
    NSLog(@"banner ready");
    NSString *msg = [NSString stringWithFormat:@"Banner loaded successfully for %@", screenId];
    [PokktDebugger showToast:msg viewController:self];
    [PokktSpinnerUtils stopSpinner:loadBanner_top];
    [PokktSpinnerUtils stopSpinner:loadBanner_bottom];
}

- (void)adFailed:(NSString *)screenId error:(NSString *)errorMessage
{
    NSString *msg = [NSString stringWithFormat:@"Banner loaded failed for screen  %@ with error is %@", screenId, errorMessage];
    [PokktDebugger showToast:msg viewController:self];
    [PokktSpinnerUtils stopSpinner:loadBanner_top];
    [PokktSpinnerUtils stopSpinner:loadBanner_bottom];
}

@end
