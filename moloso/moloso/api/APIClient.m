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

- (void)getMarksArrayWithUserId:(NSString*)userId
                        succeed:(getArraySucceed)succeed
                         failed:(failed)failed{
    [_tManager GET:[NSString stringWithFormat:@"/duser/%@/marks.json", userId]
        parameters:nil
           success:^(NSURLSessionDataTask *task, id responseObject) {
               if (succeed) {
                   succeed([responseObject objectForKey:@"marks"]);
               }
           } failure:^(NSURLSessionDataTask *task, NSError *error) {
               if (failed) {
                   failed(error);
               }
           }];
}

- (void)getBangssArrayWithUserId:(NSString*)userId
                         succeed:(getArraySucceed)succeed
                          failed:(failed)failed{
    [_tManager GET:[NSString stringWithFormat:@"/duser/%@/bangs.json", userId]
        parameters:nil
           success:^(NSURLSessionDataTask *task, id responseObject) {
               if (succeed) {
                   succeed([responseObject objectForKey:@"bangs"]);
               }
           } failure:^(NSURLSessionDataTask *task, NSError *error) {
               if (failed) {
                   failed(error);
               }
           }];
}

- (void)updateMarksArrayWithUserId:(NSString*)userId
                             marks:(NSArray*)marks
                           succeed:(getArraySucceed)succeed
                            failed:(failed)failed{
    NSString *marksString = [marks componentsJoinedByString:@","];
    [_tManager POST:[NSString stringWithFormat:@"/duser/%@/marks.json", userId] parameters:@{@"marks": marksString} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if (succeed) {
            succeed([responseObject objectForKey:@"bangs"]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}

//- (void)getUserFollowingsWithUserId:(NSString*)userId
//                                max:(NSInteger)max
//                            succeed:(getArraySucceed)succeed{
//    dispatch_queue_t queue = dispatch_queue_create("com.croath.quarter9.apiq0", 0);
//    
//    dispatch_async(queue, ^{
//        dispatch_group_t group = dispatch_group_create();
//        NSMutableArray *followings = [NSMutableArray array];
//        for (int i = 0; i < max; i += 200) {
//            dispatch_group_enter(group);
//            [self getUserFollowingsWithUserId:userId start:i succeed:^(NSArray *array) {
//                NSMutableArray *oneFollowings = [NSMutableArray array];
//                [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                    if ([obj isKindOfClass:[NSDictionary class]]) {
//                        User *user = [[User alloc] initWithDictionary:obj];
//                        [oneFollowings addObject:user];
//                    }
//                }];
//                [followings addObjectsFromArray:oneFollowings];
//                dispatch_group_leave(group);
//            } failed:^(NSError *error) {
//                dispatch_group_leave(group);
//            }];
//        }
//        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//        if (succeed) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                succeed(followings);
//            });
//        }
//    });
//}

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
