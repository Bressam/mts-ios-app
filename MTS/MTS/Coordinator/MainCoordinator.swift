//
//  MainCoordinator.swift
//  MTS
//
//  Created by Giovanne Bressam on 09/05/25.
//

import Foundation
import UIKit
import SwiftUI
// Infra
import CoordinatorKitInterface
// TVShowListing
import TVShowListingFeatureInterface

final class MainCoordinator: CoordinatorProtocol {
    // MARK: - Properties
    let persistenceController = PersistenceController.shared
    var navigationController: UINavigationController
    
    private var tvShowsListingCoordinator: TVShowListingCoordinatorProtocol = {
        let coordinator = TVShowListingAssembly.assemble()
        coordinator.navigationController.modalPresentationStyle = .fullScreen
        return coordinator
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        setupInitialViewController()
    }
    
    private func setupInitialViewController() {
//        let contentView = ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
//        let hostingVC = UIHostingController(rootView: contentView)
//        navigationController.pushViewController(hostingVC, animated: false)
        
        navigateToTVShowsListing()
    }
    
    private func navigateToTVShowsListing() {
        startChildFlow(with: tvShowsListingCoordinator)
    }
}
