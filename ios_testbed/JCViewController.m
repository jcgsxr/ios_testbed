//
//  JCViewController.m
//  ios_testbed
//
//  Created by Johnny Chan on 6/13/12.
//  Copyright (c) 2012 Johnny Chan. All rights reserved.
//

#import "JCViewController.h"

@interface JCViewController ()

@end

@implementation JCViewController
@synthesize socialViewButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
