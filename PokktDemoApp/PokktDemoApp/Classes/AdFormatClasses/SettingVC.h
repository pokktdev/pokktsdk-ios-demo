//
//  SettingVC.h
//  PokktDemoApp
//
//  Created by Suraj Singh on 16/05/18.
//  Copyright © 2018 Suraj Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PokktSDK/PokktAds.h>

@interface SettingVC : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *appIdTF;
    IBOutlet UITextField *secKeyTF;
    IBOutlet UIButton *exportLogBtn;
    IBOutlet UIImageView *logoImgV;
}
@end
