//
//  BaseTableViewController.h
//  Patrol
//
//  Created by Benjamin on 4/7/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "BaseUIViewController.h"

@interface BaseTableViewController : BaseUIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak)         IBOutlet        UITableView     *tableView;

@end
