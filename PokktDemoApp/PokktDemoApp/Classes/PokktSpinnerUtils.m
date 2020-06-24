#import "PokktSpinnerUtils.h"

@implementation PokktSpinnerUtils

+(void)addSpinnerOnButton:(UIButton *)button
{
    UIControl *layer  = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height)];
    [layer setTag:button.tag+2000];
    [layer setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
    [button addSubview:layer];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.alpha = 1.0;
    activityIndicator.tag = button.tag + 1000;
    [button addSubview:activityIndicator];
    activityIndicator.center = CGPointMake(button.frame.size.width/2, button.frame.size.height/2);
    [activityIndicator startAnimating];
}

+(void)stopSpinner:(UIButton *)button
{
    UIActivityIndicatorView *spinner = [button viewWithTag:button.tag+1000];
    
    if (spinner != nil)
    {
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        spinner = nil;
    }
    
    UIControl *layer = (UIControl *)[button viewWithTag:button.tag+2000];
    
    if (layer != nil)
    {
        [layer removeFromSuperview];
        layer = nil;
    }
}

@end
