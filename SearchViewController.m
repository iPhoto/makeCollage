#import "SearchViewController.h"
#import "CollectionViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

static NSMutableArray *images;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bc.jpg"]];
}

#pragma mark - Parser
- (NSURL *)composeURL
{
    NSString *escapedSearchText = [self.searchImageName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString = [NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=%@", escapedSearchText];
    NSURL *searchURL = [NSURL URLWithString:urlString];

    return searchURL;
}

- (NSDictionary *)parseJSON
{
    NSString *jsonString = [NSString stringWithContentsOfURL:[self composeURL] encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    id resultObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (resultObject == nil) {
        NSLog(@"JSON Error: %@", error);
        return nil;
    }
    
    if (![resultObject isKindOfClass:[NSDictionary class]]) {
        NSLog(@"JSON Error: Expected dictionary");
        return nil;
    }
    
    return resultObject;
}

-(void)parseImageUrlFromJSON
{
    NSDictionary *dict = [self parseJSON];
    
    NSArray *jsonArray = [[dict objectForKey:@"responseData"] objectForKey:@"results"];
    if (jsonArray == nil) {
        NSLog(@"Expected 'results' array");
        return;
    }
    
    images = [[NSMutableArray alloc] init];
    
    for (NSDictionary *jsonDict in jsonArray) {
        NSString *imageURL = [jsonDict objectForKey:@"url"];
        NSLog(@"imageURL %@", imageURL);
        
        [images addObject:imageURL];
    }
}

+ (NSMutableArray *)imagePaths
{
    return images;
}

#pragma mark - Search Button
- (void)goToCollectionView
{
    CollectionViewController *controller = [[CollectionViewController alloc] initWithNibName:@"CollectionViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:controller animated:YES completion:nil];

}

- (IBAction)searchBtn:(id)sender {
    [self.searchImageName resignFirstResponder];
    [self parseImageUrlFromJSON];
    
    [self goToCollectionView];
}

#pragma mark - Search Bar
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self parseImageUrlFromJSON];
    
    [self goToCollectionView];
}
@end
