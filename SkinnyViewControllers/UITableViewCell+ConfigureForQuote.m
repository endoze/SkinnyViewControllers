//
//  UITableViewCell+ConfigureForQuote.m
//  SkinnyViewControllers
//
//  Created by cstephan on 8/7/14.
//  Copyright (c) 2014 Wide Eye Labs. All rights reserved.
//

#import "UITableViewCell+ConfigureForQuote.h"
#import "Quote.h"

@implementation UITableViewCell (ConfigureForQuote)

-(void)configureForQuote:(Quote *)quote
{
  self.textLabel.text = [quote author];
}

@end
