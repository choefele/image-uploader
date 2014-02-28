//
//  CoreImageController.m
//  ImageUploader
//
//  Created by Claus Höfele on 28.02.14.
//  Copyright (c) 2014 Claus Höfele. All rights reserved.
//

#import "CoreImageService.h"

@interface CoreImageService ()

@property (strong, nonatomic) CIContext *contextCI;
@property (strong, nonatomic) CIImage *fullScreenCIImage;
@property (strong, nonatomic) CGImageRef fullScreenCGImage __attribute__((NSObject));

@end

@implementation CoreImageService

- (id)initWithAsset:(ALAsset *)asset
{
    self = [super init];
    if (self) {
        _contextCI = [CIContext contextWithOptions:nil];
        _fullScreenCGImage = asset.defaultRepresentation.fullScreenImage;
        _fullScreenCIImage = [CIImage imageWithCGImage:_fullScreenCGImage];
    }
    
    return self;
}

- (CIFilter *)createFilterForIndex:(NSUInteger)index
{
    CIFilter *sepiaFilter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, self.fullScreenCIImage, @"inputIntensity", @0.8, nil];
    
    return sepiaFilter;
}

- (void)createFilteredImageForFilterIndex:(NSUInteger)index completionBlock:(void (^)(UIImage *image))completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CIFilter *filter = [self createFilterForIndex:0];
        CIImage *outputImage = [filter outputImage];
        CGImageRef outputImageCG = [self.contextCI createCGImage:outputImage fromRect:outputImage.extent];
        UIImage *newImage = [UIImage imageWithCGImage:outputImageCG];
        CGImageRelease(outputImageCG);
        
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(newImage);
            });
        }
    });
}

@end
