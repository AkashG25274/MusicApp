//
//  AlbumsTabViewController.m
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "AlbumsViewController.h"
#import "./CustomUI/AlbumCustomCollectionViewCell.h"
#import "../Model Classes/Album.h"
#import "../Network Controllers/WebRequestHandler.h"
#import "./DetailViewControllers/AlbumDetailViewController.h"
#import "../Constants.h"

@interface AlbumsViewController ()

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *albums;
@property (assign) UIEdgeInsets sectionInsets;

@end

@implementation AlbumsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    [self.collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.collectionView registerClass:[AlbumCustomCollectionViewCell class] forCellWithReuseIdentifier:albumCellIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self setUpConstraints];
    
    self.albums = [[NSArray alloc] init];
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
    [requestHandler getAlbums:^(NSArray * _Nonnull albumList) {
        
        self.albums = albumList;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.albums.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumCustomCollectionViewCell *albumCell = (AlbumCustomCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:albumCellIdentifier forIndexPath:indexPath];
    
    albumCell.layer.cornerRadius = 1.0f;
    albumCell.layer.borderWidth = 1.0f;
    albumCell.layer.borderColor = UIColor.blackColor.CGColor;
    
    Album *currentAlbum = self.albums[indexPath.row];
    albumCell.albumImageView.image = [UIImage imageNamed:albumDefaultImage];
    albumCell.albumTitleLabel.text = currentAlbum.title;
    
    WebRequestHandler *requestHandler = [WebRequestHandler sharedHandler];
    [requestHandler downloadImageFrom:currentAlbum.coverImageUrl completionBlock:^(UIImage * _Nonnull albumImage) {

        dispatch_async(dispatch_get_main_queue(), ^{
            albumCell.albumImageView.image = albumImage;
        });
    }];
    
    return albumCell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumDetailViewController *albumDetailViewController = [[AlbumDetailViewController alloc] init];
    albumDetailViewController.album = self.albums[indexPath.row];
    [self.navigationController pushViewController:albumDetailViewController animated:YES];
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
