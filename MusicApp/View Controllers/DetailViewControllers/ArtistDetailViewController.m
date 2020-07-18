//
//  ArtistDetailViewController.m
//  MusicApp
//
//  Created by mmt on 18/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "ArtistDetailViewController.h"
#import "../CustomUI/ArtistPlaylistHeaderView.h"
#import "../../Constants.h"

@interface ArtistDetailViewController ()

@property (strong, nonatomic) ArtistPlaylistHeaderView *headerView;
@property (strong, nonatomic) UIView *buttonsView;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UIButton *tracksButton;
@property (strong, nonatomic) UIButton *albumsButton;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *tracks;
@property (strong, nonatomic) NSArray *albums;

@end

@implementation ArtistDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.headerView = [[ArtistPlaylistHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.headerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.headerView.backgroundColor = UIColor.whiteColor;
    self.headerView.imageView.image = [UIImage imageNamed:@"profile"];
    self.headerView.textLabel.text = @"Artist Name";
    [self.view addSubview:self.headerView];
    
    self.buttonsView = [[UIView alloc] init];
    [self.buttonsView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.buttonsView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.buttonsView];
    
    self.containerView = [[UIView alloc] init];
    [self.containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.containerView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.containerView];
    
    self.tracksButton = [[UIButton alloc] init];
    [self.tracksButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.tracksButton setTitle:@"Tracks" forState:UIControlStateNormal];
    [self.tracksButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.tracksButton addTarget:self action:@selector(showTracks:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonsView addSubview:self.tracksButton];
    
    self.albumsButton = [[UIButton alloc] init];
    [self.albumsButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.albumsButton setTitle:@"Albums" forState:UIControlStateNormal];
    [self.albumsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.albumsButton addTarget:self action:@selector(showAlbums:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonsView addSubview:self.albumsButton];
    
    self.tableView = [[UITableView alloc] init];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.tableView.rowHeight = 70;
    [self.containerView addSubview:self.tableView];
    [self setUpConstraints];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tracks = [[NSArray alloc] init];
    self.albums = [[NSArray alloc] init];
    
    [self setUpConstraints];
    [self setUpTableViewConstraints];
    [self.headerView setUpConstraints];
}

- (void)showTracks:(UIButton *)button
{
    self.containerView.backgroundColor = UIColor.redColor;
}

- (void)showAlbums:(UIButton *)button
{
    self.containerView.backgroundColor = UIColor.greenColor;
}

- (void)setUpConstraints
{
    NSDictionary *viewsDictionary = @{@"superView":self.view, @"headerView":self.headerView, @"buttonsView":self.buttonsView, @"containerView":self.containerView, @"trackButton":self.tracksButton, @"albumButton":self.albumsButton};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[headerView(250)]-10-[buttonsView(50)]-[containerView]-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[headerView(==superView)]" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[buttonsView(==superView)]" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[containerView(==superView)]" options:0 metrics:nil views:viewsDictionary]];
    
    [self.buttonsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[trackButton]" options:0 metrics:nil views:viewsDictionary]];
    
    [self.buttonsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[trackButton][albumButton(==trackButton)]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary]];
}

- (void)setUpTableViewConstraints
{
    NSDictionary *viewsDictionary = @{superView:self.containerView, tableView:self.tableView};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView(==superView)]|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView(==superView)]|" options:0 metrics:nil views:viewsDictionary]];
}

#pragma mark <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;//self.artists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Artist *currentArtist = self.artists[indexPath.row];

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
//    cell.imageView.image = [UIImage imageNamed:artistDefaultImage];
    cell.textLabel.text = @"Demo";//currentArtist.name;

//    WebRequestHandler *requesthandler = [WebRequestHandler sharedHandler];
//    [requesthandler downloadImageFrom:currentArtist.pictureUrl completionBlock:^(UIImage * _Nonnull artistImage) {
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            cell.imageView.image = artistImage;
//        });
//    }];

    return cell;
}

@end
