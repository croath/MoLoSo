//
//  AppDelegate.h
//  moloso
//
//  Created by croath on 6/28/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, LoginDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
