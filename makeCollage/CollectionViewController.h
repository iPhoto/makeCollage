//
//  CollectionViewController.h
//  makeCollage
//
//  Created by Svetlana Tsetsorina on 09.08.14.
//  Copyright (c) 2014 BeOriginal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionOfImages;

@end
