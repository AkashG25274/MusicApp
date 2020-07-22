//
//  ArtistDetailViewController.m
//  MusicApp
//
//  Created by mmt on 18/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "ArtistDetailViewController.h"
#import "WebRequestHandler.h"
#import "ArtistDetailsTabBarController.h"
#import "Constants.h"
#import "AlbumHeaderView.h"

@interface ArtistDetailViewController ()

@property (strong, nonatomic) AlbumHeaderView *headerView;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) ArtistDetailsTabBarController *controller;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *mainContainerView;

@end

@implementation ArtistDetailViewController

- (id)init
{
    self = [super init];
    
    if(self)
    {
        self.artist = [[Artist alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] init];
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.scrollView];
    
    self.mainContainerView = [[UIView alloc] init];
    [self.mainContainerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scrollView addSubview:self.mainContainerView];
    
    self.headerView = [[AlbumHeaderView alloc] init];
    [self.headerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.headerView.backgroundColor = UIColor.whiteColor;
    self.headerView.imageView.image = [UIImage imageNamed:artistDefaultImage];
    [self.mainContainerView addSubview:self.headerView];
 
    self.containerView = [[UIView alloc] init];
    [self.containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.containerView.backgroundColor = UIColor.whiteColor;
    [self.mainContainerView addSubview:self.containerView];

    self.controller = [[ArtistDetailsTabBarController alloc] initWith:self.artist.trackListUrl];
    [self addChildViewController:self.controller];
    [self.controller.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.containerView addSubview:self.controller.view];
    [self.controller didMoveToParentViewController:self];
    
    [self setUpConstraints];
    [self.headerView setUpConstraints];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[controllerView(==superView)]|" options:0 metrics:nil views:@{@"controllerView":self.controller.view, @"superView":self.containerView}]];

    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[controllerView(==superView)]|" options:0 metrics:nil views:@{@"controllerView":self.controller.view, @"superView":self.containerView}]];

    [self setUpViewsForHeaderView];
    
    self.navigationItem.title = self.artist.name;
}

- (void)setUpConstraints
{
    NSDictionary *viewsDictionary = @{superView:self.view, scrollView:self.scrollView, mainContainerView:self.mainContainerView, headerView:self.headerView, containerView:self.containerView};
    
    [[self.containerView.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor] setActive:YES];
    [[self.containerView.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor] setActive:YES];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mainContainerView(==scrollView)]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mainContainerView]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.mainContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[headerView(270)][containerView(500)]-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.mainContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[headerView(==mainContainerView)]" options:0 metrics:nil views:viewsDictionary]];

    [self.mainContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[containerView]" options:0 metrics:nil views:viewsDictionary]];
}

- (void)setUpViewsForHeaderView
{
    WebRequestHandler *requestHandler = [WebRequestHandler sharedHandler];
    [requestHandler downloadImageFrom:self.artist.pictureUrl completionBlock:^(UIImage * _Nonnull artistImage) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.headerView.imageView.image = artistImage;
        });
    }];
    
    self.headerView.textLabel.text = self.artist.name;
    self.headerView.artistNameLabel.hidden = YES;
    self.headerView.seeArtistButton.hidden = YES;
}

@end
