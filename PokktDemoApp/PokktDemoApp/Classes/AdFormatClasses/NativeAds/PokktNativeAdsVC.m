#import "PokktNativeAdsVC.h"
#import "PokktSpinnerUtils.h"
#import "PokktNativeScrollVC.h"

@interface PokktNativeAdsVC ()

@end

@implementation PokktNativeAdsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    screenIdTextField.text=@"ca2c7931cb6549bc6f32101231515ed2";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"scrollview"]) {
        PokktNativeScrollVC *vc = [segue destinationViewController];
        vc.screenId = screenIdTextField.text;
    }
}

@end
