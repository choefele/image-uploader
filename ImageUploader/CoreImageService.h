//
//  CoreImageController.h
//  ImageUploader
//
//  Created by Claus Höfele on 28.02.14.
//  Copyright (c) 2014 Claus Höfele. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CoreImageService : NSObject

@property (strong, nonatomic, readonly) CGImageRef fullScreenCGImage __attribute__((NSObject));

- (id)initWithAsset:(ALAsset *)asset;

- (void)createFilteredImageForFilterIndex:(NSUInteger)index completionBlock:(void (^)(UIImage *image))completionBlock;

@end
