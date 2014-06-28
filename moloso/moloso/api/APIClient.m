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
        _tManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:LOSOMO_API_BASE]];
        _dManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:DOUBAN_API_BASE]];
    }
    return self;
}

- (void)postUserWithUser:(User*)user
                 succeed:(postUserSucceed)succeed
                  failed:(failed)failed{
    [_tManager POST:@"/users" parameters:[user dict] success:^(NSURLSessionDataTask *task, id responseObject) {
        if (succeed) {
            succeed();
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}

- (void)getDatingStatusWithDatingId:(NSString*)datingId
                            succeed:(getDatingSucceed)succeed
                             failed:(failed)failed{
    Dating *dating = [[Dating alloc] init];
    [dating setAntherUser:[CurrentUser user]];
    if (succeed) {
        succeed(dating);
    }
//    [_tManager GET:[NSString stringWithFormat:@"/duser/%@/marks.json", datingId]
//        parameters:nil
//           success:^(NSURLSessionDataTask *task, id responseObject) {
//               if (succeed) {
//                   succeed([responseObject objectForKey:@"marks"]);
//               }
//           } failure:^(NSURLSessionDataTask *task, NSError *error) {
//               if (failed) {
//                   failed(error);
//               }
//           }];
}

- (void)fetchcurrentDatingStatusSucceed:(getDatingSucceed)succeed
                                 failed:(failed)failed{
    Dating *dating = [[Dating alloc] init];
    [dating setAntherUser:[CurrentUser user]];
    if (succeed) {
        succeed(dating);
    }
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
