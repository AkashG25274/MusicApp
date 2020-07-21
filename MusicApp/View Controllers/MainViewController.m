//
//  MainViewController.m
//  MusicApp
//
//  Created by mmt on 20/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "MainViewController.h"
#import "AudioPlayerView.h"
#import "MainTabBarController.h"

@interface MainViewController ()

@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) AudioPlayerView *playbackView;

@end

@implementation MainViewController

- (instancetype)init
{
    self = [super init];
    
    if(self)
    {
        self.view.backgroundColor = UIColor.whiteColor;
        
        self.containerView = [[UIView alloc] init];
        [self.containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.containerView.backgroundColor = UIColor.whiteColor;
        [self.view addSubview:self.containerView];
        
        self.playbackView = [[AudioPlayerView alloc] init];
        [self.playbackView setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.playbackView.backgroundColor = UIColor.whiteColor;
        self.playbackView.layer.cornerRadius = 1.0f;
        self.playbackView.layer.borderWidth = 1.0f;
        self.playbackView.layer.borderColor = UIColor.blueColor.CGColor;
        [self.view addSubview:self.playbackView];
        
        UITabBarController *controller = [[MainTabBarController alloc] init];
        [self addChildViewController:controller];
        [controller.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.containerView addSubview:controller.view];
        [controller didMoveToParentViewController:self];
        
        
        [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[controllerView(==superView)]" options:0 metrics:nil views:@{@"controllerView":controller.view, @"superView":self.containerView}]];
        
        [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[controllerView(==superView)]" options:0 metrics:nil views:@{@"controllerView":controller.view, @"superView":self.containerView}]];
    }
    
    return self;
}

- (void)setUpConstraints
{
    NSDictionary *viewsDictionary = @{@"superview":self.view, @"containerView":self.containerView, @"playbackView":self.playbackView};
    
    [[self.playbackView.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor] setActive:YES];
    [[self.playbackView.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor] setActive:YES];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView]-5-[playbackView(100)]-10-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerView(==superview)]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[playbackView]" options:0 metrics:nil views:viewsDictionary]];
    
    [self.playbackView setUpConstraints];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
