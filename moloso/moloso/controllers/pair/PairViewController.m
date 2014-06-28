//
//  PairViewController.m
//  moloso
//
//  Created by croath on 6/28/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import "PairViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PairViewController ()

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
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    // Do any additional setup after loading the view from its nib.
    [self initViews];
}

- (void)initViews{
    [_avatarView.layer setCornerRadius:50.f];
    [_avatarView.layer setMasksToBounds:YES];
    [_avatarView.layer setBorderColor:GREEN_COLOR.CGColor];
    [_avatarView.layer setBorderWidth:3.f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
