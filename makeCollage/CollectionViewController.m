#import "CollectionViewController.h"
#import "SearchViewController.h"
#import "CollageViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController {
    UIImage *img;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bc.jpg"]];

    UINib *cellNib = [UINib nibWithNibName:@"CollectionCell" bundle:[NSBundle mainBundle]];
    [self.collectionOfImages registerNib:cellNib forCellWithReuseIdentifier:@"imgCell"];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[SearchViewController imagePaths] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ids = @"imgCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ids forIndexPath:indexPath];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[SearchViewController imagePaths] objectAtIndex:indexPath.row]]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        img = [UIImage imageWithData:data];
        ((UIImageView *)[cell viewWithTag:55]).image = img;
    }];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)goToCollageView:(UIImage *)theImage
{
    CollageViewController *controller = [[CollageViewController alloc] initWithNibName:@"CollageViewController" bundle:nil];
    controller.collImage = theImage;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[SearchViewController imagePaths] objectAtIndex:indexPath.row]]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        img = [UIImage imageWithData:data];
        [self goToCollageView:img];
    }];
}

#pragma mark - Go Back
- (IBAction)backBtn:(id)sender {
    SearchViewController *controller = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:controller animated:YES completion:nil];
}

@end
