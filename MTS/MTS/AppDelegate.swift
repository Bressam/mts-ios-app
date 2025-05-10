//
//  AppDelegate.swift
//  MTS
//
//  Created by Giovanne Bressam on 09/05/25.
//

import UIKit
import CoordinatorKitInterface

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupTheme()
        return true
    }
    
    // MARK: - UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    private func setupTheme() {
        let accentColor = UIColor(named: "AccentColor")
        // SegmentedControl
        UISegmentedControl.appearance().selectedSegmentTintColor = accentColor
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.white], for: .selected
        )
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor(named: "AccentColor") ?? .systemBlue], for: .normal
        )
        
        // Navigation
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .systemBackground
        navBarAppearance.titleTextAttributes = [.foregroundColor: accentColor!]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: accentColor!]
        
        // Apply to all UINavigationBars
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = accentColor
    }
}
