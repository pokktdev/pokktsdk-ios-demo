//
//  PokktDemoOptionVC.h
//  PokktAdsDemo
//
//  Created by Pokkt on 16/01/17.
//  Copyright © 2017 Pokkt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MASConstraintMaker.h"
#import "View+MASAdditions.h"

@interface PokktDemoOptionVC : UIViewController
{
    IBOutlet UIButton *videoAdsBtn;
    IBOutlet UIButton *interstitialAdsBtn;
    IBOutlet UIButton *bannerAdsBtn;
    IBOutlet UIButton *settingBtn;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIImageView *logoImgV;
    IBOutlet UILabel *sdkVersion;
}
@end
