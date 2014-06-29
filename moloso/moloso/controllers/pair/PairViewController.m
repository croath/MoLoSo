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
#import "FBShimmeringView.h"
#import "APIClient.h"
#import "Dating.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SVProgressHUD.h"
#import "SessionsViewController.h"
#import "ScanViewController.h"
#import "POP.h"

@interface PairViewController (){
    Dating *_dating;
    FBShimmeringView *_shimmeringView;
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
    [self loadRequest];
}

- (void)loadRequest{
    [_mainView setHidden:YES];
    if (_shimmeringView == nil) {
        _shimmeringView = [[FBShimmeringView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_shimmeringView];
    }
    
    _shimmeringView.contentView = _loadingView;
    _shimmeringView.shimmering = YES;
    
    [[APIClient sharedClient] fetchcurrentDatingStatusSucceed:^(Dating *dating) {
        _dating = dating;
        [self judgeAcceptStatus];
        if (_dating.anotherUser != nil) {
            [self renderingViews];
            [_mainView setAlpha:0.0f];
            [_mainView setHidden:NO];
            [UIView animateWithDuration:2.0
                             animations:^{
                                 [_mainView setAlpha:1.f];
                                 [_loadingView setAlpha:0.f];
                             } completion:^(BOOL finished) {
                                 if (finished) {
                                     [_loadingView setHidden:YES];
                                     _shimmeringView.shimmering = NO;
                                     [_shimmeringView removeFromSuperview];
                                 }
                             }];
        } else {
            [SVProgressHUD showErrorWithStatus:@"目前尚没有配对"];
        }
    } failed:^(NSError *error) {
        
    }];
}

- (void)renderingViews{
    /*
     @property (weak, nonatomic) IBOutlet UIImageView *avatarView;
     @property (weak, nonatomic) IBOutlet UIView *mainView;
     @property (weak, nonatomic) IBOutlet UIView *loadingView;
     @property (weak, nonatomic) IBOutlet UIImageView *genderImage;
     @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
     @property (weak, nonatomic) IBOutlet UILabel *bioLabel;
     @property (weak, nonatomic) IBOutlet UILabel *commonLabel;
     @property (weak, nonatomic) IBOutlet UIButton *agreeLabel;
     @property (weak, nonatomic) IBOutlet UIImageView *cardView;
     */
    [_avatarView setImageWithURL:[NSURL URLWithString:_dating.anotherUser.avatar] placeholderImage:nil];
    [_genderImage setImage:[UIImage imageNamed:_dating.anotherUser.gender == 1 ? @"male" : @"female"]];
    [_nameLabel setText:_dating.anotherUser.screenName];
    [_bioLabel setText:_dating.anotherUser.bio];
    [_agreeLabel setBackgroundImage:[UIImage imageNamed:_dating.anotherUser.gender == 1 ? @"blue_btn" : @"pink_btn"] forState:UIControlStateNormal];
    [_agreeLabel setTitle:(_dating.anotherUser.gender == 1 ? @"想见他" : @"想见她") forState:UIControlStateNormal];
    [_commonLabel setText:_dating.anotherUser.commanInterests];
    [_rightButton setTitle:(_dating.anotherUser.gender == 1 ? @"与他对话" : @"与她对话") forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)initViews{
    [_resultView setHidden:YES];
    [_avatarView.layer setCornerRadius:50.f];
    [_avatarView.layer setMasksToBounds:YES];
    [_avatarView.layer setBorderColor:MAIN_PINK_COLOR.CGColor];
    [_avatarView.layer setBorderWidth:1.f];
    
    [_fakeView.layer setCornerRadius:50.f];
    [_fakeView.layer setMasksToBounds:YES];
    
    [_cardView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toWebView)];
    [_cardView addGestureRecognizer:rec];
    
    [_popupView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *popr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removePop)];
    [_popupView addGestureRecognizer:popr];
    
    [_leftButton.layer setCornerRadius:17.f];
    [_leftButton.layer setMasksToBounds:YES];
    
    [_rightButton.layer setCornerRadius:17.f];
    [_rightButton.layer setMasksToBounds:YES];
    
}

- (void)toWebView{
    NSString *urlStr = [NSString stringWithFormat:@"http://www.douban.com/people/%@/", _dating.anotherUser.userId];
//        NSString *urlStr = [NSString stringWithFormat:@"http://www.douban.com/people/%@/", @"catsoup"];
    WebViewController *webVC = [[WebViewController alloc] initWithUrlStr:urlStr];
    [self.navigationController pushViewController:webVC animated:YES];
}
- (IBAction)agreePressed:(id)sender {
    if ([self judgeAcceptStatus]) {
        
        return;
    }
    [[APIClient sharedClient] agreeDatingWithDatingId:_dating.datingId succeed:^(Dating *dating) {
        _dating = dating;
        
        BOOL allAccept = [self judgeAcceptStatus];
        if (allAccept) {
            [self.view addSubview:_popupView];
        }
        
    } failed:^(NSError *error) {
        
    }];
}

- (BOOL)judgeAcceptStatus{
    BOOL iAccept = ([CurrentUser user].gender == 1 && _dating.acceptMale) ||
    ([CurrentUser user].gender == 0 && _dating.acceptFemale);
    BOOL anotherAccept = ([CurrentUser user].gender == 1 && _dating.acceptFemale) ||
    ([CurrentUser user].gender == 0 && _dating.acceptMale);
    
    if (!iAccept) {
        return NO;
    } else if (iAccept && !anotherAccept) {
        [_agreeLabel setEnabled:NO];
        return NO;
    } else if (iAccept && anotherAccept) {
        [_agreeLabel setHidden:YES];
        [_resultView setHidden:NO];
        return YES;
    } else {
        return NO;
    }
}

- (void)removePop{
    [_popupView removeFromSuperview];
}

- (IBAction)showReward:(id)sender {
    ScanViewController *scan = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:scan animated:YES];
}

- (IBAction)showSession:(id)sender {
    SessionsViewController *session = [[SessionsViewController alloc] init];
    [self.navigationController pushViewController:session animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
