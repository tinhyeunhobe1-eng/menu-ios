#import "MenuView.h"

@interface MenuView ()

@property(nonatomic,strong) UIView *panel;
@property(nonatomic,strong) UIView *contentView;
@property(nonatomic,strong) UIButton *closeButton;
@property(nonatomic,strong) NSMutableArray<UIButton *> *tabButtons;

@end

@implementation MenuView

+ (instancetype)sharedMenu {
    static MenuView *menu;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        menu = [[self alloc] initWithFrame:CGRectZero];
    });

    return menu;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        self.tabButtons = [NSMutableArray array];
        self.backgroundColor = [UIColor clearColor];

        [self buildUI];
    }

    return self;
}

#pragma mark - UI

- (void)buildUI {

    // Nền mờ
    UIView *dim = [[UIView alloc] init];
    dim.backgroundColor =
        [[UIColor blackColor] colorWithAlphaComponent:0.25];

    dim.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:dim];

    [NSLayoutConstraint activateConstraints:@[
        [dim.topAnchor constraintEqualToAnchor:self.topAnchor],
        [dim.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [dim.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [dim.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]
    ]];

    // Panel
    self.panel = [[UIView alloc] init];
    self.panel.backgroundColor =
        [[UIColor blackColor] colorWithAlphaComponent:0.91];

    self.panel.layer.cornerRadius = 18.0;
    self.panel.layer.borderWidth = 1.0;
    self.panel.layer.borderColor =
        [[UIColor whiteColor]
         colorWithAlphaComponent:0.14].CGColor;

    self.panel.translatesAutoresizingMaskIntoConstraints = NO;

    [self addSubview:self.panel];

    [NSLayoutConstraint activateConstraints:@[
        [self.panel.centerXAnchor
         constraintEqualToAnchor:self.centerXAnchor],

        [self.panel.centerYAnchor
         constraintEqualToAnchor:self.centerYAnchor],

        [self.panel.widthAnchor
         constraintLessThanOrEqualToAnchor:self.widthAnchor
         constant:-24],

        [self.panel.heightAnchor
         constraintLessThanOrEqualToAnchor:self.heightAnchor
         constant:-24],

        [self.panel.widthAnchor constraintEqualToConstant:760],
        [self.panel.heightAnchor constraintEqualToConstant:500]
    ]];

    // Tiêu đề
    UILabel *title =
        [[UILabel alloc] init];

    title.text = @"LIÊN QUÂN MOBILE VN II";
    title.textColor = UIColor.whiteColor;
    title.font =
        [UIFont boldSystemFontOfSize:18];

    title.textAlignment = NSTextAlignmentCenter;
    title.translatesAutoresizingMaskIntoConstraints = NO;

    [self.panel addSubview:title];

    // Close
    self.closeButton =
        [UIButton buttonWithType:UIButtonTypeSystem];

    [self.closeButton setTitle:@"×"
                      forState:UIControlStateNormal];

    [self.closeButton setTitleColor:
        UIColor.whiteColor
                           forState:UIControlStateNormal];

    self.closeButton.titleLabel.font =
        [UIFont systemFontOfSize:30 weight:UIFontWeightMedium];

    [self.closeButton addTarget:self
                         action:@selector(closePressed)
               forControlEvents:UIControlEventTouchUpInside];

    self.closeButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self.panel addSubview:self.closeButton];

    [NSLayoutConstraint activateConstraints:@[
        [title.topAnchor
         constraintEqualToAnchor:self.panel.topAnchor
         constant:15],

        [title.centerXAnchor
         constraintEqualToAnchor:self.panel.centerXAnchor],

        [self.closeButton.centerYAnchor
         constraintEqualToAnchor:title.centerYAnchor],

        [self.closeButton.trailingAnchor
         constraintEqualToAnchor:self.panel.trailingAnchor
         constant:-12],

        [self.closeButton.widthAnchor
         constraintEqualToConstant:40],

        [self.closeButton.heightAnchor
         constraintEqualToConstant:40]
    ]];

    // Đường phân cách
    UIView *line = [[UIView alloc] init];

    line.backgroundColor =
        [[UIColor whiteColor]
         colorWithAlphaComponent:0.10];

    line.translatesAutoresizingMaskIntoConstraints = NO;

    [self.panel addSubview:line];

    [NSLayoutConstraint activateConstraints:@[
        [line.topAnchor
         constraintEqualToAnchor:self.panel.topAnchor
         constant:55],

        [line.leadingAnchor
         constraintEqualToAnchor:self.panel.leadingAnchor],

        [line.trailingAnchor
         constraintEqualToAnchor:self.panel.trailingAnchor],

        [line.heightAnchor constraintEqualToConstant:1]
    ]];

    // Menu trái
    [self buildTabs];

    // Nội dung phải
    [self buildOptions];
}

#pragma mark - Tabs

- (void)buildTabs {

    NSArray *tabs = @[
        @"FUNCTION",
        @"AIMSKILL",
        @"MOD PLAYER",
        @"AUTO PLAYER",
        @"EQUIP PLAYER",
        @"INFO DEBUG"
    ];

    CGFloat startY = 78.0;

    for (NSInteger i = 0; i < tabs.count; i++) {

        UIButton *button =
            [UIButton buttonWithType:UIButtonTypeSystem];

        [button setTitle:tabs[i]
                forState:UIControlStateNormal];

        [button setTitleColor:
            UIColor.whiteColor
                   forState:UIControlStateNormal];

        button.titleLabel.font =
            [UIFont boldSystemFontOfSize:13];

        button.layer.cornerRadius = 9;

        button.backgroundColor =
            i == 0
            ? [[UIColor whiteColor]
               colorWithAlphaComponent:0.16]
            : [[UIColor whiteColor]
               colorWithAlphaComponent:0.06];

        button.frame =
            CGRectMake(18,
                       startY + (i * 58),
                       205,
                       46);

        button.tag = i;

        [button addTarget:self
                   action:@selector(tabPressed:)
         forControlEvents:UIControlEventTouchUpInside];

        [self.panel addSubview:button];

        [self.tabButtons addObject:button];
    }
}

- (void)tabPressed:(UIButton *)sender {

    for (UIButton *button in self.tabButtons) {

        button.backgroundColor =
            [[UIColor whiteColor]
             colorWithAlphaComponent:0.06];
    }

    sender.backgroundColor =
        [[UIColor whiteColor]
         colorWithAlphaComponent:0.16];
}

#pragma mark - Options

- (void)buildOptions {

    NSArray *options = @[
        @"Map Hack",
        @"Hiện Rank",
        @"Hiện LSĐ",
        @"Show Unli",
        @"Spam Chat",
        @"Auto Win"
    ];

    CGFloat startX = 250;
    CGFloat startY = 82;

    for (NSInteger i = 0; i < options.count; i++) {

        CGFloat x =
            startX + ((i % 2) * 240);

        CGFloat y =
            startY + ((i / 2) * 58);

        [self createToggle:options[i]
                         x:x
                         y:y];
    }

    // Dropdown demo
    UILabel *dropTitle =
        [[UILabel alloc]
         initWithFrame:CGRectMake(250, 270, 150, 35)];

    dropTitle.text = @"Tên Gốc Tất Cả";
    dropTitle.textColor = UIColor.whiteColor;
    dropTitle.font =
        [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];

    [self.panel addSubview:dropTitle];

    UIButton *dropdown =
        [UIButton buttonWithType:UIButtonTypeSystem];

    dropdown.frame =
        CGRectMake(400, 265, 250, 45);

    [dropdown setTitle:@"Tên Gốc Tất Cả   ▾"
              forState:UIControlStateNormal];

    [dropdown setTitleColor:
        UIColor.whiteColor
                   forState:UIControlStateNormal];

    dropdown.backgroundColor =
        [[UIColor whiteColor]
         colorWithAlphaComponent:0.08];

    dropdown.layer.cornerRadius = 9;

    [dropdown addTarget:self
                 action:@selector(dropdownPressed:)
       forControlEvents:UIControlEventTouchUpInside];

    [self.panel addSubview:dropdown];

    // Camera
    UILabel *camera =
        [[UILabel alloc]
         initWithFrame:CGRectMake(250, 335, 250, 35)];

    camera.text = @"CAMERA THẲNG  0.0";
    camera.textColor = UIColor.whiteColor;
    camera.font =
        [UIFont boldSystemFontOfSize:14];

    [self.panel addSubview:camera];

    UISlider *slider =
        [[UISlider alloc]
         initWithFrame:CGRectMake(250, 375, 250, 30)];

    slider.minimumValue = 0;
    slider.maximumValue = 10;
    slider.value = 0;

    [self.panel addSubview:slider];

    UIButton *cameraButton =
        [UIButton buttonWithType:UIButtonTypeSystem];

    cameraButton.frame =
        CGRectMake(520, 365, 130, 45);

    [cameraButton setTitle:@"KHÓA CAM"
                   forState:UIControlStateNormal];

    [cameraButton setTitleColor:
        UIColor.whiteColor
                        forState:UIControlStateNormal];

    cameraButton.backgroundColor =
        [[UIColor whiteColor]
         colorWithAlphaComponent:0.10];

    cameraButton.layer.cornerRadius = 9;

    [self.panel addSubview:cameraButton];
}

- (void)createToggle:(NSString *)name
                   x:(CGFloat)x
                   y:(CGFloat)y {

    UILabel *label =
        [[UILabel alloc]
         initWithFrame:CGRectMake(x, y, 145, 40)];

    label.text = name;
    label.textColor = UIColor.whiteColor;
    label.font =
        [UIFont systemFontOfSize:14
                          weight:UIFontWeightMedium];

    [self.panel addSubview:label];

    UISwitch *toggle =
        [[UISwitch alloc]
         initWithFrame:CGRectMake(x + 145,
                                  y + 2,
                                  50,
                                  32)];

    toggle.on = NO;

    [self.panel addSubview:toggle];
}

#pragma mark - Demo actions

- (void)dropdownPressed:(UIButton *)button {

    UIAlertController *alert =
        [UIAlertController
         alertControllerWithTitle:@"Tên Gốc"
         message:@"Đây là dropdown demo."
         preferredStyle:UIAlertControllerStyleActionSheet];

    [alert addAction:
        [UIAlertAction
         actionWithTitle:@"Tất cả"
         style:UIAlertActionStyleDefault
         handler:nil]];

    [alert addAction:
        [UIAlertAction
         actionWithTitle:@"Hủy"
         style:UIAlertActionStyleCancel
         handler:nil]];

    UIViewController *vc =
        [self topViewController];

    [vc presentViewController:alert
                     animated:YES
                   completion:nil];
}

- (UIViewController *)topViewController {

    UIWindow *window =
        UIApplication.sharedApplication.keyWindow;

    UIViewController *vc =
        window.rootViewController;

    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }

    return vc;
}

#pragma mark - Show / Hide

- (void)showMenu {

    UIWindow *window =
        UIApplication.sharedApplication.keyWindow;

    if (!window)
        return;

    if (self.superview)
        return;

    self.frame = window.bounds;

    self.alpha = 0;

    [window addSubview:self];

    [UIView animateWithDuration:0.2
                     animations:^{
        self.alpha = 1;
    }];
}

- (void)hideMenu {

    [UIView animateWithDuration:0.2
                     animations:^{
        self.alpha = 0;
    }
                     completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)closePressed {

    [self hideMenu];
}

@end
