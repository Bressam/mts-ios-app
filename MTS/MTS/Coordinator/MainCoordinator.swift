//
//  MainCoordinator.swift
//  MTS
//
//  Created by Giovanne Bressam on 09/05/25.
//

import Foundation
import UIKit
import SwiftUI
import CoordinatorKitInterface

final class MainCoordinator: CoordinatorProtocol {
    let persistenceController = PersistenceController.shared
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        setupInitialViewController()
    }
    
    private func setupInitialViewController() {
        let contentView = ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        let hostingVC = UIHostingController(rootView: contentView)
        navigationController.pushViewController(hostingVC, animated: false)
    }
}
