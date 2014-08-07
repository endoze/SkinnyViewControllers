//
//  ApiClient.m
//  SkinnyViewControllers
//
//  Created by cstephan on 8/5/14.
//  Copyright (c) 2014 Wide Eye Labs. All rights reserved.
//

#import "ApiClient.h"

static NSString * const ApiBaseURLString = @"http://intense-gorge-7087.herokuapp.com";
@implementation ApiClient

+(instancetype)sharedHTTPClient
{
  static ApiClient *_sharedClient = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedClient = [[ApiClient alloc] initWithBaseURL:[NSURL URLWithString:ApiBaseURLString]];
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    _sharedClient.requestSerializer = requestSerializer;
  });
  
  return _sharedClient;
}

- (void)getQuotesWithSuccess:(void (^)(AFHTTPRequestOperation *, id))success andFailure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
  [self GET:@"quotes" parameters:nil success:success failure:failure];
}

@end
