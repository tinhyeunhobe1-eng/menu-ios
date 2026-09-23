#import <UIKit/UIKit.h>

@interface MenuView : UIView

+ (instancetype)sharedMenu;

- (void)showMenu;
- (void)hideMenu;

@end
