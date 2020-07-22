//
//  PlaylistDetailViewController.m
//  MusicApp
//
//  Created by mmt on 17/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "PlaylistDetailViewController.h"
#import "WebRequestHandler.h"
#import "Track.h"
#import "TrackCustomTableCell.h"
#import "Constants.h"
#import "ArtistDetailViewController.h"
#import "AlbumDetailViewController.h"
#import "AlbumHeaderView.h"

@interface PlaylistDetailViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *trackList;
@property (strong, nonatomic) AlbumHeaderView *headerView;

@end

@implementation PlaylistDetailViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.playlist = [[Playlist alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.headerView = [[AlbumHeaderView alloc] init];
    [self.headerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.headerView.backgroundColor = UIColor.whiteColor;
    
    self.tableView = [[UITableView alloc] init];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[TrackCustomTableCell class] forCellReuseIdentifier:trackCellIdentifier];
    [self.view addSubview:self.tableView];
    
    [self setUpTableViewConstraints];
    [self setUpHeaderViewConstraints];
    [self.headerView setUpConstraints];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.trackList = [[NSArray alloc] init];
    
    [self setUpViewsForHeaderView];
    [self setUpDataSource];
    
    self.navigationItem.title = self.playlist.title;
}

- (void)setUpHeaderViewConstraints
{
    [[self.headerView.centerXAnchor constraintEqualToAnchor:self.tableView.centerXAnchor] setActive:YES];
    [[self.headerView.widthAnchor constraintEqualToAnchor:self.tableView.widthAnchor] setActive:YES];
    [[self.headerView.topAnchor constraintEqualToAnchor:self.tableView.topAnchor] setActive:YES];

    [self.tableView.tableHeaderView layoutIfNeeded];
    self.tableView.tableHeaderView = self.tableView.tableHeaderView;
}

- (void)setUpViewsForHeaderView
{
    self.headerView.imageView.image = [UIImage imageNamed:albumDefaultImage];
    
    WebRequestHandler *requestHandler = [WebRequestHandler sharedHandler];
    [requestHandler downloadImageFrom:self.playlist.pictureUrl completionBlock:^(UIImage * _Nonnull playlistImage) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.headerView.imageView.image = playlistImage;
        });
    }];
    
    self.headerView.textLabel.text = self.playlist.title;
    self.headerView.artistNameLabel.hidden = YES;
    self.headerView.seeArtistButton.hidden = YES;
}

- (void)setUpTableViewConstraints
{
    NSDictionary *viewsDictionary = @{superView:self.view, headerView:self.headerView, tableView:self.tableView};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView(==superView)]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView(==superView)]|" options:0 metrics:nil views:viewsDictionary]];
}

- (void)setUpDataSource
{
    WebRequestHandler *requestHandler = [WebRequestHandler sharedHandler];
    [requestHandler getTracksFrom:self.playlist.trackListUrl andCompletionHandler:^(NSArray * _Nonnull tracks) {
        
        self.trackList = tracks;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.trackList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Track *currentTrack = self.trackList[indexPath.row];
    
    TrackCustomTableCell *cell = (TrackCustomTableCell *)[self.tableView dequeueReusableCellWithIdentifier:trackCellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[TrackCustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:trackCellIdentifier];
    }
    
    cell.delegate = self;
    cell.titleLabel.text = currentTrack.title;
    cell.artistNameLabel.text = currentTrack.artist.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *userInfo = @{trackList:self.trackList, currentTrackIndex:[NSNumber numberWithInteger:indexPath.row]};
    [[NSNotificationCenter defaultCenter] postNotificationName:playTrack object:nil userInfo:userInfo];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)displayOptions:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    Track *currentTrack = self.trackList[indexPath.row];
    
    UIAlertController *alertController = [[UIAlertController alloc] init];
    UIAlertAction *displayArtistAction = [UIAlertAction actionWithTitle:alertArtistAction style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        ArtistDetailViewController *artistDetailViewController = [[ArtistDetailViewController alloc] init];
        artistDetailViewController.artist = currentTrack.artist;
        artistDetailViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:artistDetailViewController animated:YES];
    }];
    
    UIAlertAction *displayAlbumAction = [UIAlertAction actionWithTitle:alertAlbumAction style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AlbumDetailViewController *albumDetailViewController = [[AlbumDetailViewController alloc] init];
        albumDetailViewController.album = currentTrack.album;
        albumDetailViewController.hidesBottomBarWhenPushed = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:albumDetailViewController animated:YES];
        });
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:alertCancelAction style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:displayArtistAction];
    [alertController addAction:displayAlbumAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
