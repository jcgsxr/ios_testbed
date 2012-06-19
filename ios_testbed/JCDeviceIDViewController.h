//
//  JCDeviceIDViewController.h
//  ios_testbed
//
//  Created by Johnny Chan on 6/18/12.
//  Copyright (c) 2012 Johnny Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface JCDeviceIDViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>
{
	UIActionSheet *actionSheet;
}

@property (weak, nonatomic) IBOutlet UILabel *advertiserIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *vendorIDLabel;

@end
