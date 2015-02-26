//
//  LostEngine.h
//  Lost
//
//  Created by Yuval Segall on 12/1/15.
//  Copyright (c) 2015 yuvalsegall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LostEngine : NSObject

@property (strong, nonatomic) NSMutableArray *posts;

- (NSMutableArray*)getPosts:(UITableView*)table;

@end
