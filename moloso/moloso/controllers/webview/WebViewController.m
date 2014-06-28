//
//  WebViewController.m
//  quarter9
//
//  Created by croath on 6/5/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController (){
    NSString *_urlStr;
    UIWebView *_webView;
}

@end

@implementation WebViewController

- (id)initWithUrlStr:(NSString*)url
{
    self = [super init];
    if (self) {
        // Custom initialization
        _urlStr = url;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [_webView setScalesPageToFit:YES];
    [self.view addSubview:_webView];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
