#import <UIKit/UIKit.h>
#import <PokktSDK/PokktAds.h>

@interface PokktNativeScrollVC : UIViewController <PokktNativeAdDelegate>
{
    
}

@property (strong, nonatomic) NSString *screenId;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inReadConstraint;

@end
