//
//  HelpViewController.m
//  Lost
//
//  Created by Yuval Segall on 11/15/14.
//  Copyright (c) 2014 yuvalsegall. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@property (strong, nonatomic) UITapGestureRecognizer *singleFingerTap;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIndicator.hidesWhenStopped = YES;
    self.sendButton.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.4];
    self.singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:self.singleFingerTap];
}

- (void) viewDidAppear:(BOOL)animated{
    self.emailTextField.text = self.textForEmailFieldFromPrevVC;
    
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    NSLog(@"got tap, closing keyboard");
    [self.view endEditing:YES];
}

- (IBAction)onSendTap:(id)sender{
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    NSString *emailTextFieldAsString = self.emailTextField.text;
    [PFUser requestPasswordResetForEmailInBackground:emailTextFieldAsString block:^(BOOL succeeded, NSError *error) {
        [self.activityIndicator stopAnimating];
        [self.activityIndicator setHidden:YES];
        if (succeeded) {
            [[[UIAlertView alloc] initWithTitle:@"אזכור סיסמה נשלח לדוא״ל" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            NSLog(@"going Back");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            [[[UIAlertView alloc] initWithTitle:@"שגיאה" message:error.localizedFailureReason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }];
}

- (IBAction)onBackTap:(id)sender {
    NSLog(@"going Back to login");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end