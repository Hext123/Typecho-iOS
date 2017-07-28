#import "R.h"


@implementation RStrings

@end


@interface RImages ()
@property (nonatomic, strong) UIImage* tabbarAdd;
@property (nonatomic, strong) UIImage* tabbarMy;
@property (nonatomic, strong) UIImage* tabbarSetting;
@end

@implementation RImages
- (UIImage*)tabbarAdd { return [UIImage imageNamed:@"tabbar_add"]; }
- (UIImage*)tabbarMy { return [UIImage imageNamed:@"tabbar_my"]; }
- (UIImage*)tabbarSetting { return [UIImage imageNamed:@"tabbar_setting"]; }
@end



@implementation RLaunchScreen
- (__kindof UIViewController*)instantiateInitialViewController { return [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateInitialViewController]; }
@end



@implementation RMain
- (__kindof UIViewController*)instantiateInitialViewController { return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController]; }
- (__kindof UIViewController*)tAddWebsiteTableViewController { return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TAddWebsiteTableViewController"]; }
- (__kindof UIViewController*)tMyTableViewController { return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TMyTableViewController"]; }
- (__kindof UIViewController*)tPagesTableViewController { return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TPagesTableViewController"]; }
- (__kindof UIViewController*)tPostsTableViewController { return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TPostsTableViewController"]; }
@end


@interface RStoryboards ()
@property (nonatomic, strong) RLaunchScreen* launchScreen;
@property (nonatomic, strong) RMain* main;
@end

@implementation RStoryboards

- (RLaunchScreen*)launchScreen
{
	if (!_launchScreen)
	{
		_launchScreen = [RLaunchScreen new];
	}
	return _launchScreen;
}

- (RMain*)main
{
	if (!_main)
	{
		_main = [RMain new];
	}
	return _main;
}

@end



@implementation RSegue
- (void)performWithSource:(__kindof UIViewController*)sourceViewController sender:(id)sender { [sourceViewController performSegueWithIdentifier:self.identifier sender:sender]; }
@end



@implementation RSegues

@end


@interface R ()
@property (nonatomic, strong) RStrings* string;
@property (nonatomic, strong) RImages* image;
@property (nonatomic, strong) RStoryboards* storyboard;
@property (nonatomic, strong) RSegues* segue;
@end

@implementation R

+ (instancetype)sharedInstance
{	 
	static dispatch_once_t pred;
 	static id sharedInstance_ = nil;
 
 	dispatch_once(&pred, ^{
 		sharedInstance_ = [[self alloc] init];
 	});
 
 	return sharedInstance_;

}

+ (RStrings*)string { return [[R sharedInstance] string]; }
+ (RImages*)image { return [[R sharedInstance] image]; }
+ (RStoryboards*)storyboard { return [[R sharedInstance] storyboard]; }
+ (RSegues*)segue { return [[R sharedInstance] segue]; }

- (RStrings*)string
{
	if (!_string)
	{
		_string = [RStrings new];
	}
	return _string;
}

- (RImages*)image
{
	if (!_image)
	{
		_image = [RImages new];
	}
	return _image;
}

- (RStoryboards*)storyboard
{
	if (!_storyboard)
	{
		_storyboard = [RStoryboards new];
	}
	return _storyboard;
}

- (RSegues*)segue
{
	if (!_segue)
	{
		_segue = [RSegues new];
	}
	return _segue;
}

@end


