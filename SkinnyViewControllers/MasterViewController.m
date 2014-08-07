//
//  MasterViewController.m
//  SkinnyViewControllers
//
//  Created by cstephan on 8/5/14.
//  Copyright (c) 2014 Wide Eye Labs. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "ApiClient.h"
#import "Quote.h"
#import "ArrayDatasource.h"
#import "UITableViewCell+ConfigureForQuote.h"

@interface MasterViewController ()

@property (nonatomic, strong) ArrayDataSource *quotesArrayDatasource;

- (void)getData;
- (void)selectFirstItemIfIpad;
- (void)setupTableViewDatasource;

@end

@implementation MasterViewController

- (void)awakeFromNib
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
  }
  [super awakeFromNib];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
  [self setupTableViewDatasource];
  [self getData];
}

- (void)getData
{
  [Quote getAllQuotes:^(AFHTTPRequestOperation *operation, NSMutableArray *quotes) {
    [self.quotesArrayDatasource setItems:quotes];
    [self reloadTable];
  } andFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"failed to retrieve quotes");
  }];
}

-(void)setupTableViewDatasource
{
  TableViewCellConfigureBlock configureCell = ^(UITableViewCell *cell, Quote *quote) {
    [cell configureForQuote: quote];
  };
  self.quotesArrayDatasource = [[ArrayDataSource alloc] initWithItems:@[]
                                                         cellIdentifier:@"Cell"
                                                     configureCellBlock:configureCell];
  self.tableView.dataSource = self.quotesArrayDatasource;
}

#pragma mark - Table View

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    Quote *quote = [self.quotesArrayDatasource itemAtIndexPath:indexPath];
    self.detailViewController.detailItem = quote;
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([[segue identifier] isEqualToString:@"showDetail"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Quote *quote = [self.quotesArrayDatasource itemAtIndexPath:indexPath];
    [[segue destinationViewController] setDetailItem:quote];
  }
}

- (void)reloadTable
{
  [self.tableView reloadData];
  [self selectFirstItemIfIpad];
}

- (void)selectFirstItemIfIpad
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad && [self dataSourceCount] > 0) {
    NSIndexPath *firstItemIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.detailViewController setDetailItem:[self.quotesArrayDatasource itemAtIndexPath:firstItemIndexPath]];
    [self.tableView selectRowAtIndexPath:firstItemIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
  }
}

- (NSInteger)dataSourceCount
{
  return [self.quotesArrayDatasource itemCount];
}

@end
