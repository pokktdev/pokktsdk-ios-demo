#import "PokktNativeScrollVC.h"
#import "PokktUtility.h"

@interface PokktNativeScrollVC ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) UIView *adContainer;

@end

@implementation PokktNativeScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set scrollview content size
    CGFloat contentWidth = self.scrollView.bounds.size.width;
    CGFloat contentHeight = self.scrollView.bounds.size.height * 3;
    self.scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    
    // add subviews
    CGFloat subviewHeight = (CGFloat)200;
    CGFloat currentViewOffset = (CGFloat)0;
    
    while (currentViewOffset < contentHeight) {
        CGRect frame = CGRectInset(CGRectMake(0, currentViewOffset, contentWidth, subviewHeight), 5, 5);
        
        // try to attach ad container out of viewable area
        if (!self.adContainer && currentViewOffset > self.scrollView.bounds.size.height) {
            self.adContainer = [[UIView alloc] initWithFrame:frame];
            self.adContainer.backgroundColor = [UIColor blackColor];
            [self.scrollView addSubview:self.adContainer];
            currentViewOffset += subviewHeight;
            continue;
        }
        
        CGFloat hue = currentViewOffset / contentHeight;
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        subview.backgroundColor = [UIColor colorWithHue:hue saturation:1 brightness:1 alpha:1];
        [self.scrollView addSubview:subview];
        
        currentViewOffset += subviewHeight;
    }
    
    [self configurePokktSDK];
}

- (void)didReceiveMemoryWarning {
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
    [PokktAds requestNativeAd:_screenId withDelegate:self];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
}

- (void)adClicked:(NSString *)screenId
{
}

- (void)adClosed:(NSString *)screenId adCompleted:(BOOL)adCompleted
{
    NSLog(@"native ad closed, adCompleted:%@", (adCompleted ? @"YES" : @"NO"));
    
    NSString *msg = [NSString stringWithFormat:@"Native ad closed for screenId: %@, adCompleted: %@", screenId, (adCompleted ? @"YES" : @"NO")];
    [PokktDebugger showToast:msg viewController:self];
    
    [self.adContainer removeFromSuperview];
}

- (void)adGratified:(NSString *)screenId withReward:(double)reward
{
}

- (void)adDisplayResult:(NSString *)screenId isSuccess:(BOOL)success errorMessage:(NSString *)errorMessage
{
}

- (void)adCachingResult:(NSString *)screenId isSuccess:(BOOL)success withReward:(double)reward errorMessage:(NSString *)errorMessage
{
}


- (void)nativeAdFailed:(NSString *)screenId error:(NSString *)errorMessage
{
    NSLog(@"nativeAdFailed, error:%@", errorMessage);
    
    NSString *msg = [NSString stringWithFormat:@"Native ad failed for screenId: %@, error: %@", screenId, errorMessage];
    [PokktDebugger showToast:msg viewController:self];
    
    [self.adContainer removeFromSuperview];
}

- (void)nativeAdReady:(NSString *)screenId withNativeAd:(PokktNativeAd *)pokktNativeAd
{
    NSLog(@"nativeAdReady");
    
    NSString *msg = [NSString stringWithFormat:@"Native ad cached for %@", screenId];
    [PokktDebugger showToast:msg viewController:self];
    
    UIView *adView = [pokktNativeAd getMediaView];
    if (adView) {
        [self.adContainer addSubview:adView];
    }
}

@end
