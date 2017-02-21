//
//  InterstitialAdsVC.h
//  PokktAdsDemo
//
//  Created by Pokkt on 16/01/17.
//  Copyright © 2017 Pokkt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PokktSDK/PokktAds.h>
#import <PokktSDK/PokktAdsDelegates.h>

#import "MASConstraintMaker.h"
#import "View+MASAdditions.h"



@interface InterstitialAdsVC : UIViewController<PokktInterstitialDelegate,UITextFieldDelegate>
{
    IBOutlet UIButton *cacheRewardedInt;
    IBOutlet UIButton *showRewardedInt;
    IBOutlet UIButton *cacheNonRewardedInt;
    IBOutlet UIButton *showNonRewardedInt;

    IBOutlet UILabel *earnedPointLbl;
    IBOutlet UITextField *screenTF;
    IBOutlet UIImageView *logoImgV;
    
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UILabel *screenNameLbl;
}
@end
