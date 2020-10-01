//
//  SceneDelegate.m
//  13-性能优化
//
//  Created by 朱双泉 on 2020/9/30.
//

#import "SceneDelegate.h"
#import "ViewController.h"
#import "SQCallTrace.h"
#import "SQFluecyMonitor.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

+ (void)load {
    NSLog(@"%s", __func__);
}


+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"%s", __func__);
    });
}

/**
 冷启动
 main
 -[AppDelegate application:didFinishLaunchingWithOptions:]
 -[SceneDelegate scene:willConnectToSession:options:] - begin
 -[SQLaunchScreenViewController viewDidLoad]
 -[SceneDelegate scene:willConnectToSession:options:] - end
 -[SceneDelegate sceneWillEnterForeground:]
 -[SceneDelegate sceneDidBecomeActive:]
 
 热启动
 -[SceneDelegate sceneWillEnterForeground:]
 -[SceneDelegate sceneDidBecomeActive:]
 */

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    NSLog(@"%s - begin", __func__);
    
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    self.window.frame = windowScene.coordinateSpace.bounds;
    self.window.rootViewController = [[UIStoryboard storyboardWithName: @"Main" bundle: nil] instantiateInitialViewController];
    [self.window makeKeyAndVisible];
    
    NSLog(@"%s - end", __func__);
    /**
     启动阶段3
     
     首屏渲染后的这个阶段，主要完成的是，非首屏其他业务服务模块的初始化、监听的注册、配置文件的读取等。
     从函数上来看，这个阶段指的就是截止到 didFinishLaunchingWithOptions 方法作用域内执行首屏渲染之后的所有方法执行完成。
     简单说的话，这个阶段就是从渲染完成时开始，到 didFinishLaunchingWithOptions 方法作用域结束时结束。
     
     这个阶段用户已经能够看到 App 的首页信息了，所以优化的优先级排在最后。
     但是，那些会卡住主线程的方法还是需要最优先处理的，不然还是会影响到用户后面的交互操作。
     */
    // 异步
    dispatch_async(dispatch_queue_create("串行队列", DISPATCH_QUEUE_SERIAL), ^{
        // 耗时操作...
        [[SQFluecyMonitor sharedMonitor] startMonitoring];
    });
    
    [SQCallTrace stop];
    [SQCallTrace save];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    NSLog(@"%s", __func__);
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    NSLog(@"%s", __func__);
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    NSLog(@"%s", __func__);
}


- (void)sceneWillResignActive:(UIScene *)scene {
    NSLog(@"%s", __func__);
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    NSLog(@"%s", __func__);
}


@end
