//
//  SceneDelegate.m
//  App
//
//  Created by 朱双泉 on 2021/1/8.
//

#import "SceneDelegate.h"
#import "SQNewsViewController.h"
#import "SQVideoViewController.h"
#import "SQRecommendViewController.h"
#import "SQSplashView.h"
#import "GTMineViewController.h"

@interface SceneDelegate ()<UITabBarControllerDelegate>

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    
    SQNewsViewController *newsViewController = [[SQNewsViewController alloc] init];
    
    newsViewController.tabBarItem.title = @"新闻";
    newsViewController.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x.png"];
    newsViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/page_selected@2x.png"];
    
    SQVideoViewController *videoController = [[SQVideoViewController alloc] init];
    
    SQRecommendViewController *recommendController = [[SQRecommendViewController alloc] init];
    
    GTMineViewController *mineViewController = [[GTMineViewController alloc] init];
    
    [tabbarController setViewControllers:@[newsViewController, videoController, recommendController, mineViewController]];
    
    tabbarController.delegate = self;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabbarController];
    
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    [self.window addSubview:({
        SQSplashView *splashView = [[SQSplashView alloc] initWithFrame:self.window.bounds];
        splashView;
    })];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"did select");
    [self _changeIcon];
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}

#pragma mark -

- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts {
    __unused NSURL *url = [URLContexts anyObject].URL;
}

#pragma mark -

- (void)_changeIcon {
    if ([UIApplication sharedApplication].supportsAlternateIcons) {
        [[UIApplication sharedApplication] setAlternateIconName:@"ICONBLACK" completionHandler:^(NSError * _Nullable error) {
            NSLog(@"");
        }];
    }
}

@end
