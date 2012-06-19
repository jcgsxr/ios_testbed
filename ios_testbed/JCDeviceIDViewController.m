//
//  JCDeviceIDViewController.m
//  ios_testbed
//
//  Created by Johnny Chan on 6/18/12.
//  Copyright (c) 2012 Johnny Chan. All rights reserved.
//

#import "JCDeviceIDViewController.h"

@interface JCDeviceIDViewController ()

@end

@implementation JCDeviceIDViewController
@synthesize advertiserIDLabel;
@synthesize vendorIDLabel;

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
	
	[self refreshButtonAction:self];
}


- (IBAction)refreshButtonAction:(id)sender
{
	if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForAdvertising)])
	{
		NSString *advID = [[[UIDevice currentDevice] identifierForAdvertising] UUIDString];
		[advertiserIDLabel setText:advID];
		NSLog(@"Device Advertiser ID: %@", advID);
	}
	
	if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)])
	{
		NSString *vendorID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
		[vendorIDLabel setText:vendorID];
		NSLog(@"Device Vendor ID: %@", vendorID);
	}
}

- (IBAction)messageAction:(id)sender
{
	actionSheet = [[UIActionSheet alloc] initWithTitle:@"Send IDs"
											  delegate:self
									 cancelButtonTitle:@"Cancel"
								destructiveButtonTitle:nil
									 otherButtonTitles:@"Email", @"SMS", nil];
	
	[actionSheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
	[actionSheet showInView:[self view]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex)
	{
		case 0:
		{
			// Pop up email composer.
			//NSLog(@"Email");
			
			MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
			
			if (controller)
			{
				controller.mailComposeDelegate = self;
				//[controller setToRecipients:[NSArray arrayWithObject:@"user@gmail.com"]];
				[controller setSubject:@"Device IDs"];
				
				if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForAdvertising)] &&
					[[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)])
				{
					NSString *messageBody = [NSString stringWithFormat:@"Advertiser ID: %@ \n Vendor ID: %@",  [[[UIDevice currentDevice] identifierForAdvertising] UUIDString], [[[UIDevice currentDevice] identifierForVendor] UUIDString]];
					[controller setMessageBody:messageBody isHTML:NO];
				}

				[self presentViewController:controller animated:YES completion:nil];
			}
		}
			break;
			
		case 1:
		{
			// Pop up sms composer.
			//NSLog(@"SMS");
			
			MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
			if ([MFMessageComposeViewController canSendText] && controller)
			{
				if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForAdvertising)] &&
					[[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)])
				{
					NSString *messageBody = [NSString stringWithFormat:@"Advertiser ID: %@ \n Vendor ID: %@",  [[[UIDevice currentDevice] identifierForAdvertising] UUIDString], [[[UIDevice currentDevice] identifierForVendor] UUIDString]];
					[controller setBody:messageBody];
				}
				
				//controller.recipients = [NSArray arrayWithObjects:@"+919999999999", nil];
				controller.messageComposeDelegate = self;
				[self presentViewController:controller animated:YES completion:nil];
			}
		}
			break;
			
		default:
			break;
	}
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissModalViewControllerAnimated:YES];
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
