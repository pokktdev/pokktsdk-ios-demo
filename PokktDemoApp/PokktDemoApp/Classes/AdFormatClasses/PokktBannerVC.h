#import <UIKit/UIKit.h>
#import <PokktSDK/PokktAds.h>

@interface PokktBannerVC : UIViewController<PokktAdDelegate, UITextFieldDelegate>
{
    IBOutlet UIButton *loadBanner_top;
    IBOutlet UIButton *destroyBanner_top;
    
    IBOutlet UIButton *loadBanner_bottom;
    IBOutlet UIButton *destroyBanner_bottom;
    
    IBOutlet UITextField *screenTF;
    IBOutlet UIImageView *logoImgV;
}

@property(nonatomic,retain)UIView *banner_top;
@property(nonatomic,retain)UIView *banner_bottom;

@end
