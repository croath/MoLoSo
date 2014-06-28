//
//  NSString+MD5.h
//  moloso
//
//  Created by croath on 6/28/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)

- (NSString *) MD5Hash;

@end
