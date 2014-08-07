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

@interface MasterViewController () {
  NSMutableArray *_objects;
}
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
  
  [[ApiClient sharedHTTPClient] getQuotesWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    _objects = [responseObject valueForKeyPath:@"quotes"];
    
    [self.tableView reloadData];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad && [_objects count] > 0) {
      [self.detailViewController setDetailItem:[_objects objectAtIndex:0]];
      [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
  } andFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"failed to retrieve quotes");
  }];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (void)insertNewObject:(id)object
{
  if (!_objects) {
    _objects = [[NSMutableArray alloc] init];
  }
  NSInteger indexForInsert = [_objects count];
  [_objects insertObject:object atIndex:indexForInsert];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexForInsert inSection:0];
  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  
  NSDictionary *object = _objects[indexPath.row];
  cell.textLabel.text = [object valueForKey:@"author"];
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    NSDictionary *object = _objects[indexPath.row];
    self.detailViewController.detailItem = object;
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([[segue identifier] isEqualToString:@"showDetail"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *object = _objects[indexPath.row];
    [[segue destinationViewController] setDetailItem:object];
  }
}

@end
