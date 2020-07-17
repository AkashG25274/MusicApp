//
//  PlaylistsTabViewController.m
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "PlaylistsTabViewController.h"
#import "./CustomUI/PlaylistCustomCollectionViewCell.h"
#import "../Model Classes/Playlist.h"
#import "../Network Controllers/WebRequestHandler.h"
#import "../Constants.h"

@interface PlaylistsTabViewController ()

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *playlists;
@property (assign) UIEdgeInsets sectionInsets;

@end

@implementation PlaylistsTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    [self.collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.collectionView registerClass:[PlaylistCustomCollectionViewCell class] forCellWithReuseIdentifier:albumCellIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    [self setUpConstraints];
    
    self.playlists = [[NSArray alloc] init];
    self.sectionInsets = UIEdgeInsetsMake(50.0, 20.0, 50.0, 20.0);
    
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    [self setUpDataSource];
}

- (void)setUpConstraints
{
    NSDictionary *viewsDictionary = @{superView:self.view, collectionView:self.collectionView};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView(==superView)]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView(==superView)]|" options:0 metrics:nil views:viewsDictionary]];
}

- (void)setUpDataSource
{
    WebRequestHandler *requestHandler = [WebRequestHandler sharedHandler];
    [requestHandler getPlaylists:^(NSArray * _Nonnull listOfPlaylist) {
        
        self.playlists = listOfPlaylist;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.playlists.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlaylistCustomCollectionViewCell *playlistCell = (PlaylistCustomCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:albumCellIdentifier forIndexPath:indexPath];
    
    playlistCell.layer.cornerRadius = 1.0f;
    playlistCell.layer.borderWidth = 1.0f;
    playlistCell.layer.borderColor = UIColor.blackColor.CGColor;
    
    Playlist *currentPlaylist = self.playlists[indexPath.row];
    playlistCell.playlistImageView.image = [UIImage imageNamed:albumDefaultImage];
    playlistCell.playlistTitleLabel.text = currentPlaylist.title;
    
    WebRequestHandler *requestHandler = [WebRequestHandler sharedHandler];
    [requestHandler downloadImageFrom:currentPlaylist.pictureUrl completionBlock:^(UIImage * _Nonnull playlistImage) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            playlistCell.playlistImageView.image = playlistImage;
        });
    }];
    
    return playlistCell;
}

#pragma mark <UICollectionViewFlowLayoutDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int itemsPerRow = 2;
    double paddingSpace = self.sectionInsets.left * (itemsPerRow + 1);
    double availableWidth = self.view.frame.size.width - paddingSpace;
    double widthPerItem = availableWidth / itemsPerRow;
    return CGSizeMake(widthPerItem, widthPerItem);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.sectionInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.sectionInsets.left;
}

@end
