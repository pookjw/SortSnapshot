//
//  SceneDelegate.swift
//  SortSnapshotDemoSwift
//
//  Created by Jinwoo Kim on 6/14/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene: UIWindowScene = (scene as? UIWindowScene) else {
            return
        }
        
        window = .init(windowScene: windowScene)
        
        let viewController: ViewController = .init()
        let navigationController: UINavigationController = .init(rootViewController: viewController)
        viewController.loadViewIfNeeded()
        navigationController.loadViewIfNeeded()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
