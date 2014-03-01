//
//  NetworkService.h
//  ImageUploader
//
//  Created by Claus Höfele on 27.02.14.
//  Copyright (c) 2014 Claus Höfele. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkServiceDelegate;

@interface NetworkService : NSObject

@property (nonatomic, weak) id<NetworkServiceDelegate> delegate;

- (void)uploadImage:(UIImage *)image withCompletionBlock:(void (^)())completionBlock;

@end
