#import <UIKit/UIKit.h>

@interface RStrings: NSObject
@end


@interface RImages: NSObject
- (UIImage*)tabbarSetting;
- (UIImage*)tabbarAdd;
- (UIImage*)tabbarMy;
- (UIImage*)iconHelp;
- (UIImage*)iconKeyboard;
- (UIImage*)ol;
- (UIImage*)bold;
- (UIImage*)code;
- (UIImage*)title;
- (UIImage*)link;
- (UIImage*)img;
- (UIImage*)help;
- (UIImage*)quote;
- (UIImage*)hr;
- (UIImage*)italic;
- (UIImage*)more;
- (UIImage*)ul;
@end


@interface RMain: NSObject
- (__kindof UIViewController*)instantiateInitialViewController;
- (__kindof UIViewController*)tAddWebsiteTableViewController;
- (NSString*)tAddWebsiteTableViewControllerIdentifier;
- (__kindof UIViewController*)tMyTableViewController;
- (NSString*)tMyTableViewControllerIdentifier;
- (__kindof UIViewController*)tPagesTableViewController;
- (NSString*)tPagesTableViewControllerIdentifier;
- (__kindof UIViewController*)tPostsTableViewController;
- (NSString*)tPostsTableViewControllerIdentifier;
@end


@interface RLaunchScreen: NSObject
- (__kindof UIViewController*)instantiateInitialViewController;
@end


@interface RStoryboards: NSObject
- (RMain*)main;
- (RLaunchScreen*)launchScreen;
@end


@interface RSegue: NSObject
@property (nonatomic, strong) NSString* identifier;
- (void)performWithSource:(__kindof UIViewController*)sourceViewController sender:(id)sender;
@end


@interface RSegues: NSObject
@end


@interface R: NSObject
+ (RStrings*)string;
+ (RImages*)image;
+ (RStoryboards*)storyboard;
+ (RSegues*)segue;
@end


