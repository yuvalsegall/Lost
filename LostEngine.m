//
//  LostEngine.m
//  Lost
//
//  Created by Yuval Segall on 12/1/15.
//  Copyright (c) 2015 yuvalsegall. All rights reserved.
//

#import "LostEngine.h"
#import <Parse/Parse.h>
#import "Post.h"

@interface LostEngine ()

@end

@implementation LostEngine

- (NSMutableArray*)getPosts: (UITableView*)table{
    if (self.posts == nil) {
        self.posts = [[NSMutableArray alloc] init];
    }
    [self getPostsFromParse:table];
    
    return self.posts;
}

- (void)getPostsFromParse: (UITableView*)table{
    NSLog(@"Parse Query - fetch posts");
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = 20;
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"found" notEqualTo:[NSNumber numberWithBool:YES]];
    [query whereKey:@"remove" notEqualTo:[NSNumber numberWithBool:YES]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %lu posts.", (unsigned long)objects.count);
            for (PFObject *object in objects) {
                Post *current = [[Post alloc] init];
                current.postObj = object;
                PFFile *img = object[@"imageFile"];
                [img getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                    if (!error) {
                        current.image = [UIImage imageWithData:imageData];
                        NSLog(@"finished downloading photo");
                        [table reloadData];
                    }
                }];
                [self.posts addObject:current];
            }
            [table reloadData];
        }
        else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end