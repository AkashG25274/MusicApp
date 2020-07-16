//
//  AlbumsTabViewController.m
//  MusicApp
//
//  Created by mmt on 15/07/20.
//  Copyright © 2020 mmt. All rights reserved.
//

#import "AlbumsTabViewController.h"

@interface AlbumsTabViewController ()

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation AlbumsTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
}

@end
