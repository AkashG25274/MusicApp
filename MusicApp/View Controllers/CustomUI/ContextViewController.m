//
//  ContextViewController.m
//  MusicApp
//
//  Created by mmt on 19/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "ContextViewController.h"
#import "Constants.h"
#import "ArtistDetailViewController.h"
#import "AlbumDetailViewController.h"

@interface ContextViewController ()

@end

@implementation ContextViewController

- (id)init
{
    self = [super init];
    
    if(self)
    {
        self.artist = [[Artist alloc] init];
        self.album = [[Album alloc] init];
        
        UIAlertAction *displayArtistAction = [UIAlertAction actionWithTitle:alertArtistAction style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            ArtistDetailViewController *artistDetailViewController = [[ArtistDetailViewController alloc] init];
            artistDetailViewController.artist = self.artist;
            [self presentViewController:artistDetailViewController animated:YES completion:nil];
        }];
        
        UIAlertAction *displayAlbumAction = [UIAlertAction actionWithTitle:alertAlbumAction style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            AlbumDetailViewController *albumDetailViewController = [[AlbumDetailViewController alloc] init];
            albumDetailViewController.album = self.album;
            [self.navigationController pushViewController:albumDetailViewController animated:YES];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:alertCancelAction style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self addAction:displayArtistAction];
        [self addAction:displayAlbumAction];
        [self addAction:cancelAction];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
