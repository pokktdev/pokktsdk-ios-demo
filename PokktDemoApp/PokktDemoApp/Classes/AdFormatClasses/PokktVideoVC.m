#import "PokktVideoVC.h"
#import "PokktSpinnerUtils.h"


#define EarnedPoints @"Points"
#define userDefaluts [NSUserDefaults standardUserDefaults]


@interface PokktVideoVC ()

@property (nonatomic) float points;

@end


@implementation PokktVideoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    logoImg.transform = CGAffineTransformMakeRotation(-M_1_PI);
    [self updateEarnedPoints];
    [self configurePokktSDK];
    screenTF.text = @"ca2c7931cb6549bc6f32101231515ed2";
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


#pragma mark UIButton Actions

-(IBAction)cacheFullScreenAd:(id)sender
{
    [PokktSpinnerUtils addSpinnerOnButton:cacheRewardedBtn];
    [PokktAds cacheAd:screenTF.text withDelegate:self];
}

-(IBAction)showFullScreenAd:(id)sender
{
    [PokktAds showAd:screenTF.text withDelegate:self presentingVC:self];
}


#pragma mark Textfield Delegate Method

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)updateEarnedPoints
{
    if([userDefaluts objectForKey:EarnedPoints])
    {
        self.points = [[userDefaluts objectForKey:EarnedPoints] floatValue];
        self.rewardPointLabel.text = [NSString stringWithFormat:@"Earned Points: %.02f",self.points];
    }
}


#pragma mark Pokkt Video Ads Delegates

- (void)adClicked:(NSString *)screenId
{
    NSString *msg = [NSString stringWithFormat:@"Video ad Clicked for %@", screenId];
    [PokktDebugger showToast:msg viewController:self];
}

- (void)adClosed:(NSString *)screenId adCompleted:(BOOL)adCompleted
{
    NSString *msg = [NSString stringWithFormat:@"Video ad closed for %@, ad was completed: %@", screenId, (adCompleted ? @"YES" : @"NO")];
    [PokktDebugger showToast:msg viewController:self];
}

- (void)adGratified:(NSString *)screenId withReward:(double)reward
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
    NSString *msg = [NSString stringWithFormat:@"Video ad gratified for %@ with reward is %f", screenId, reward];
    [PokktDebugger showToast:msg viewController:self];
}

- (void)adCachingResult:(NSString *)screenId isSuccess:(BOOL)success withReward:(double)reward errorMessage:(NSString *)errorMessage {
    [PokktSpinnerUtils stopSpinner:cacheRewardedBtn];
    NSString *msg = @"";
    
    if([errorMessage  isEqual: @""] || success == YES) {
        msg = [NSString stringWithFormat:@"Video ad caching complete for %@ with reward point is %f", screenId, reward];
    } else {
        msg = [NSString stringWithFormat:@"Video ad caching failed for %@ with error is %@", screenId, errorMessage];
    }
    
    [PokktDebugger showToast:msg viewController:self];
}

- (void)adDisplayResult:(NSString *)screenId isSuccess:(BOOL)success errorMessage:(NSString *)errorMessage {
    NSString *msg = @"";
    if([errorMessage  isEqual: @""] || success == YES) {
        msg = [NSString stringWithFormat:@"Video ad displayed for %@", screenId];
    } else {
        msg = [NSString stringWithFormat:@"Video ad falied to show for %@ with error %@", screenId, errorMessage];
    }
    
    [PokktDebugger showToast:msg viewController:self];
}

@end
