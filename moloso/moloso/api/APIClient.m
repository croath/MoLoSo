//
//  APIClient.m
//  quarter9
//
//  Created by croath on 5/29/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import "APIClient.h"
#import "AFNetworking.h"
#import "User.h"

#define DOUBAN_API_BASE @"https://api.douban.com"
#define LOSOMO_API_BASE @"http://losomo.kenrick.cn:3333"
//#define TOKYO3_API_BASE @"http://127.0.0.1:3000"

@interface APIClient(){
    AFHTTPSessionManager *_dManager;
    AFHTTPSessionManager *_tManager;
}

@end

@implementation APIClient


static APIClient *__client;

+ (instancetype)sharedClient{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __client = [[APIClient alloc] init];
    });
    return __client;
}

- (id)init{
    self = [super init];
    if (self) {
//        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//        configuration.HTTPAdditionalHeaders = @{@"Content-Type": @"application/json"};
        
        _tManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:LOSOMO_API_BASE]];
        AFJSONRequestSerializer *rs = [AFJSONRequestSerializer serializer];
        [_tManager setRequestSerializer:rs];
        [_tManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
        _dManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:DOUBAN_API_BASE]];
    }
    return self;
}

- (void)postUserWithUser:(User*)user
                 succeed:(postUserSucceed)succeed
                  failed:(failed)failed{
    [_tManager POST:@"/users.json" parameters:[user dict] success:^(NSURLSessionDataTask *task, id responseObject) {
        if (succeed) {
            succeed();
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}

- (void)fetchcurrentDatingStatusSucceed:(getDatingSucceed)succeed
                                 failed:(failed)failed{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if ([CurrentUser user].gender == 1) {
        [dict setObject:[CurrentUser user].userId forKey:@"user_male"];
    } else {
        [dict setObject:[CurrentUser user].userId forKey:@"user_female"];
    }
    
    [_tManager POST:@"/datings.json" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if (succeed) {
            Dating *dating = [[Dating alloc] initWithDictionary:responseObject];
            succeed(dating);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}

- (void)agreeDatingWithDatingId:(NSString*)datingId
                        succeed:(getDatingSucceed)succeed
                         failed:(failed)failed{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:datingId forKey:@"id"];
    if ([CurrentUser user].gender == 1) {
        [dict setObject:[CurrentUser user].userId forKey:@"user_male"];
    } else {
        [dict setObject:[CurrentUser user].userId forKey:@"user_female"];
    }
    
    [_tManager POST:@"/datings/accept.json" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if (succeed) {
            Dating *dating = [[Dating alloc] initWithDictionary:responseObject];
            succeed(dating);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}

- (void)getUserInfoWithUserId:(NSString*)userId
                            succeed:(getCurrentUserSucceed)succeed
                             failed:(failed)failed{
    [_dManager GET:[NSString stringWithFormat:@"/v2/user/%@", userId]
        parameters:nil
           success:^(NSURLSessionDataTask *task, id responseObject) {
               if (succeed) {
                   CurrentUser *user = [CurrentUser user];
                   [user setPropertiesWithDict:responseObject];
                   succeed(user);
               }
           } failure:^(NSURLSessionDataTask *task, NSError *error) {
               if (failed) {
                   failed(error);
               }
           }];
}

@end
