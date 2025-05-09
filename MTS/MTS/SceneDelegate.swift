//
//  SceneDelegate.swift
//  MTS
//
//  Created by Giovanne Bressam on 09/05/25.
//

import SwiftUI
import UIKit
import CoordinatorKitInterface

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Properties
    var window: UIWindow?
    var mainCoordinator: CoordinatorProtocol!
    var rootNavigationVC: DefaultNavigationController = .init()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        setup()

        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.rootViewController = mainCoordinator.navigationController
        window.makeKeyAndVisible()

        mainCoordinator.start()
    }
    
    // MARK: - Setup
    private func setup() {
        setupCoordinators()
    }
    
    // MARK: - Dependencies setup
    private func setupCoordinators() {
        mainCoordinator = MainCoordinator(navigationController: rootNavigationVC)
    }
}
