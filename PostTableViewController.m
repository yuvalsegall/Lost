//
//  PostTableViewController.m
//  Lost
//
//  Created by Yuval Segall on 7/1/15.
//  Copyright (c) 2015 yuvalsegall. All rights reserved.
//

#import "PostTableViewController.h"
#import <Parse/Parse.h>
#import "Post.h"
#import "ReadPostVC.h"
#import "EditPostVC.h"

#define NewPostSegueIdentifier @"NewPostSegue"
#define EditPostSegueIdentifier @"EditPostSegue"
#define ReadPostSegueIdentifier @"ReadPostSegue"

@interface PostTableViewController ()

@property (strong, nonatomic) NSMutableArray *posts;
@property (strong, nonatomic) LostEngine *engine;
@property (strong, nonatomic) UIColor *myColor;
@property (nonatomic) NSInteger RowClicked;

@end

@implementation PostTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setEngine];
    self.myColor = [UIColor colorWithRed:28/255.0 green:189/255.0 blue:201/255.0 alpha:1];
    self.navigationController.navigationBar.barTintColor = self.myColor;
}

- (void) viewDidAppear:(BOOL)animated{
    self.posts = [self.engine getPosts:self.tableView];
    [self.tableView reloadData];
}

- (void) viewDidDisappear:(BOOL)animated{
    [self.posts removeAllObjects];
}

- (IBAction)onRefresh:(id)sender {
    [self.tableView reloadData];
}

- (IBAction)OnPublish:(id)sender {
    [self performSegueWithIdentifier:NewPostSegueIdentifier sender:self];
}

- (IBAction)onLogOutTap:(id)sender {
    NSLog(@"Log out");
    [PFUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) setEngine{
    self.engine = [[LostEngine alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"numberOfRowsInSection= %lu", (unsigned long)[self.posts count]);
    return [self.posts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PostCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle	 reuseIdentifier:CellIdentifier];
    }
    Post *post = [self.posts objectAtIndex:indexPath.row];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    cell.textLabel.text = post.postObj[@"dogName"];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:post.postObj.createdAt];
    [cell.imageView setContentMode:UIViewContentModeScaleAspectFit];
    cell.imageView.image = post.image;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.RowClicked = indexPath.item;
    PFUser *currentUser = [PFUser currentUser];
    Post *post = [self.posts objectAtIndex:self.RowClicked];
    if ([currentUser.objectId isEqualToString:post.postObj[@"uploadingUserStringId"]]) {
        [self performSegueWithIdentifier:EditPostSegueIdentifier sender:self];
    }
    else{
        [self performSegueWithIdentifier:ReadPostSegueIdentifier sender:self];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:ReadPostSegueIdentifier]){
        ReadPostVC *readPostVC = segue.destinationViewController;
        readPostVC.post = [self.posts objectAtIndex:self.RowClicked];
        readPostVC.engine = self.engine;
    }
    else if([[segue identifier] isEqualToString:EditPostSegueIdentifier]){
        EditPostVC *editPostVC = segue.destinationViewController;
        editPostVC.post = [self.posts objectAtIndex:self.RowClicked];
        editPostVC.engine = self.engine;
    }
}

@end
