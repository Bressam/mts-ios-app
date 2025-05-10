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
import NetworkCoreInterface
// TVShowListing
import TVShowListingFeatureInterface

final class MainCoordinator: CoordinatorProtocol {
    // MARK: - Properties
    let persistenceController = PersistenceController.shared
    var navigationController: UINavigationController
    let networkClient: NetworkClientProtocol
    
    private lazy var tvShowsListingCoordinator: TVShowListingCoordinatorProtocol = {
        let coordinator = TVShowListingAssembly.assemble(networkClient: networkClient)
        coordinator.navigationController.modalPresentationStyle = .fullScreen
        return coordinator
    }()
    
    init(navigationController: UINavigationController,
         networkClient: NetworkClientProtocol) {
        self.navigationController = navigationController
        self.networkClient = networkClient
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
