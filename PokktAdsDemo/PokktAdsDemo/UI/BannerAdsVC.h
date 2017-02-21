//
//  BannerAdsVC.h
//  PokktAdsDemo
//
//  Created by Pokkt on 16/01/17.
//  Copyright © 2017 Pokkt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <PokktSDK/PokktAds.h>
#import <PokktSDK/PokktAdsDelegates.h>

#import "MASConstraintMaker.h"
#import "View+MASAdditions.h"


@interface BannerAdsVC : UIViewController<PokktBannerDelegate,UITextFieldDelegate>
{
    IBOutlet UIButton *loadBanner_top;
    IBOutlet UIButton *destroyBanner_top;
    
    IBOutlet UIButton *loadBanner_bottom;
    IBOutlet UIButton *destroyBanner_bottom;
    
    IBOutlet UITextField *screenTF;
    
    IBOutlet UIImageView *logoImgV;
    PokktBannerView *banner_top;
    
    PokktBannerView *banner_bottom;
    
    IBOutlet UILabel *screenNameLbl;
    
    IBOutlet UIScrollView *scrollView;
}

@end
