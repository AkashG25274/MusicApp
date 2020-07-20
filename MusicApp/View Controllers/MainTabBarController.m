//
//  MainTabBarController.m
//  MusicApp
//
//  Created by mmt on 16/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "MainTabBarController.h"
#import "TrackViewController.h"
#import "AlbumsViewController.h"
#import "ArtistsViewController.h"
#import "PlaylistsViewController.h"
#import "../View Controllers/CustomUI/AudioPlayerView.h"
#import "../Constants.h"

@interface MainTabBarController ()

@property (strong, nonatomic) AudioPlayerView *playbackView;

@end

@implementation MainTabBarController

- (id)init
{
    self = [super init];
    
    if(self)
    {
        TrackViewController *trackViewController = [[TrackViewController alloc] init];
        UINavigationController *trackTabNavigationController = [[UINavigationController alloc] initWithRootViewController:trackViewController];
        trackTabNavigationController.tabBarItem.title = trackTabBarTitle;
        [trackTabNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
        
        AlbumsViewController *albumsViewController = [[AlbumsViewController alloc] init];
        UINavigationController *albumsTabNavigationController = [[UINavigationController alloc] initWithRootViewController:albumsViewController];
        albumsTabNavigationController.tabBarItem.title = albumTabBarTitle;
        [albumsTabNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
        
        ArtistsViewController *artistsViewController = [[ArtistsViewController alloc] init];
        UINavigationController *artistsTabNavigationController = [[UINavigationController alloc] initWithRootViewController:artistsViewController];
        artistsTabNavigationController.tabBarItem.title = artistTabBarTitle;
        [artistsTabNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
        
        PlaylistsViewController *playlistsViewController = [[PlaylistsViewController alloc] init];
        UINavigationController *playlistsTabNavigationController = [[UINavigationController alloc] initWithRootViewController:playlistsViewController];
        playlistsTabNavigationController.tabBarItem.title = playlistTabBarTitle;
        [playlistsTabNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
        
        self.viewControllers = @[trackTabNavigationController, artistsTabNavigationController, albumsTabNavigationController];
        
        self.playbackView = [[AudioPlayerView alloc] init];
        [self.playbackView setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.playbackView.backgroundColor = UIColor.whiteColor;
        [self.view addSubview:self.playbackView];
    }
    
    return self;
}

- (void)setUpConstraints
{
//    NSDictionary *viewsDictionary = @{@"superView":self.view, @"playbackview":self.playbackView};
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[playbackview(50)]|" options:0 metrics:nil views:viewsDictionary]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[playbackview(==superView)]|" options:0 metrics:nil views:viewsDictionary]];
    
    [[self.playbackView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:YES];
    [[self.playbackView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor] setActive:YES];
    [[self.playbackView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor] setActive:YES];
    [[self.playbackView.widthAnchor constraintEqualToConstant:50] setActive:YES];
    
    [self.playbackView setUpConstraints];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
