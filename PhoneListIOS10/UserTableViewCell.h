//
//  UserTableViewCell.h
//  PhoneListIOS10
//
//  Created by iMac on 03.03.17.
//  Copyright © 2017 hata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end
