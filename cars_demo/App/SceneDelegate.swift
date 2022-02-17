//
//  SceneDelegate.swift
//  cars_demo
//
//  Created by Utsav Patel on 15/02/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: ApplicationCoordinator!

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let navigationCon = UINavigationController()
        coordinator = ApplicationCoordinator(navigationController: navigationCon)
        coordinator!.start()

        self.window!.rootViewController = navigationCon
        self.window!.makeKeyAndVisible()
    }
}
