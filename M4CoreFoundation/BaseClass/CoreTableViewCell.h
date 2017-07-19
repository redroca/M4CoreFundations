//
//  CoreTableViewCell.h
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import <UIKit/UIKit.h>

// --- Core TableViewCell class root --- //
@interface CoreTableViewCell : UITableViewCell

// Localization methods
@property (nonatomic, strong)       NSString        *localizationItemName;
- (NSString *)stringWithKey:(NSString *)key;

// Setup something
- (void)setup;

+ (__kindof UITableViewCell *)reusableCellDequeueTableView:(UITableView *)tableView;

+ (NSString *)cellReuseIdentifier;

@end


// --- Core Xib file TableViewCell class --- //
IB_DESIGNABLE
@interface CoreXibTableViewCell : CoreTableViewCell

+ (__kindof UITableViewCell *)reusableCellDequeueTableView:(UITableView *)tableView;

@end
