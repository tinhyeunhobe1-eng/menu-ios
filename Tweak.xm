#import <UIKit/UIKit.h>
#import "MenuView.h"

%ctor {

    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            3 * NSEC_PER_SEC
        ),
        dispatch_get_main_queue(),
        ^{

            UIWindow *window =
                UIApplication.sharedApplication.keyWindow;

            if (!window)
                return;

            UIButton *button =
                [UIButton buttonWithType:UIButtonTypeSystem];

            button.frame =
                CGRectMake(20, 100, 58, 58);

            button.backgroundColor =
                [[UIColor blackColor]
                 colorWithAlphaComponent:0.85];

            button.layer.cornerRadius = 29;

            [button setTitle:@"☰"
                    forState:UIControlStateNormal];

            [button setTitleColor:
                UIColor.whiteColor
                       forState:UIControlStateNormal];

            button.titleLabel.font =
                [UIFont boldSystemFontOfSize:24];

            [button addTarget:[MenuView sharedMenu]
                       action:@selector(showMenu)
             forControlEvents:UIControlEventTouchUpInside];

            [window addSubview:button];
        }
    );
}
