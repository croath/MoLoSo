//
//  GuideViewController.h
//  quarter9
//
//  Created by croath on 5/29/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginDelegate.h"

@interface GuideViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) id<LoginDelegate> loginDelegate;
@end
