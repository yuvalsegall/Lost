//
//  HelpViewController.h
//  Lost
//
//  Created by Yuval Segall on 11/15/14.
//  Copyright (c) 2014 yuvalsegall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface HelpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) NSString *textForEmailFieldFromPrevVC;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;

- (IBAction)onBackTap:(id)sender;
- (IBAction)onSendTap:(id)sender;

@end
