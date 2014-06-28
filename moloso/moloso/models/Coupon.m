//
//  Coupon.m
//  moloso
//
//  Created by croath on 6/28/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import "Coupon.h"
#import "NSString+MD5.h"

@implementation Coupon

- (BOOL)verifyOtherCode:(NSString*)otherCode{
    NSString *newStr = @"";
    if (_type == CouponCodeTypeHead) {
        newStr = [newStr stringByAppendingFormat:@"%@%@", _code, otherCode];
    } else {
        newStr = [newStr stringByAppendingFormat:@"%@%@", otherCode, _code];
    }
    
    return [_fullCodeMd5 isEqualToString:[newStr MD5Hash]];
}

@end
