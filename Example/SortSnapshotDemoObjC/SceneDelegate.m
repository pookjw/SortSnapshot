//
//  SceneDelegate.m
//  SortSnapshotDemoObjC
//
//  Created by Jinwoo Kim on 6/14/21.
//

#import "SceneDelegate.h"
#import "ViewController.h"

@interface SceneDelegate ()
@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    
    if (windowScene == nil) return;
    
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    
    ViewController *viewController = [ViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [viewController loadViewIfNeeded];
    [navigationController loadViewIfNeeded];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
}

@end
