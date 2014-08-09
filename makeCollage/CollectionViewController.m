//
//  CollectionViewController.m
//  makeCollage
//
//  Created by Svetlana Tsetsorina on 09.08.14.
//  Copyright (c) 2014 BeOriginal. All rights reserved.
//

#import "CollectionViewController.h"
#import "SearchViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"number of images %i", [[SearchViewController imagePaths] count]);
    
    UINib *cellNib = [UINib nibWithNibName:@"CollectionCell" bundle:[NSBundle mainBundle]];
    
    [self.collectionOfImages registerNib:cellNib forCellWithReuseIdentifier:@"imgCell"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[SearchViewController imagePaths] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*static NSString *ids = @"collCell";
    
    CollectionCell *cell = (CollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:ids forIndexPath:indexPath];
    
    NSString *imgURL = [[SearchViewController imagePaths] objectAtIndex:indexPath.row];
    
    //NSData *imgData=[NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]];
    
    NSLog(@"indexPath.row %@", [[SearchViewController imagePaths] objectAtIndex:indexPath.row]);
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imgURL]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        cell.imageViewCell.image = [UIImage imageWithData:data];
    }];
    
    return cell;*/
    
    static NSString *ids = @"imgCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ids forIndexPath:indexPath];
    
    //((UIImageView *)[cell viewWithTag:55]).image = [NSString stringWithFormat:@"%i", indexPath.row];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[SearchViewController imagePaths] objectAtIndex:indexPath.row]]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        ((UIImageView *)[cell viewWithTag:55]).image = [UIImage imageWithData:data];
    }];
    
    return cell;
}

@end
