//
//  CollageViewController.h
//  makeCollage
//
//  Created by Svetlana Tsetsorina on 09.08.14.
//  Copyright (c) 2014 BeOriginal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewController.h"

@interface CollageViewController : UIViewController <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageViewForCollage;
@property (weak, nonatomic) IBOutlet UIImageView *sticker1Img;
@property (weak, nonatomic) IBOutlet UIImageView *sticker2Img;

@property (weak, nonatomic) IBOutlet UIImageView *topLeftView;
@property (weak, nonatomic) IBOutlet UIImageView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *topRightView;
@property (weak, nonatomic) IBOutlet UIImageView *rightView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomRightView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomLeftView;
@property (weak, nonatomic) IBOutlet UIImageView *leftView;

@property (strong, nonatomic) UIImage *collImage;

- (IBAction)backBtn:(id)sender;
- (IBAction)sticker1Btn:(id)sender;
- (IBAction)sticker2Btn:(id)sender;
- (IBAction)downloadBtn:(id)sender;
- (IBAction)toggleBtn:(UIButton *)sender;


@end
