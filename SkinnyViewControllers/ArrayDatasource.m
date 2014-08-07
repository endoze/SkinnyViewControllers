//
//  ArrayDatasource.m
//  SkinnyViewControllers
//
//  Created by cstephan on 8/7/14.
//  Copyright (c) 2014 Wide Eye Labs. All rights reserved.
//

#import "ArrayDatasource.h"

@interface ArrayDataSource ()

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;

@end


@implementation ArrayDataSource

- (id)init
{
  return nil;
}

- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)cellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock
{
  self = [super init];
  if (self) {
    self.items = items;
    self.cellIdentifier = cellIdentifier;
    self.configureCellBlock = [configureCellBlock copy];
  }
  
  return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
  return self.items[(NSUInteger) indexPath.row];
}

- (NSInteger)itemCount
{
  return [self.items count];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                          forIndexPath:indexPath];
  
  id item = [self itemAtIndexPath:indexPath];
  self.configureCellBlock(cell, item);
  
  return cell;
}

@end
