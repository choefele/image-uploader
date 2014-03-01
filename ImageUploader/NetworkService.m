//
//  NetworkService.m
//  ImageUploader
//
//  Created by Claus Höfele on 27.02.14.
//  Copyright (c) 2014 Claus Höfele. All rights reserved.
//

#import "NetworkService.h"

#import "NetworkServiceDelegate.h"

@interface NetworkService () <NSURLSessionTaskDelegate>

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation NetworkService

- (id)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [self.session invalidateAndCancel];
}

- (void)uploadImage:(UIImage *)image withCompletionBlock:(void (^)())completionBlock
{
    NSURL *url = [NSURL URLWithString:@"http://posttestserver.com/post.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request addValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
    
    NSURLSessionUploadTask *uploadTask = [self.session uploadTaskWithRequest:request fromData:imageData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock();
            });
        }
    }];
    [uploadTask resume];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    if ([self.delegate respondsToSelector:@selector(networkService:didSendImageDataWithProgress:)]) {
        float progress = (float)totalBytesSent/(float)totalBytesExpectedToSend;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate networkService:self didSendImageDataWithProgress:progress];
        });
    }
}

@end
