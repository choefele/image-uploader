//
//  NetworkService.m
//  ImageUploader
//
//  Created by Claus Höfele on 27.02.14.
//  Copyright (c) 2014 Claus Höfele. All rights reserved.
//

#import "NetworkService.h"

@interface NetworkService ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation NetworkService

- (id)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    }
    
    return self;
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
            completionBlock();
        }
    }];
    [uploadTask resume];
}

@end
