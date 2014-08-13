//
//  CollageViewController.m
//  makeCollage
//
//  Created by Svetlana Tsetsorina on 09.08.14.
//  Copyright (c) 2014 BeOriginal. All rights reserved.
//

#import "CollageViewController.h"
#import "CollectionViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <SpriteKit/SpriteKit.h>

@interface CollageViewController ()

@end

@implementation CollageViewController {
    UIImage *resultForResize;
}

@synthesize collImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bc.jpg"]];
    
    self.imageViewForCollage.image = self.collImage;
    self.imageViewForCollage.contentMode = UIViewContentModeScaleAspectFill;
    self.imageViewForCollage.clipsToBounds = YES;
    [self.view addSubview:self.imageViewForCollage];
    
    [self.imageViewForCollage addSubview:self.topView];
    [self.imageViewForCollage addSubview:self.bottomView];
    [self.imageViewForCollage addSubview:self.leftView];
    [self.imageViewForCollage addSubview:self.rightView];
    [self.imageViewForCollage addSubview:self.bottomLeftView];
    [self.imageViewForCollage addSubview:self.bottomRightView];
    [self.imageViewForCollage addSubview:self.topLeftView];
    [self.imageViewForCollage addSubview:self.topRightView];
}

#pragma mark - Go Back
- (IBAction)backBtn:(id)sender {
    CollectionViewController *controller = [[CollectionViewController alloc] initWithNibName:@"CollectionViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - Handling Frames
- (void)getNames:(int)index
{
    self.topView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i_top", index]];
    self.topView.contentMode = UIViewContentModeScaleToFill;
    self.bottomView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i_bottom", index]];
    self.bottomView.contentMode = UIViewContentModeScaleToFill;
    self.leftView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i_left", index]];
    self.leftView.contentMode = UIViewContentModeScaleToFill;
    self.rightView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i_right", index]];
    self.rightView.contentMode = UIViewContentModeScaleToFill;

    self.topLeftView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i_top_left", index]];
    self.topRightView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i_top_right", index]];
    self.bottomLeftView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i_bottom_left", index]];
    self.bottomRightView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i_bottom_right", index]];
}

- (void)imagePixel1:(int)imgParameter
{
    if (imgParameter < 1000) {
        int idx = 1000;
        [self getNames:idx];
    } else if ((imgParameter >= 1000) && (imgParameter < 2000)) {
        int idx = 2000;
        [self getNames:idx];
    } else if ((imgParameter >= 2000) && (imgParameter < 3000)) {
        int idx = 3000;
        [self getNames:idx];
    } else if ((imgParameter >= 3000) && (imgParameter < 4000)) {
        int idx = 4000;
        [self getNames:idx];
    } else if (imgParameter >= 4000) {
        int idx = 5000;
        [self getNames:idx];
    }
}

- (void)createFrame1
{
    int imageWidth = self.collImage.size.width;
    int imageHeight = self.collImage.size.height;
    
    if (imageHeight > imageWidth) {
        [self imagePixel1:imageWidth];
    } else {
        [self imagePixel1:imageHeight];
    }
}

- (void)imagePixel2:(int)imgParameter
{
    if (imgParameter < 1000) {
        int idx = 1001;
        [self getNames:idx];
    } else if ((imgParameter >= 1000) && (imgParameter < 2000)) {
        int idx = 2001;
        [self getNames:idx];
    } else if ((imgParameter >= 2000) && (imgParameter < 3000)) {
        int idx = 3001;
        [self getNames:idx];
    } else if ((imgParameter >= 3000) && (imgParameter < 4000)) {
        int idx = 4001;
        [self getNames:idx];
    } else if (imgParameter >= 4000) {
        int idx = 5001;
        [self getNames:idx];
    }
}

- (void)createFrame2
{
    int imageWidth = self.collImage.size.width;
    int imageHeight = self.collImage.size.height;
    
    if (imageHeight > imageWidth) {
        [self imagePixel2:imageWidth];
    } else {
        [self imagePixel2:imageHeight];
    }
}

#pragma mark - Frames
- (IBAction)toggleBtn:(UIButton *)sender
{
    if (sender.tag == 1) {

        [self hideImage:self.topView];
        [self hideImage:self.bottomView];
        [self hideImage:self.leftView];
        [self hideImage:self.rightView];
        [self hideImage:self.topLeftView];
        [self hideImage:self.topRightView];
        [self hideImage:self.bottomLeftView];
        [self hideImage:self.bottomRightView];
        
        if (self.topView.hidden == NO) {
            [self createFrame1];
        }
    } else if (sender.tag == 2) {
        
        [self hideImage:self.topView];
        [self hideImage:self.bottomView];
        [self hideImage:self.leftView];
        [self hideImage:self.rightView];
        [self hideImage:self.topLeftView];
        [self hideImage:self.topRightView];
        [self hideImage:self.bottomLeftView];
        [self hideImage:self.bottomRightView];
        
        if (self.topView.hidden == NO) {
            [self createFrame2];
        }
    }
}

#pragma mark - Resize Image
- (void)resizeImage:(UIImageView *)imgView
{
    [imgView setUserInteractionEnabled:YES];
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureDetected:)];
    [pinchGestureRecognizer setDelegate:self];
    [imgView addGestureRecognizer:pinchGestureRecognizer];
    
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureDetected:)];
    [rotationGestureRecognizer setDelegate:self];
    [imgView addGestureRecognizer:rotationGestureRecognizer];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDetected:)];
    [panGestureRecognizer setDelegate:self];
    [imgView addGestureRecognizer:panGestureRecognizer];
    
    [self.view addSubview:imgView];
}

- (void)pinchGestureDetected:(UIPinchGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = recognizer.state;
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGFloat scale = [recognizer scale];
        [recognizer.view setTransform:CGAffineTransformScale(recognizer.view.transform, scale, scale)];
        [recognizer setScale:1.0];
    }
}

- (void)rotationGestureDetected:(UIRotationGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = recognizer.state;

    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGFloat rotation = [recognizer rotation];
        [recognizer.view setTransform:CGAffineTransformRotate(recognizer.view.transform, rotation)];
        [recognizer setRotation:0];
    }
}

- (void)panGestureDetected:(UIPanGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = recognizer.state;
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:recognizer.view];
        [recognizer.view setTransform:CGAffineTransformTranslate(recognizer.view.transform, translation.x, translation.y)];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - Hide Image
- (void)hideImage:(UIImageView *)imgView
{
    if (imgView.hidden == YES) {
        imgView.hidden = NO;
    } else imgView.hidden = YES;
}

#pragma mark - Stickers
- (IBAction)sticker1Btn:(id)sender {
    [self resizeImage:self.sticker1Img];
    [self hideImage:self.sticker1Img];
}

- (IBAction)sticker2Btn:(id)sender {
    [self resizeImage:self.sticker2Img];
    [self hideImage:self.sticker2Img];
}

#pragma mark - Merge & Download
- (UIImage *)mergeImages
{
    [self.imageViewForCollage addSubview:self.sticker1Img];
    [self.imageViewForCollage addSubview:self.sticker2Img];
    
    UIGraphicsBeginImageContext(self.imageViewForCollage.bounds.size);
    [self.imageViewForCollage.layer renderInContext:UIGraphicsGetCurrentContext()];

    self.sticker1Img.center = CGPointMake(self.sticker1Img.center.x, self.sticker1Img.center.y - 62);
    self.sticker2Img.center = CGPointMake(self.sticker2Img.center.x, self.sticker2Img.center.y - 62);
    
    UIImage *mergedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return mergedImage;
}

- (IBAction)downloadBtn:(id)sender {
    UIImage *imgForSave = [self mergeImages];
    UIImageWriteToSavedPhotosAlbum(imgForSave, nil, nil, nil);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"You've Successfully Saved the Image to the Photo Album" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
