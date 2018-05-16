#import "R.h"


@implementation RStrings

@end


@interface RImages ()
@property (nonatomic, strong) UIImage* tabbarSetting;
@property (nonatomic, strong) UIImage* tabbarAdd;
@property (nonatomic, strong) UIImage* tabbarMy;
@property (nonatomic, strong) UIImage* iconHelp;
@property (nonatomic, strong) UIImage* iconKeyboard;
@property (nonatomic, strong) UIImage* ol;
@property (nonatomic, strong) UIImage* bold;
@property (nonatomic, strong) UIImage* code;
@property (nonatomic, strong) UIImage* title;
@property (nonatomic, strong) UIImage* link;
@property (nonatomic, strong) UIImage* img;
@property (nonatomic, strong) UIImage* help;
@property (nonatomic, strong) UIImage* quote;
@property (nonatomic, strong) UIImage* hr;
@property (nonatomic, strong) UIImage* italic;
@property (nonatomic, strong) UIImage* more;
@property (nonatomic, strong) UIImage* ul;
@end

@implementation RImages
- (UIImage*)tabbarSetting { return [UIImage imageNamed:@"tabbar_setting"]; }
- (UIImage*)tabbarAdd { return [UIImage imageNamed:@"tabbar_add"]; }
- (UIImage*)tabbarMy { return [UIImage imageNamed:@"tabbar_my"]; }
- (UIImage*)iconHelp { return [UIImage imageNamed:@"icon-help"]; }
- (UIImage*)iconKeyboard { return [UIImage imageNamed:@"icon-keyboard"]; }
- (UIImage*)ol { return [UIImage imageNamed:@"ol.png"]; }
- (UIImage*)bold { return [UIImage imageNamed:@"bold.png"]; }
- (UIImage*)code { return [UIImage imageNamed:@"code.png"]; }
- (UIImage*)title { return [UIImage imageNamed:@"title.png"]; }
- (UIImage*)link { return [UIImage imageNamed:@"link.png"]; }
- (UIImage*)img { return [UIImage imageNamed:@"img.png"]; }
- (UIImage*)help { return [UIImage imageNamed:@"help.png"]; }
- (UIImage*)quote { return [UIImage imageNamed:@"quote.png"]; }
- (UIImage*)hr { return [UIImage imageNamed:@"hr.png"]; }
- (UIImage*)italic { return [UIImage imageNamed:@"italic.png"]; }
- (UIImage*)more { return [UIImage imageNamed:@"more.png"]; }
- (UIImage*)ul { return [UIImage imageNamed:@"ul.png"]; }
@end



@implementation RMain
- (__kindof UIViewController*)instantiateInitialViewController { return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController]; }
- (__kindof UIViewController*)tAddWebsiteTableViewController { return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TAddWebsiteTableViewController"]; }
- (NSString*)tAddWebsiteTableViewControllerIdentifier { return @"TAddWebsiteTableViewController"; }
- (__kindof UIViewController*)tMyTableViewController { return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TMyTableViewController"]; }
- (NSString*)tMyTableViewControllerIdentifier { return @"TMyTableViewController"; }
- (__kindof UIViewController*)tPagesTableViewController { return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TPagesTableViewController"]; }
- (NSString*)tPagesTableViewControllerIdentifier { return @"TPagesTableViewController"; }
- (__kindof UIViewController*)tPostsTableViewController { return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TPostsTableViewController"]; }
- (NSString*)tPostsTableViewControllerIdentifier { return @"TPostsTableViewController"; }
@end



@implementation RLaunchScreen
- (__kindof UIViewController*)instantiateInitialViewController { return [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateInitialViewController]; }
@end


@interface RStoryboards ()
@property (nonatomic, strong) RMain* main;
@property (nonatomic, strong) RLaunchScreen* launchScreen;
@end

@implementation RStoryboards

- (RMain*)main
{
	if (!_main)
	{
		_main = [RMain new];
	}
	return _main;
}

- (RLaunchScreen*)launchScreen
{
	if (!_launchScreen)
	{
		_launchScreen = [RLaunchScreen new];
	}
	return _launchScreen;
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


