//
//  ArtistDetailsTabBarController.m
//  MusicApp
//
//  Created by mmt on 19/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "ArtistDetailsTabBarController.h"
#import "../../View Controllers/TrackViewController.h"
#import "../../View Controllers/AlbumsViewController.h"
#import "../../Constants.h"

@interface ArtistDetailsTabBarController ()

@end

@implementation ArtistDetailsTabBarController

- (id)init
{
    self = [super init];

    if(self)
    {
        TrackViewController *trackViewController = [[TrackViewController alloc] init];
        trackViewController.trackURL = self.trackURL;
        UINavigationController *trackTabNavigationController = [[UINavigationController alloc] initWithRootViewController:trackViewController];
        trackTabNavigationController.tabBarItem.title = trackTabBarTitle;
        [trackTabNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
        
        AlbumsViewController *albumsViewController = [[AlbumsViewController alloc] init];
        UINavigationController *albumsTabNavigationController = [[UINavigationController alloc] initWithRootViewController:albumsViewController];
        albumsTabNavigationController.tabBarItem.title = albumTabBarTitle;
        [albumsTabNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
        
        self.viewControllers = @[trackTabNavigationController, albumsTabNavigationController];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 }

@end
