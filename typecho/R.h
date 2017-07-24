#import <UIKit/UIKit.h>

@interface RStrings: NSObject
@end


@interface RImages: NSObject
- (UIImage*)tabbarAdd;
- (UIImage*)tabbarMy;
- (UIImage*)tabbarSetting;
@end


@interface RLaunchScreen: NSObject
- (__kindof UIViewController*)instantiateInitialViewController;
@end


@interface RMain: NSObject
- (__kindof UIViewController*)instantiateInitialViewController;
- (__kindof UIViewController*)tAddWebsiteTableViewController;
- (__kindof UIViewController*)tPostsTableViewController;
@end


@interface RStoryboards: NSObject
- (RLaunchScreen*)launchScreen;
- (RMain*)main;
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


