//
//  MasterViewController.h
//  SkinnyViewControllers
//
//  Created by cstephan on 8/5/14.
//  Copyright (c) 2014 Wide Eye Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
