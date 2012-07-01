//
//  JCiCloudTestViewController.m
//  ios_testbed
//
//  Created by Johnny Chan on 6/30/12.
//  Copyright (c) 2012 Johnny Chan. All rights reserved.
//

#import "JCiCloudTestViewController.h"

@interface JCiCloudTestViewController ()

@end

@implementation JCiCloudTestViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
