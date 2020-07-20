//
//  TrackTabViewController.m
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "TrackViewController.h"
#import "./CustomUI/TrackCustomTableCell.h"
#import "../Network Controllers/WebRequestHandler.h"
#import "./CustomUI/ContextViewController.h"
#import "../Model Classes/Track.h"
#import "../Constants.h"

@interface TrackViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *trackList;

@end

@implementation TrackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] init];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.tableView.rowHeight = 70;
    [self.view addSubview:self.tableView];
    [self setUpConstraints];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[TrackCustomTableCell class] forCellReuseIdentifier:trackCellIdentifier];
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
    [requestHandler getTracksFrom:self.trackURL andCompletionHandler:^(NSArray * _Nonnull tracks) {
        
        self.trackList = tracks;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void)displayOptions:(UITableViewCell *)cell
{
    ContextViewController *alertController = [[ContextViewController alloc] init];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    alertController.artist = [self.trackList[indexPath.row] artist];
    alertController.album = [self.trackList[indexPath.row] album];

    [self presentViewController:alertController animated:YES completion:nil];
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
    NSDictionary *userInfo = @{@"trackList":self.trackList, @"currentTrackIndex":[NSNumber numberWithInteger:indexPath.row]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayTrack" object:nil userInfo:userInfo];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
