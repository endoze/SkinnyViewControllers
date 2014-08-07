//
//  ApiClient.h
//  SkinnyViewControllers
//
//  Created by cstephan on 8/5/14.
//  Copyright (c) 2014 Wide Eye Labs. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface ApiClient : AFHTTPRequestOperationManager

+ (instancetype)sharedHTTPClient;

- (void)getQuotesWithSuccess:(void(^)(AFHTTPRequestOperation *operation, id responseObject))success andFailure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
