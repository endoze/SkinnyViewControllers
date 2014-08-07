//
//  Quote.h
//  SkinnyViewControllers
//
//  Created by cstephan on 8/6/14.
//  Copyright (c) 2014 Wide Eye Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

@interface Quote : NSObject

+ (void)getAllQuotes:(void (^)(AFHTTPRequestOperation *operation, NSMutableArray *quotes))success andFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (instancetype)initWithBody:(NSString *)body andAuthor:(NSString *)author;

@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *author;

@end
