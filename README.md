# PokktSDK Integration Guide (iOS, v8.0.0)


[SDK Integration](#_heading=h.30j0zll)

[SDK Configuration](#_heading=h.1fob9te)

[Full-Screen Ads](#_heading=h.2et92p0)

[Banner Ads](#_heading=h.2s8eyo1)

[Native Ads](#_heading=h.17dp8vu)

[Additional SDK Configuration](#_heading=h.1ksv4uv)

[GDPR](#_heading=h.44sinio)

[Extra Parameter](#_heading=h.2jxsxqh)

[ThirdPartyUser Id](#_heading=h.3j2qqm3)

[Pokkt AdPlayer Configuration](#_heading=h.1y810tw)

## SDK Integration

- Download the latest SDK. [[LINK](https://wiki.pokkt.com/Native_SDK_Download)]
- Unzip the downloaded file and drag the PokktSDK.framework directory into Xcode under Framework.
- Add the required compiler flags to &#39;Other Linker Flags&#39; field in your project&#39;s Build Settings:
- **-ObjC**
- **-lxml2**


## SDK Configuration

1. Set **Application Id** and **Security key** in Pokkt SDK. You can get it from the Pokkt dashboard from your account. We generally assign unique application-id and security-key.

```
[PokktAds setPokktConfigWithAppId:appId securityKey:securityKey];
```


1. When your application is under development and if you want to see sdk logs and other informatory messages, you can enable it by setting **setDebug** to **true**. Make sure to disable debugging before release.

```
[PokktDebugger setDebug:YES/NO];
```

## Full-Screen Ads

1. Full-screen ads can be rewarded or non-rewarded and video or interstitial. You can either cache the ad in advance or directly call show for it.
2. We suggest you cache the ad in advance so as to give seamless play behaviour, In other case it will stream the video which may lead to unnecessary buffering delays depending on the network connection.
3. **Screen-Id:** ​This one parameter is accepted by almost all API&#39;s of Pokkt SDK. This controls the placement of ads and can be created on Pokkt Dashboard. We will be referencing the ​ **PokktAdsDemo** ​app provided with SDK during the course of explanation in this document. We suggest you go through the sample app for better understanding.
4. To cache Full-screen ad call:

```
[PokktAds cacheAd:screenId withDelegate:delegate];
```

To Show Video Ad:

```[PokktAds showAd:screenId viewController:viewController withDelegate:delegate];
```

You can check if an ad is available, before making a showrequest.

```
[PokktAds isAdCached:screenId];
```

1. Ad actions are optional, but we suggest to implement them as it will help you to keep track of the status of your ad request.

Ad Cache:
```
- (void)adCachingResult:(NSString *)screenIdisSuccess:(BOOL)successwithReward:(double)rewarderrorMessage:(NSString *)errorMessage;
```
Ad Display:
```
- (void)adDisplayResult:(NSString *)screenIdisSuccess:(BOOL)successerrorMessage:(NSString *)errorMessage;
```
Ad Closed:
```
 - (void)adClosed:(NSString *)screenId adCompleted:(BOOL)adCompleted;
```
Ad Interaction:
```
- (void)adClicked:(NSString *)screenId; - (void)adGratified:(NSString *)screenId withReward:(double)reward;
```

## Banner Ads

1. Load banner Ad call:
```
PokktBannerView *banner = [PokktBanner initWithBannerAdSize:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];[self.view addSubview:banner];
```
```
[PokktAds showAd:(NSString *)screenId withViewController:(UIViewController *)viewController bannerContainer:(PokktBannerView *)bannerView withDelegate: self];
```
2. Refresh banner:
You can set a banner refresh rate on the Pokkt dashboard. Refresh rate should be in range of 30 -100

3. Destroy banner
```
[PokktAds destroyBanner:(PokktBannerView *)bannerContainer];
```

4. Ad actions are optional, but we suggest to implement them as it will help you to keep track of the status of your ad request.

```
- (void)bannerExpanded:(NSString \*)screenId;
```
```
- (void)bannerResized:(NSString \*)screenId;
```
```
- (void)bannerCollapsed:(NSString \*)screenId;
```

## Native Ads

1. A native ad may be served in feed or in between the developer content inside the app. Normally, FullScreen ads are delivered on call to action by the user. Native ads eliminate this limitation and show ads without any user request.Native ads are also non intrusive as they will be automatically paused when the ad is out of the view by scrolling. The PokktNativeAdLayout will be part of developer application parent components which may be ListView, Layout in ScrollView or WebView.

Load Native Ad:

```
[PokktAds requestNativeAd:(NSString *)screenId withDelegate:self];
```
After calling
```
requestNativeAd:withDelegate:
```
Inside the
```
-(void)nativeAdReady:(NSString *)screenId withNativeAd:(PokktNativeAd *)pokktNativeAd;
```
method you will receive PokktNativeAd object and then extract your ad by calling below method.
```
UIView *adView = [pokktNativeAd getMediaView]; 
```

1. Ad actions are optional, but we suggest to implement them as it will help you to keep track of the status of your ad request.
```
- (void)nativeAdReady:(NSString *)screenId withNativeAd:(PokktNativeAd *)pokktNativeAd;
```
```
- (void)nativeAdFailed:(NSString *)screenId error:(NSString *)errorMessage;
```


## Additional SDK Configuration

### GDPR

As of May 25th, the General Data Protection Regulation (GDPR) will be enforced in the European Union.

Set _ **GDPR consent** _ in Pokkt SDK. **This must be called before calling any ad related API.**** Developers/Publishers must get the consent from user.** For more information on GDPR please refer [https://www.eugdpr.org/](https://www.eugdpr.org/) and [https://www.eugdpr.org/gdpr-faqs.html](https://www.eugdpr.org/gdpr-faqs.html). This API can again be used by publishers to revoke the consent. If this API is not called or invalid data provided then SDK will access the users personal data for ad targeting
```
PokktConsentInfo *consentInfo = [[PokktConsentInfo alloc] init];
```
```
 consentInfo.isGDPRApplicable = true;
```
```
 consentInfo.isGDPRConsentAvailable = false;
```
```
 [PokktAds setPokktConsentInfo:consentInfo];
```
```
[PokktAds getPokktConsentInfo];
```

### Extra Parameter

You can set extra parameters to POKKT SDK, to be passed back to your server via POKKT server callback. These Extra parameters will be in key-value pair.The key must be alphanumeric value. See the below example

```
NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
```
```
[dict setValue:value1 forKey:key1];
```
```
[dict setValue:value2 forKey:key2];
```
```
[dict setValue:value3 forKey:key3];
```
```
[PokktAds setCallbackExtraParam:dict];
```

###

### ThirdPartyUser Id

If you are using server to server integration with Pokkt, you can also set **Third Party UserId** in PokktAds.

```
PokktAds.setThirdPartyUserId:(NSString *) userId;
```
- User Detail

For better targeting of ads you can also provide user details to our SDK using
```
PokktUserInfo *pokktUserDetails = [PokktUserInfo alloc] init];
```
```
pokktUserDetails.Name = "";
```
```
pokktUserDetails.Age = "";
```
```
pokktUserDetails.Sex = "";
```
```
pokktUserDetails.MobileNo = "";
```
```
pokktUserDetails.EmailAddress = "";
```
```
pokktUserDetails.Location = "";
```
```
pokktUserDetails.Birthday = "";
```
```
pokktUserDetails.MaritalStatus = "";
```
```
pokktUserDetails.FacebookId = "";
```
```
pokktUserDetails.TwitterHandle = "";
```
```
pokktUserDetails.Education = "";
```
```
pokktUserDetails.Nationality = "";
```
```
pokktUserDetails.Employment = "";
```
```
pokktUserDetails.MaturityRating = "";
```
```
[PokktAds setUserDetails: pokktUserDetails];
```

## Pokkt AdPlayer Configuration

Pokkt Ad player works the way the App is configured at Pokkt dashboard, but we provide a way to override those settings using **PokktAdPlayerViewConfig**.

Application should prefer configuration provided through code by the developer or what&#39;s configured for the app in the dashboard, can be controlled any time through the dashboard itself. If you want to make changes to this configuration after your app distribution, you can contact **Pokkt Team** to do the same for your app through the admin console.
```
PokktAdPlayerViewConfig *adPlayerViewConfig = [[PokktAdPlayerViewConfig alloc] init];
```
```
[PokktAds setPokktAdPlayerViewConfig:adPlayerViewConfig];
```
