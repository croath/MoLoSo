//
//  CurrentUser.h
//  quarter9
//
//  Created by croath on 5/29/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import "User.h"

@interface CurrentUser : User<NSCoding>

+ (instancetype)user;
- (BOOL)isLogin;

@end
