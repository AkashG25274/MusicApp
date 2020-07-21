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
#import "../Constants.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (id)init
{
    self = [super init];
    
    if(self)
    {
        TrackViewController *trackViewController = [[TrackViewController alloc] init];
        trackViewController.trackURL = baseUrl;
        UINavigationController *trackTabNavigationController = [[UINavigationController alloc] initWithRootViewController:trackViewController];
        trackTabNavigationController.tabBarItem.title = trackTabBarTitle;
        [self setTabBarTitleFont:trackTabNavigationController];
        
        AlbumsViewController *albumsViewController = [[AlbumsViewController alloc] init];
        UINavigationController *albumsTabNavigationController = [[UINavigationController alloc] initWithRootViewController:albumsViewController];
        albumsTabNavigationController.tabBarItem.title = albumTabBarTitle;
        [self setTabBarTitleFont:albumsTabNavigationController];

        ArtistsViewController *artistsViewController = [[ArtistsViewController alloc] init];
        UINavigationController *artistsTabNavigationController = [[UINavigationController alloc] initWithRootViewController:artistsViewController];
        artistsTabNavigationController.tabBarItem.title = artistTabBarTitle;
        [self setTabBarTitleFont:artistsTabNavigationController];

        PlaylistsViewController *playlistsViewController = [[PlaylistsViewController alloc] init];
        UINavigationController *playlistsTabNavigationController = [[UINavigationController alloc] initWithRootViewController:playlistsViewController];
        playlistsTabNavigationController.tabBarItem.title = playlistTabBarTitle;
        [self setTabBarTitleFont:playlistsTabNavigationController];
        
        self.viewControllers = @[trackTabNavigationController, artistsTabNavigationController, albumsTabNavigationController, playlistsTabNavigationController];
    }
    
    return self;
}

- (void)setTabBarTitleFont:(UINavigationController *)viewController
{
    [viewController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
}

@end
