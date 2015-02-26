//
//  PhotoPIckerViewController.h
//  Lost
//
//  Created by Yuval Segall on 23/11/14.
//  Copyright (c) 2014 yuvalsegall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoPIckerViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *imagerPicker;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)onChooseTap:(id)sender;
@end
