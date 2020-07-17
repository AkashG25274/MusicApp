//
//  ArtistsTabViewController.m
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "ArtistsTabViewController.h"
#import "../Network Controllers/WebRequestHandler.h"
#import "../Model Classes/Artist.h"
#import "../Constants.h"

@interface ArtistsTabViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *artists;

@end

@implementation ArtistsTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] init];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.tableView.rowHeight = 70;
    [self.view addSubview:self.tableView];
    [self setUpConstraints];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:artistCellIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.artists = [[NSArray alloc] init];
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
    [requestHandler getArtists:^(NSArray * _Nonnull artistList) {
        
        self.artists = artistList;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.artists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Artist *currentArtist = self.artists[indexPath.row];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:artistCellIdentifier forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:artistDefaultImage];
    cell.textLabel.text = currentArtist.name;
    
    WebRequestHandler *requesthandler = [WebRequestHandler sharedHandler];
    [requesthandler downloadImageFrom:currentArtist.pictureUrl completionBlock:^(UIImage * _Nonnull artistImage) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = artistImage;
        });
    }];
    
    return cell;
}


@end
