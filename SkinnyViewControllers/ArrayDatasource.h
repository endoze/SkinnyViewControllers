//
//  ArrayDatasource.h
//  SkinnyViewControllers
//
//  Created by cstephan on 8/7/14.
//  Copyright (c) 2014 Wide Eye Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@interface ArrayDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSArray *items;

-(id) initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)cellIdenfifier
 configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)itemCount;

@end
