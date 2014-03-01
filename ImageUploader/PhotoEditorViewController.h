//
//  PhotoEditorViewController.h
//  ImageUploader
//
//  Created by Claus Höfele on 25.02.14.
//  Copyright (c) 2014 Claus Höfele. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class NetworkService;

@interface PhotoEditorViewController : UIViewController

@property (strong, nonatomic) ALAsset *asset;
@property (nonatomic, copy) void (^completionBlock)(UIImage *image);

@end
