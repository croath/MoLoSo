//
//  Dating.m
//  moloso
//
//  Created by croath on 6/28/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import "Dating.h"

@implementation Dating

- (instancetype)initWithDictionary:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        NSDictionary *userDict = [dict objectForKey:@"user"];
        NSDictionary *datingDict = [dict objectForKey:@"dating"];
        if (![userDict isKindOfClass:[NSNull class]]) {
            User *user = [[User alloc] initWithOwnDictionary:userDict];
            _anotherUser = user;
        }
        
        _datingId = [NSString stringWithFormat:@"%d", [[datingDict objectForKey:@"id"] integerValue]];
        _acceptMale = [[datingDict objectForKey:@"accept_male"] boolValue];
        _acceptFemale = [[datingDict objectForKey:@"accept_female"] boolValue];
    }
    return self;
}

+ (instancetype)sample{
    Dating *dating = [[Dating alloc] init];
    User *user = [[User alloc] init];
    [user setAvatar:@"http://img3.douban.com/icon/up1000001-30.jpg"];
    [user setScreenName:@"阿北"];
    [user setBio:@"     现在多数时间在忙忙碌碌地为豆瓣添砖加瓦。坐在马桶上看书，算是一天中最放松的时间。\n\n我不但喜欢读书、旅行和音乐电影，还曾经是一个乐此不疲的实践者，有一墙碟、两墙书、三大洲的车船票为记。现在自己游荡差不多够了，开始懂得分享和回馈。豆瓣是一个开始，希望它对你同样有用。\n    \n(因为时间和数量的原因，豆邮和\"@阿北\"不能保证看到。有豆瓣的问题请email联系help@douban.com。)"];
    [user setUserId:@"1000001"];
    [user setGender:0];
    [dating setAnotherUser:user];
    [dating setAcceptMale:NO];
    [dating setAcceptFemale:NO];
    return dating;
}

@end
