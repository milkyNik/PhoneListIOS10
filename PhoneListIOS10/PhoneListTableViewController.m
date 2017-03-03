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
#import "AddUserTableViewController.h"
#import "UserTableViewCell.h"

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

- (void)viewWillAppear:(BOOL)animated {
    
    [self reloadTableView];
    
}

#pragma mark - Support

- (void) reloadTableView {
    
    self.users = [[MNDataManager sharedManager] allObjects];
    [self.tableView reloadData];
    
}

#pragma mark - Actions

- (void) actionAddUser:(UIBarButtonItem*) item {
    
    AddUserTableViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddUserTableViewController"];
    
    [self.navigationController pushViewController:vc
                                         animated:YES];
    
}

- (void) actionRemoveAllUsers:(UIBarButtonItem*) item {
    
    if ([self.users count]) {
        
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning!"
                                                                       message:@"Delete all users?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"Delete all!"
                                                               style:UIAlertActionStyleDestructive
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 [[MNDataManager sharedManager] deleteAllObjects];
                                                                 [self reloadTableView];
                                                             }];
        
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel!"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        [alert addAction:cancelAction];
        [alert addAction:deleteAction];
        
        [self presentViewController:alert
                           animated:YES
                         completion:nil];
        
    }

    
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.users count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"UserTableViewCell";
    
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[UserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:identifier];
        
    }
    
    MNUser* user = self.users[indexPath.row];
    
    cell.firstNameLabel.text = user.firstName;
    cell.lastNameLabel.text = user.lastName;
    cell.emailLabel.text = user.email;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MNUser* user = self.users[indexPath.row];

    [[[[MNDataManager sharedManager] persistentContainer] viewContext] deleteObject:user];
    [[MNDataManager sharedManager] saveContext];
    
    self.users = [[MNDataManager sharedManager] allObjects];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
}
@end
