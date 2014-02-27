//
//  NetworkServiceTests.m
//  ImageUploader
//
//  Created by Claus Höfele on 27.02.14.
//  Copyright (c) 2014 Claus Höfele. All rights reserved.
//

#import "NetworkService.h"

#import <XCTest/XCTest.h>

@interface NetworkServiceTests : XCTestCase

@property (nonatomic, strong) NetworkService *networkService;
@property (nonatomic, assign) BOOL done;

@end

@implementation NetworkServiceTests

- (void)setUp
{
    [super setUp];
    
    self.networkService = [[NetworkService alloc] init];
}

- (BOOL)waitForCompletion:(NSTimeInterval)timeoutSecs
{
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [NSRunLoop.currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if (timeoutDate.timeIntervalSinceNow < 0.0) {
            break;
        }
    } while (!self.done);
    
    return self.done;
}

- (void)testUploadImage
{
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSString *imagePath = [bundle pathForResource:@"test_image" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    [self.networkService uploadImage:image withCompletionBlock:^{
        self.done = YES;
    }];
    
    XCTAssertTrue([self waitForCompletion:5.0], @"Time out");
}

@end
