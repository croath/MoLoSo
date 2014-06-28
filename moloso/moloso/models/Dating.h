//
//  Dating.h
//  moloso
//
//  Created by croath on 6/28/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Dating : NSObject

@property (nonatomic, strong) NSString *datingId;
@property (nonatomic, strong) User *anotherUser;
@property (nonatomic, assign) BOOL acceptMale;
@property (nonatomic, assign) BOOL acceptFemale;

+ (instancetype)sample;

@end
