//
//  PokktNativeScrollVC.h
//  PokktDemoApp
//
//  Created by Ranajit Chandra on 06/04/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PokktSDK/PokktAds.h>

@interface PokktNativeScrollVC : UIViewController <PokktNativeAdDelegate>
{
    
}

@property (strong, nonatomic) NSString *screenId;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inReadConstraint;

@end
