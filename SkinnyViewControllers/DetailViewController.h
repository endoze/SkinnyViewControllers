//
//  DetailViewController.h
//  SkinnyViewControllers
//
//  Created by cstephan on 8/6/14.
//  Copyright (c) 2014 Wide Eye Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
