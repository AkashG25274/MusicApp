//
//  AppDelegate.m
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "AppDelegate.h"
#import "View Controllers/TrackTabViewController.h"
#import "View Controllers/AlbumsTabViewController.h"
#import "View Controllers/ArtistsTabViewController.h"
#import "View Controllers/PlaylistsTabViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    TrackTabViewController *trackTabViewController = [[TrackTabViewController alloc] init];
    UINavigationController *trackTabNavigationController = [[UINavigationController alloc] initWithRootViewController:trackTabViewController];
    trackTabNavigationController.tabBarItem.title = @"Tracks";
    [trackTabNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
    
    AlbumsTabViewController *albumsTabViewController = [[AlbumsTabViewController alloc] init];
    UINavigationController *albumsTabNavigationController = [[UINavigationController alloc] initWithRootViewController:albumsTabViewController];
    albumsTabNavigationController.tabBarItem.title = @"Albums";
    [albumsTabNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
    
    ArtistsTabViewController *artistsTabViewController = [[ArtistsTabViewController alloc] init];
    UINavigationController *artistsTabNavigationController = [[UINavigationController alloc] initWithRootViewController:artistsTabViewController];
    artistsTabNavigationController.tabBarItem.title = @"Artists";
    [artistsTabNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
    
    PlaylistsTabViewController *playlistsTabViewController = [[PlaylistsTabViewController alloc] init];
    UINavigationController *playlistsTabNavigationController = [[UINavigationController alloc] initWithRootViewController:playlistsTabViewController];
    playlistsTabNavigationController.tabBarItem.title = @"Playlists";
    [playlistsTabNavigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
    
    UITabBarController *mainTabBarController = [[UITabBarController alloc] init];
    mainTabBarController.viewControllers = @[trackTabNavigationController, albumsTabNavigationController, artistsTabNavigationController, playlistsTabNavigationController];
    
    [self.window setRootViewController:mainTabBarController];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
