//
//  PhotoEditorViewController.m
//  ImageUploader
//
//  Created by Claus Höfele on 25.02.14.
//  Copyright (c) 2014 Claus Höfele. All rights reserved.
//

#import "PhotoEditorViewController.h"

#import "CoreImageService.h"

@interface PhotoEditorViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *thumbnailButtons;
@property (strong, nonatomic) CoreImageService *coreImageService;

@end

@implementation PhotoEditorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.coreImageService = [[CoreImageService alloc] initWithAsset:self.asset];
    [self update];
}

- (void)update
{
    self.mainImageView.image = [UIImage imageWithCGImage:self.coreImageService.fullScreenCGImage];
    UIButton *defaultButton = self.thumbnailButtons[0];
    [defaultButton setBackgroundImage:self.mainImageView.image forState:UIControlStateNormal];
    
    for (NSUInteger i = 1; i < self.thumbnailButtons.count; i++) {
        [self.coreImageService createFilteredImageForFilterIndex:i completionBlock:^(UIImage *image) {
            UIButton *button = self.thumbnailButtons[i];
            [button setBackgroundImage:image forState:UIControlStateNormal];
        }];
    }
}

- (IBAction)selectFilter:(UIButton *)sender
{
    UIImage *image = [sender backgroundImageForState:UIControlStateNormal];
    if (image) {
        self.mainImageView.image = image;
    }
}

- (IBAction)cancel:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)send:(id)sender
{
    
}

@end
