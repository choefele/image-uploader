//
//  PhotoCollectionViewCell.m
//  ImageUploader
//
//  Created by Claus Höfele on 25.02.14.
//  Copyright (c) 2014 Claus Höfele. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@interface PhotoCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation PhotoCollectionViewCell

- (void)updateWithAsset:(ALAsset *)asset
{
    self.imageView.image = [UIImage imageWithCGImage:asset.thumbnail];
}

@end
