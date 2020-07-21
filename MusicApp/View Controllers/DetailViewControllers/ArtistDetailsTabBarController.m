//
//  ArtistDetailsTabBarController.m
//  MusicApp
//
//  Created by mmt on 19/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "ArtistDetailsTabBarController.h"
#import "TrackViewController.h"
#import "AlbumsViewController.h"
#import "Constants.h"

@interface ArtistDetailsTabBarController ()

@end

@implementation ArtistDetailsTabBarController

- (id)initWith:(NSString *)trackUrl
{
    self = [super init];
    
    if(self)
    {
        self.trackURL = trackUrl;
    
        TrackViewController *trackViewController = [[TrackViewController alloc] init];
        trackViewController.trackURL = self.trackURL;
        UINavigationController *trackTabNavigationController = [[UINavigationController alloc] initWithRootViewController:trackViewController];
        trackTabNavigationController.tabBarItem.title = trackTabBarTitle;
        [trackTabNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
    
        self.viewControllers = @[trackTabNavigationController];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 }

@end
