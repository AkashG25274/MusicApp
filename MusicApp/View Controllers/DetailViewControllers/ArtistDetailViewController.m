//
//  ArtistDetailViewController.m
//  MusicApp
//
//  Created by mmt on 18/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "ArtistDetailViewController.h"
#import "../CustomUI/ArtistPlaylistHeaderView.h"
#import "../../Network Controllers/WebRequestHandler.h"
#import "ArtistDetailsTabBarController.h"
#import "../../Constants.h"

@interface ArtistDetailViewController ()

@property (strong, nonatomic) ArtistPlaylistHeaderView *headerView;
@property (strong, nonatomic) UIView *containerView;

@end

@implementation ArtistDetailViewController

- (id)init
{
    self = [super init];
    
    if(self)
    {
        self.artist = [[Artist alloc] init];
        self.trackList = [[NSArray alloc] init];
        self.albums = [[NSArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.headerView = [[ArtistPlaylistHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.headerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.headerView.backgroundColor = UIColor.whiteColor;
    self.headerView.imageView.image = [UIImage imageNamed:@"profile"];
    self.headerView.textLabel.text = @"Artist Name";
    [self.view addSubview:self.headerView];
 
    self.containerView = [[UIView alloc] init];
    [self.containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.containerView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.containerView];

    UITabBarController *controller = [[ArtistDetailsTabBarController alloc] init];
    [self addChildViewController:controller];
    [controller.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.containerView addSubview:controller.view];
    [controller didMoveToParentViewController:self];
    
    [self setUpConstraints];
    [self.headerView setUpConstraints];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[controllerView(==superView)]" options:0 metrics:nil views:@{@"controllerView":controller.view, @"superView":self.containerView}]];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[controllerView(==superView)]" options:0 metrics:nil views:@{@"controllerView":controller.view, @"superView":self.containerView}]];
    
    [self setUpViewsForHeaderView];
}

- (void)setUpConstraints
{
    NSDictionary *viewsDictionary = @{@"superView":self.view, @"headerView":self.headerView, @"containerView":self.containerView};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[headerView(250)][containerView]-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[headerView(==superView)]" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[containerView(==superView)]" options:0 metrics:nil views:viewsDictionary]];
}

- (void)setUpViewsForHeaderView
{
    WebRequestHandler *requestHandler = [WebRequestHandler sharedHandler];
    UIImage *artistImage = [requestHandler.imageCache objectForKey:self.artist.pictureUrl];
    self.headerView.imageView.image = artistImage;
    self.headerView.textLabel.text = self.artist.name;
}

@end