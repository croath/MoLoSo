//
//  PairViewController.m
//  moloso
//
//  Created by croath on 6/28/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import "PairViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "User.h"
#import "WebViewController.h"

@interface PairViewController (){
    User *_user;
}

@end

@implementation PairViewController

- (id)init
{
    self = [super initWithNibName:@"PairViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initViews];
    [self toWebView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)initViews{
    [_avatarView.layer setCornerRadius:50.f];
    [_avatarView.layer setMasksToBounds:YES];
    [_avatarView.layer setBorderColor:GREEN_COLOR.CGColor];
    [_avatarView.layer setBorderWidth:3.f];
}

- (void)toWebView{
//    NSString *urlStr = [NSString stringWithFormat:@"http://www.douban.com/people/%@/", _user.userId];
        NSString *urlStr = [NSString stringWithFormat:@"http://www.douban.com/people/%@/", @"catsoup"];
    WebViewController *webVC = [[WebViewController alloc] initWithUrlStr:urlStr];
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
