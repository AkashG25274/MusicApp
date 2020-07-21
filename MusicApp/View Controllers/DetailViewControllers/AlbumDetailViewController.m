//
//  AlbumDetailViewController.m
//  MusicApp
//
//  Created by mmt on 17/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "AlbumDetailViewController.h"
#import "WebRequestHandler.h"
#import "AlbumHeaderView.h"
#import "Track.h"
#import "Constants.h"
#import "TrackCustomTableCell.h"
#import "ContextViewController.h"
#import "ArtistDetailViewController.h"

@interface AlbumDetailViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *trackList;
@property (strong, nonatomic) AlbumHeaderView *headerView;

@end

@implementation AlbumDetailViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.album = [[Album alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.headerView = [[AlbumHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.headerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.headerView.delegate = self;
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
    
    self.navigationItem.title = self.album.title;
}

- (void)setUpHeaderViewConstraints
{
    [[self.headerView.centerXAnchor constraintEqualToAnchor:self.tableView.centerXAnchor] setActive:YES];
    [[self.headerView.widthAnchor constraintEqualToAnchor:self.tableView.widthAnchor] setActive:YES];
    [[self.headerView.topAnchor constraintEqualToAnchor:self.tableView.topAnchor] setActive:YES];
    
    [self.tableView.tableHeaderView layoutIfNeeded];
    self.tableView.tableHeaderView = self.tableView.tableHeaderView;
}

- (void)setUpTableViewConstraints
{
    NSDictionary *viewsDictionary = @{superView:self.view, tableView:self.tableView};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView(==superView)]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView(==superView)]|" options:0 metrics:nil views:viewsDictionary]];
}

- (void)setUpViewsForHeaderView
{
    WebRequestHandler *requestHandler = [WebRequestHandler sharedHandler];
    [requestHandler downloadImageFrom:self.album.coverImageUrl completionBlock:^(UIImage * _Nonnull albumImage) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.headerView.albumImageView.image = albumImage;
        });
    }];
    
    self.headerView.titleLabel.text = self.album.title;
    self.headerView.artistNameLabel.text = self.album.artist.name;
}

- (void)setUpDataSource
{
    WebRequestHandler *requestHandler = [WebRequestHandler sharedHandler];
    [requestHandler getTracksFrom:self.album.trackListUrl andCompletionHandler:^(NSArray * _Nonnull tracks) {
        
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
    cell.optionsButton.hidden = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *userInfo = @{@"trackList":self.trackList, @"currentTrackIndex":[NSNumber numberWithInteger:indexPath.row]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayTrack" object:nil userInfo:userInfo];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)displayArtist
{
    ArtistDetailViewController *artistDetailViewController = [[ArtistDetailViewController alloc] init];
    artistDetailViewController.artist = self.album.artist;
    [self.navigationController pushViewController:artistDetailViewController animated:YES];
}

@end
