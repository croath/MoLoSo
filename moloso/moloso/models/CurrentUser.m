//
//  CurrentUser.m
//  quarter9
//
//  Created by croath on 5/29/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import "CurrentUser.h"
#import "UMSocial.h"

NSString *CurrentUserKey = @"CurrentUserKey";

@implementation CurrentUser

static CurrentUser *_sharedUser;

+ (instancetype)user{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedUser = [self.class readFromUserDefault];
        if (_sharedUser == nil) {
            _sharedUser = [[CurrentUser alloc] init];
            [_sharedUser save];
        }
    });
    return _sharedUser;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (BOOL)isLogin{
    return [UMSocialAccountManager isOauthAndTokenNotExpired:UMShareToDouban];
}

- (void)save{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:CurrentUserKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (instancetype)readFromUserDefault{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:CurrentUserKey];
    if (data == nil) {
        return nil;
    }
    CurrentUser *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return user;
}

- (void)setBio:(NSString *)bio{
    [super setBio:bio];
    [self save];
}

- (void)setGender:(NSInteger)gender{
    [super setGender:gender];
    [self save];
}

- (void)setUserId:(NSString*)userId{
    [super setUserId:userId];
    [self save];
}

- (void)setScreenName:(NSString *)screenName{
    [super setScreenName:screenName];
    [self save];
}

- (void)setAvatar:(NSString *)avatar{
    [super setAvatar:avatar];
    [self save];
}

@end
