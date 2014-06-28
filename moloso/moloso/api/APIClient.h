//
//  APIClient.h
//  quarter9
//
//  Created by croath on 5/29/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^getArraySucceed) (NSArray *array);
typedef void (^failed) (NSError *error);

@interface APIClient : NSObject

+ (instancetype)sharedClient;

- (void)getUserFollowingsWithUserId:(NSString*)userId
                                max:(NSInteger)max
                            succeed:(getArraySucceed)succeed;

- (void)getMarksArrayWithUserId:(NSString*)userId
                        succeed:(getArraySucceed)succeed
                         failed:(failed)failed;

- (void)getBangssArrayWithUserId:(NSString*)userId
                         succeed:(getArraySucceed)succeed
                          failed:(failed)failed;

- (void)updateMarksArrayWithUserId:(NSString*)userId
                             marks:(NSArray*)marks
                           succeed:(getArraySucceed)succeed
                            failed:(failed)failed;
@end
