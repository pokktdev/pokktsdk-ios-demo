//
//  PokktBannerVC.h
//  PokktDemoApp
//
//  Created by Suraj Singh on 16/05/18.
//  Copyright © 2018 Suraj Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PokktSDK/PokktAds.h>

@interface PokktBannerVC : UIViewController<PokktBannerAdDelegate, UITextFieldDelegate>
{
    IBOutlet UIButton *loadBanner_top;
    IBOutlet UIButton *destroyBanner_top;
    
    IBOutlet UIButton *loadBanner_bottom;
    IBOutlet UIButton *destroyBanner_bottom;
    
    IBOutlet UITextField *screenTF;
    IBOutlet UIImageView *logoImgV;
}

@property(nonatomic,retain)PokktBannerView *banner_top;
@property(nonatomic,retain)PokktBannerView *banner_bottom;

@end
