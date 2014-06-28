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

@interface GuideViewController (){
    BOOL _scorllTo3rd;
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
}

- (void)initViews{
    [_loginButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.f
                                                                             green:120.f/255.f
                                                                              blue:0.f
                                                                             alpha:1.f]
                                                        size:CGSizeMake(1, 1)]
                            forState:UIControlStateNormal];
    [_loginButton.layer setMasksToBounds:YES];
    [_loginButton.layer setCornerRadius:5.f];
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
