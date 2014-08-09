//
//  SearchViewController.h
//  makeCollage
//
//  Created by Svetlana Tsetsorina on 09.08.14.
//  Copyright (c) 2014 BeOriginal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchImageName;
- (IBAction)searchBtn:(id)sender;

+ (NSMutableArray *)imagePaths;

@end
