//
//  AlbumDetailViewController.m
//  MusicApp
//
//  Created by mmt on 17/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "AlbumDetailViewController.h"
#import "../../Network Controllers/WebRequestHandler.h"
#import "../CustomUI/AlbumHeaderView.h"
#import "../../Model Classes/Track.h"
#import "../../Constants.h"

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
    self.headerView.backgroundColor = UIColor.whiteColor;
    
    self.tableView = [[UITableView alloc] init];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.rowHeight = 70;
    [self.view addSubview:self.tableView];
    
    [self setUpConstraints];
    [self setUpHeaderViewConstraints];
    [self.headerView setUpConstraints];
    
    self.headerView.albumImageView.image = [UIImage imageNamed:@"profile"];
    self.headerView.titleLabel.text = @"Album Title";
    self.headerView.artistNameLabel.text = @"Atist Name";
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:trackCellIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.trackList = [[NSArray alloc] init];
    [self setUpDataSource];
}

- (void)setUpHeaderViewConstraints
{
    [[self.headerView.centerXAnchor constraintEqualToAnchor:self.tableView.centerXAnchor] setActive:YES];
    [[self.headerView.widthAnchor constraintEqualToAnchor:self.tableView.widthAnchor] setActive:YES];
    [[self.headerView.topAnchor constraintEqualToAnchor:self.tableView.topAnchor] setActive:YES];
    
    [self.tableView.tableHeaderView layoutIfNeeded];
    self.tableView.tableHeaderView = self.tableView.tableHeaderView;
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
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:trackCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = currentTrack.title;
    
    return cell;
}

@end
