//
//  InfoViewController.m
//  Recycle4
//
//  Created by Michael Stephenson on 12/8/13.
//  Copyright (c) 2013 Michael Stephenson. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    // Loads image background behind web view
    self.infoBackgroundImage.image = [UIImage imageNamed:@"infoBackground.jpg"];

#pragma mark - Update HTML files
    //..Loads a Local HTML File
    strHTML = @"Info";
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:strHTML ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [_infoWebView loadHTMLString:htmlString baseURL:baseURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
