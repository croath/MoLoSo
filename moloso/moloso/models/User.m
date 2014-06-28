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
        [self setPropertiesWithDict:dict];
    }
    return self;
}

- (id)initWithOwnDictionary:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        [self setPropertiesWithOwnDict:dict];
    }
    return self;
}

- (void)setPropertiesWithDict:(NSDictionary*)dict{
    _userId = [dict objectForKey:@"id"];
    _avatar = [dict objectForKey:@"large_avatar"];
    _screenName = [dict objectForKey:@"name"];
    _bio = [dict objectForKey:@"desc"];
}

- (void)setPropertiesWithOwnDict:(NSDictionary*)dict{
    _userId = [dict objectForKey:@"user_id"];
    _avatar = [dict objectForKey:@"avatar"];
    _screenName = [dict objectForKey:@"screen_name"];
    _bio = [dict objectForKey:@"bio"];
    _gender = [[dict objectForKey:@"gender"] integerValue];
}

- (NSDictionary*)dict{
    NSDictionary *dict = @{@"user_id": _userId,
                           @"screen_name": _screenName,
                           @"gender": @(_gender),
                           @"avatar": _avatar,
                           @"movie_count": @688,
                           @"music_count": @305,
                           @"book_count": @122,
                           @"bio": _bio};
    return dict;
}

- (NSString*)commanInterests{
    return @"张玮玮 送你一颗子弹 生活多美好\n\nx-japan 万有引力之虹 张悦然\n\n变形金刚4 知日 云上的日子";
}
@end
