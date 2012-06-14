//
//  JCSocialTestViewController.m
//  ios_testbed
//
//  Created by Johnny Chan on 6/13/12.
//  Copyright (c) 2012 Johnny Chan. All rights reserved.
//

#import "JCSocialTestViewController.h"

@interface JCSocialTestViewController ()

@end

@implementation JCSocialTestViewController

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


- (IBAction)socialButtonAction:(id)sender
{
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        NSLog(@"Facebook Service not available");
    }
    
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        NSLog(@"Twitter Service not available");
    }
    
    SLComposeViewController *viewCtrl = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    if (viewCtrl)
    {
        [[self navigationController] pushViewController:viewCtrl animated:NO];
    }
}

@end
