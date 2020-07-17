//
//  MainTabBarController.m
//  MusicApp
//
//  Created by mmt on 16/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "MainTabBarController.h"
#import "TrackTabViewController.h"
#import "AlbumsTabViewController.h"
#import "ArtistsTabViewController.h"
#import "PlaylistsTabViewController.h"
#import "../Constants.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (id)init
{
    self = [super init];
    
    if(self)
    {
        TrackTabViewController *trackViewController = [[TrackTabViewController alloc] init];
        UINavigationController *trackTabNavigationController = [[UINavigationController alloc] initWithRootViewController:trackViewController];
        trackTabNavigationController.tabBarItem.title = trackTabBarTitle;
        [trackTabNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
        
        AlbumsTabViewController *albumsViewController = [[AlbumsTabViewController alloc] init];
        UINavigationController *albumsTabNavigationController = [[UINavigationController alloc] initWithRootViewController:albumsViewController];
        albumsTabNavigationController.tabBarItem.title = albumTabBarTitle;
        [albumsTabNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
        
        ArtistsTabViewController *artistsViewController = [[ArtistsTabViewController alloc] init];
        UINavigationController *artistsTabNavigationController = [[UINavigationController alloc] initWithRootViewController:artistsViewController];
        artistsTabNavigationController.tabBarItem.title = artistTabBarTitle;
        [artistsTabNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
        
        PlaylistsTabViewController *playlistsViewController = [[PlaylistsTabViewController alloc] init];
        UINavigationController *playlistsTabNavigationController = [[UINavigationController alloc] initWithRootViewController:playlistsViewController];
        playlistsTabNavigationController.tabBarItem.title = playlistTabBarTitle;
        [playlistsTabNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
        
        self.viewControllers = @[playlistsTabNavigationController, albumsTabNavigationController, trackTabNavigationController, artistsTabNavigationController];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
