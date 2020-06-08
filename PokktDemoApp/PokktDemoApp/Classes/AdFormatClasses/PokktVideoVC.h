#import <UIKit/UIKit.h>
#import <PokktSDK/PokktAds.h>

@interface PokktVideoVC : UIViewController<PokktAdDelegate>

{
    IBOutlet UITextField *screenTF;
    IBOutlet UIButton *cacheRewardedBtn;
    IBOutlet UIButton *showRewardedBtn;
    IBOutlet UIImageView *logoImg;
}
@property (weak, nonatomic) IBOutlet UILabel *rewardPointLabel;

@end
