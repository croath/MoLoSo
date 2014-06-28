//
//  User.m
//  quarter9
//
//  Created by croath on 5/29/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import "User.h"


NSString *UserIdKey             = @"IdKey";
NSString *UserScreenNameKey     = @"ScreenNameKey";
NSString *UserAvatarKey         = @"AvatarKey";
NSString *UserBioKey            = @"BioKey";
NSString *UserGenderKey         = @"GenderKey";

@implementation User

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_userId forKey:UserIdKey];
    [aCoder encodeObject:_screenName forKey:UserScreenNameKey];
    [aCoder encodeObject:_avatar forKey:UserAvatarKey];
    [aCoder encodeObject:_bio forKey:UserBioKey];
    [aCoder encodeInteger:_gender forKey:UserGenderKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _userId = [aDecoder decodeObjectForKey:UserIdKey];
        _screenName = [aDecoder decodeObjectForKey:UserScreenNameKey];
        _avatar = [aDecoder decodeObjectForKey:UserAvatarKey];
        _bio = [aDecoder decodeObjectForKey:UserBioKey];
        _gender = [aDecoder decodeIntegerForKey:UserGenderKey];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        _userId = [dict objectForKey:@"id"];
        _avatar = [dict objectForKey:@"small_avatar"];
        _screenName = [dict objectForKey:@"screen_name"];
    }
    return self;
}
@end