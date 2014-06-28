//
//  AppDelegate.m
//  moloso
//
//  Created by croath on 6/28/14.
//  Copyright (c) 2014 croath. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
#import "MobClick.h"
#import "GuideViewController.h"
#import "CurrentUser.h"
#import "PairViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initUmeng];
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    _window.tintColor = [UIColor whiteColor];
    
    if (![[CurrentUser user] isLogin]) {
        GuideViewController *guideVC = [[GuideViewController alloc] init];
        [guideVC setLoginDelegate:self];
        [_window setRootViewController:guideVC];
    } else {
        [self directLogin];
    }
    
    [_window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}

- (void)initUmeng{
    [MobClick startWithAppkey:@"53ae6c4a56240bb78e156761"];
    [UMSocialData setAppKey:@"53ae6c4a56240bb78e156761"];
}

- (void)userLoginOK{
    [self directLogin];
}

- (void)directLogin{
    PairViewController *pairVC = [[PairViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pairVC];
    nav.navigationBar.barStyle = UIBarStyleBlack;
    [nav.navigationBar setTranslucent:NO];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
    [_window setRootViewController:nav];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
