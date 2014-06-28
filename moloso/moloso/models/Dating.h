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

@property (nonatomic, strong) User *antherUser;
@property (nonatomic, assign) BOOL acceptByYou;
@property (nonatomic, assign) BOOL acceptByAnother;

@end
