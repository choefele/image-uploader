//
//  NetworkServiceDelegate.h
//  ImageUploader
//
//  Created by Claus Höfele on 01.03.14.
//  Copyright (c) 2014 Claus Höfele. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkServiceDelegate <NSObject>

@optional
- (void)networkService:(NetworkService *)networkService didSendImageDataWithProgress:(float)progress;

@end
