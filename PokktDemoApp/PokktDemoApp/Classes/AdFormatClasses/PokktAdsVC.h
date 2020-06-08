#import <UIKit/UIKit.h>

@interface PokktAdsVC : UIViewController
{
     IBOutlet UIButton *videoBtn;
     IBOutlet UIButton *interstitialBtn;
     IBOutlet UIButton *bannerBtn;
     IBOutlet UIButton *outstreamBtn;
     IBOutlet UIButton *settingBtn;
    
     IBOutlet UIImageView *logoImg;
    
    IBOutlet UILabel *appIdLbl;
}
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property(strong,nonatomic)UIImagePickerController *picker;
@end
