//
//  Quote.m
//  SkinnyViewControllers
//
//  Created by cstephan on 8/6/14.
//  Copyright (c) 2014 Wide Eye Labs. All rights reserved.
//

#import "Quote.h"
#import "AFHTTPRequestOperation.h"
#import "ApiClient.h"

#define BODY_KEY @"body"
#define AUTHOR_KEY @"author"

@interface Quote ()

+ (NSMutableArray *)parseQuotes:(NSArray *)quoteDictionaries;

@end

@implementation Quote

+ (void)getAllQuotes:(void (^)(AFHTTPRequestOperation *, NSMutableArray *))success andFailure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
  ApiClient *apiClient = [ApiClient sharedHTTPClient];
  
  [apiClient getQuotesWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSMutableArray *quotes = [self parseQuotes:[responseObject valueForKey:@"quotes"]];
    success(operation, quotes);
  } andFailure:failure];
}

+ (NSMutableArray *)parseQuotes:(NSArray *)quoteDictionaries
{
  NSMutableArray *quotes = [[NSMutableArray alloc] initWithCapacity:20];
  
  for (NSDictionary *quoteHash in quoteDictionaries) {
    [quotes addObject:[[Quote alloc] initWithBody:[quoteHash valueForKey:BODY_KEY]
                                        andAuthor:[quoteHash valueForKey:AUTHOR_KEY]]];
  }
  
  return quotes;
}

- (instancetype)initWithBody:(NSString *)body andAuthor:(NSString *)author
{
  self = [super init];
  if (self) {
    _body = body;
    _author = author;
  }
  
  return self;
}

@end
