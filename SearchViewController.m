//
//  SearchViewController.m
//  makeCollage
//
//  Created by Svetlana Tsetsorina on 09.08.14.
//  Copyright (c) 2014 BeOriginal. All rights reserved.
//

#import "SearchViewController.h"
#import "CollectionViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

static NSMutableArray *images;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
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
}
@end
