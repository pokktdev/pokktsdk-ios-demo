#import "PokktAdsVC.h"
#import <PokktSDK/PokktAds.h>
#import <QuartzCore/QuartzCore.h>

@interface PokktAdsVC ()

@property(strong,nonatomic)PokktConsentInfo *consentInfo;
@end

@implementation PokktAdsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    logoImg.transform = CGAffineTransformMakeRotation(-M_1_PI);
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
	
    [settings setValue:@"b26277c8c81d33706179288e7bcd9847" forKey:@"appId"];
    [settings setValue:@"04817587aa780627188b9dff0eb7757a" forKey:@"secKey"];

    [settings synchronize];
    
    self.versionLabel.text = [NSString stringWithFormat:@"v%@",PokktAds.getSDKVersion];
    self.consentInfo = [[PokktConsentInfo alloc] init];
    self.consentInfo.isGDPRApplicable = false;
    self.consentInfo.isGDPRConsentAvailable = true;
    [PokktAds setPokktConsentInfo:self.consentInfo];

}

-(IBAction)gdprConsent:(id)sender
{
    UISwitch *gdprSwitch = (UISwitch *)sender;
    if (gdprSwitch.tag == 101)
    {
        self.consentInfo.isGDPRApplicable = gdprSwitch.isOn;
    }
    else if (gdprSwitch.tag == 201)
    {
        self.consentInfo.isGDPRConsentAvailable = gdprSwitch.isOn;
    }

    [PokktAds setPokktConsentInfo:self.consentInfo];
}


-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    
    NSString *appId = [settings objectForKey:@"appId"];
    appIdLbl.text = appId;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
