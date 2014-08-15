#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchImageName;
- (IBAction)searchBtn:(id)sender;

+ (NSMutableArray *)imagePaths;

@end
