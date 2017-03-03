//
//  PhoneListTableViewController.m
//  PhoneListIOS10
//
//  Created by iMac on 03.03.17.
//  Copyright © 2017 hata. All rights reserved.
//

#import "PhoneListTableViewController.h"
#import <CoreData/CoreData.h>
#import "MNUser+CoreDataClass.h"
#import "MNDataManager.h"

@interface PhoneListTableViewController ()

@property (strong, nonatomic) NSArray <MNUser*> * users;

@end

@implementation PhoneListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.users = [[MNDataManager sharedManager] allObjects];
    
    UIBarButtonItem* addUser = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(actionAddUser:)];
    
    UIBarButtonItem* removeAllUsers = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                                    target:self
                                                                                    action:@selector(actionRemoveAllUsers:)];
    
    [self.navigationItem setRightBarButtonItem:addUser];
    [self.navigationItem setLeftBarButtonItem:removeAllUsers];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void) actionAddUser:(UIBarButtonItem*) item {
    
    NSLog(@"OK!");
    
}

- (void) actionRemoveAllUsers:(UIBarButtonItem*) item {
    
    NSLog(@"Remove!");
    
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.users count];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end