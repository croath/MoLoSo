//
//  APIClient.h
//  quarter9
//
//  Created by croath on 5/29/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentUser.h"
#import "Dating.h"

typedef void (^getArraySucceed) (NSArray *array);
typedef void (^failed) (NSError *error);
typedef void (^postUserSucceed) ();
typedef void (^getUserSucceed) (User *user);
typedef void (^getCurrentUserSucceed) (CurrentUser *user);
typedef void (^getDatingSucceed) (Dating *dating);

@interface APIClient : NSObject

+ (instancetype)sharedClient;

- (void)getUserInfoWithUserId:(NSString*)userId
                      succeed:(getCurrentUserSucceed)succeed
                       failed:(failed)failed;

- (void)fetchcurrentDatingStatusSucceed:(getDatingSucceed)succeed
                                 failed:(failed)failed;

- (void)agreeDatingWithDatingId:(NSString*)datingId
                        succeed:(getDatingSucceed)succeed
                         failed:(failed)failed;

- (void)postUserWithUser:(User*)user
                 succeed:(postUserSucceed)succeed
                  failed:(failed)failed;
@end
