#import "PokktBannerVC.h"
#import "PokktUtility.h"

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
    self.banner_top = [[PokktBannerView alloc] initWithFrame:adSize];
    [self.banner_top setTag:1221];
    [self.banner_top setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.banner_top];
    
    [PokktUtility addSpinnerOnButton:loadBanner_top];
    [PokktAds showAd:screenTF.text
  withViewController:self
     bannerContainer:self.banner_top
        withDelegate:self];
}

-(IBAction)destroyBannerAd_Top:(id)sender
{
    [PokktAds destroyBanner:self.banner_top];
}

-(IBAction)loadBannerAdBottom:(id)sender
{
    CGRect adSize = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 50);
    self.banner_bottom = [[PokktBannerView alloc] initWithFrame:adSize];
    [self.banner_bottom setTag:1223];
    
    [self.banner_bottom setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.banner_bottom];
    
    [PokktUtility addSpinnerOnButton:loadBanner_bottom];
    [PokktAds showAd:screenTF.text
  withViewController:self
     bannerContainer:self.banner_bottom
        withDelegate:self];
}

-(IBAction)destroyBannerAdBotton:(id)sender
{
    [PokktAds destroyBanner:self.banner_bottom];
}


#pragma mark Pokkt Banner Ads Delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)adDisplayResult:(NSString *)screenId isSuccess:(BOOL)success errorMessage:(NSString *)errorMessage
{
    NSString *msg = @"";
    
    if([errorMessage  isEqual: @""] || success == YES) {
        msg = [NSString stringWithFormat:@"Banner loaded successfully for %@", screenId];
    } else {
        msg = [NSString stringWithFormat:@"Banner loaded failed for screen  %@ with error is %@", screenId, errorMessage];
    }
    
    [PokktDebugger showToast:msg viewController:self];
    [PokktUtility stopSpinner:loadBanner_top];
    [PokktUtility stopSpinner:loadBanner_bottom];
}

- (void)bannerCollapsed:(NSString *)screenId
{
    // handle if required
}

- (void)bannerExpanded:(NSString *)screenId
{
    // handle if required
}

- (void)bannerResized:(NSString *)screenId
{
    // handle if required
}

- (void)adClicked:(NSString *)screenId
{
    NSString *msg = [NSString stringWithFormat:@"Banner Clicked for %@", screenId];
    [PokktDebugger showToast:msg viewController:self];
}

- (void)adCached:(NSString *)screenId withReward:(double)reward {/* IGNORE */}
- (void)adClosed:(NSString *)screenId adCompleted:(BOOL)adCompleted {/* IGNORE */}
- (void)adFailedToCache:(NSString *)screenId errorMessage:(NSString *)errorMessage {/* IGNORE */}
- (void)adGratified:(NSString *)screenId withReward:(double)reward {/* IGNORE */}

@end
