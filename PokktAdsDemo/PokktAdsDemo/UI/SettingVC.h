//
//  SettingVC.h
//  PokktAdsDemo
//
//  Created by Pokkt on 16/01/17.
//  Copyright © 2017 Pokkt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PokktSDK/PokktAds.h>

#import "MASConstraintMaker.h"
#import "View+MASAdditions.h"


@interface SettingVC : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *ipAddress;
    IBOutlet UITextField *appIdTF;
    IBOutlet UITextField *secKeyTF;
    IBOutlet UIButton *exportLogBtn;
    IBOutlet UIImageView *logoImgV;
    
    IBOutlet UILabel *ipLbl;
    IBOutlet UILabel *appIdLbl;
    IBOutlet UILabel *secKeyLbl;
    
}

@end
