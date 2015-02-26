//
//  WelcomeViewController.m
//  Lost
//
//  Created by Yuval Segall on 11/12/14.
//  Copyright (c) 2014 yuvalsegall. All rights reserved.
//
#import "WelcomeViewController.h"
#define welcomeToHomeSegueIdentifier @"welcomeToHomeSegue"


@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"start goToHomeSegue Segue");
    [self performSegueWithIdentifier:welcomeToHomeSegueIdentifier sender:self];
}

@end
