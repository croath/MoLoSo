//
//  User.h
//  quarter9
//
//  Created by croath on 5/29/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, assign) NSInteger gender;//1 for male, 2 for female

- (id)initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*)dict;
- (void)setPropertiesWithDict:(NSDictionary*)dict;

@end
