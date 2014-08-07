//
//  UITableViewCell+ConfigureForQuote.h
//  SkinnyViewControllers
//
//  Created by cstephan on 8/7/14.
//  Copyright (c) 2014 Wide Eye Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Quote;

@interface UITableViewCell (ConfigureForQuote)

-(void)configureForQuote:(Quote *)quote;

@end
