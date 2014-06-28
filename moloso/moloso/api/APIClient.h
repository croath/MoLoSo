//
//  APIClient.h
//  quarter9
//
//  Created by croath on 5/29/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "CurrentUser.h"
typedef void (^getArraySucceed) (NSArray *array);
typedef void (^failed) (NSError *error);
typedef void (^postUserSucceed) ();
typedef void (^getUserSucceed) (User *user);
typedef void (^getCurrentUserSucceed) (CurrentUser *user);

@interface APIClient : NSObject

+ (instancetype)sharedClient;

- (void)getUserInfoWithUserId:(NSString*)userId
                      succeed:(getCurrentUserSucceed)succeed
                       failed:(failed)failed;
@end
