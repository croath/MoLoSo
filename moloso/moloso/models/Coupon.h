//
//  Coupon.h
//  moloso
//
//  Created by croath on 6/28/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CouponCodeType){
    CouponCodeTypeHead,
    CouponCodeTypeTail
};

@interface Coupon : NSObject

@property (nonatomic, strong) NSString* couponId;
@property (nonatomic, strong) NSString* logo;
@property (nonatomic, strong) NSString* description;
@property (nonatomic, assign) CouponCodeType type;
@property (nonatomic, strong) NSString* code;
@property (nonatomic, strong) NSString* fullCodeMd5;

@end
