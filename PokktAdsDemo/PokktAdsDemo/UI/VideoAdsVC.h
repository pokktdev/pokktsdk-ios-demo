//
//  VideoAdsVC.h
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



@interface VideoAdsVC : UIViewController<PokktVideoAdsDelegate, UITextFieldDelegate>
{
    IBOutlet UIButton *cacheRewardedVdo;
    IBOutlet UIButton *showRewardedVdo;
    IBOutlet UIButton *cacheNonRewardedVdo;
    IBOutlet UIButton *showNonRewardedVdo;
    
    IBOutlet UILabel *earnedPointLbl;
    IBOutlet UILabel *screenNameLbl;
    
    IBOutlet UITextField *screenTF;
    
    IBOutlet UIImageView *logoImgV;
    
    IBOutlet UIScrollView *scrollView;
    
}
@end
