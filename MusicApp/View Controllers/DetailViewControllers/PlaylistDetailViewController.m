//
//  PlaylistDetailViewController.m
//  MusicApp
//
//  Created by mmt on 17/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "PlaylistDetailViewController.h"
#import "../../Network Controllers/WebRequestHandler.h"
#import "../../Model Classes/Track.h"
#import "../CustomUI/PlaylistTrackCustomCell.h"
#import "../../Constants.h"

@interface PlaylistDetailViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *trackList;

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
    
    self.tableView = [[UITableView alloc] init];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.tableView.rowHeight = 70;
    [self.view addSubview:self.tableView];
    [self setUpConstraints];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[PlaylistTrackCustomCell class] forCellReuseIdentifier:trackCellIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.trackList = [[NSArray alloc] init];
    [self setUpDataSource];
}

- (void)setUpConstraints
{
    NSDictionary *viewsDictionary = @{superView:self.view, tableView:self.tableView};
    
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
    
    PlaylistTrackCustomCell *cell = (PlaylistTrackCustomCell *)[self.tableView dequeueReusableCellWithIdentifier:trackCellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[PlaylistTrackCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:trackCellIdentifier];
    }
    
    cell.titleLabel.text = currentTrack.title;
    
    return cell;
}

#pragma mark <UIViewControllerPreviewingDelegate>

@end
