//
//  Sighting.h
//  Lost
//
//  Created by Yuval Segall on 12/1/15.
//  Copyright (c) 2015 yuvalsegall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Sighting : NSObject

@property (strong, nonatomic) PFUser *postingUser;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) PFGeoPoint *location;
@property (strong, nonatomic) NSString *postId;

@end