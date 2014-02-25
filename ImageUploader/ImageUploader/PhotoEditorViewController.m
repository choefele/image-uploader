//
//  PhotoEditorViewController.m
//  ImageUploader
//
//  Created by Claus Höfele on 25.02.14.
//  Copyright (c) 2014 Claus Höfele. All rights reserved.
//

#import "PhotoEditorViewController.h"

@interface PhotoEditorViewController ()

@end

@implementation PhotoEditorViewController

- (IBAction)cancel:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)send:(id)sender
{
    
}

@end
