//
//  GuideViewController.m
//  quarter9
//
//  Created by croath on 5/29/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import "GuideViewController.h"
#import "UIImage+Color.h"
#import "UMSocial.h"
#import "PSAlertView.h"
#import "CurrentUser.h"
#import "APIClient.h"
#import "FBShimmeringView.h"

@interface GuideViewController (){
    BOOL _scorllTo3rd;
    FBShimmeringView *_shimmeringView;
}

@end

@implementation GuideViewController

- (id)init
{
    self = [super initWithNibName:@"GuideViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initViews];
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5
                              delay:1.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [_leftView setCenter:CGPointMake(_leftView.center.x + 195, _leftView.center.y)];
                             [_rightView setCenter:CGPointMake(_rightView.center.x - 197, _rightView.center.y)];
                         } completion:^(BOOL finished) {
                             
                         }];
    });
}

- (void)initViews{
    
    if (_shimmeringView == nil) {
        _shimmeringView = [[FBShimmeringView alloc] initWithFrame:_loginButton.frame];
        [self.view addSubview:_shimmeringView];
    }
    
    _shimmeringView.contentView = _loginButton;
    _shimmeringView.shimmering = YES;
    
    [_loginButton addTarget:self action:@selector(loginPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginPressed{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToDouban];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSDictionary *douban = [response.data objectForKey:@"douban"] ;
            [[APIClient sharedClient] getUserInfoWithUserId:[douban objectForKey:@"usid"] succeed:^(CurrentUser *user) {
                PSAlertView *alert = [PSAlertView alertWithTitle:@"请选择性别"];
                [alert addButtonWithTitle:@"男" block:^{
                    [user setGender:1];
                    [self callDelegateSuccess];
                }];
                [alert addButtonWithTitle:@"女" block:^{
                    [user setGender:0];
                    [self callDelegateSuccess];
                }];
                [alert show];
            } failed:^(NSError *error) {
                
            }];
        } else {
            PSAlertView *alert = [PSAlertView alertWithTitle:@"登录失败" message:response.message];
            [alert addButtonWithTitle:@"好的" block:nil];
            [alert show];
        }
    });
}

- (void)callDelegateSuccess{
    [[APIClient sharedClient] postUserWithUser:[CurrentUser user] succeed:^{
        if (_loginDelegate != nil && [_loginDelegate respondsToSelector:@selector(userLoginOK)]) {
            [_loginDelegate performSelector:@selector(userLoginOK) withObject:nil];
        }
    } failed:^(NSError *error) {
        
    }];
}

@end
