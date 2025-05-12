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
import SecurityFrameworkInterface
import ValidationKitInterface
// TVShowListing
import TVShowListingFeatureInterface

@MainActor
final class MainCoordinator: CoordinatorProtocol {
    // MARK: - Properties
    let persistenceController = PersistenceController.shared
    var navigationController: UINavigationController
    let networkClient: NetworkClientProtocol
    let securityProvider: SecurityProviderProtocol
    let validationProvider: ValidationProviderProtocol
    
    private lazy var tvShowsListingCoordinator: TVShowListingCoordinatorProtocol = {
        let coordinator = TVShowListingAssembly.assemble(networkClient: networkClient)
        coordinator.navigationController.modalPresentationStyle = .fullScreen
        return coordinator
    }()
    
    init(navigationController: UINavigationController,
         networkClient: NetworkClientProtocol,
         securityProvider: SecurityProviderProtocol,
         validationProvider: ValidationProviderProtocol) {
        self.navigationController = navigationController
        self.networkClient = networkClient
        self.securityProvider = securityProvider
        self.validationProvider = validationProvider
    }
    
    func start() {
        setupInitialViewController()
    }
    
    private func navigateToLockScreen() {
        let viewModel = LockScreenViewModel(securityProvider: securityProvider,
                                            coordinatorDelegate: self)
        let contentView = LockScreenView(viewModel: viewModel)
        let hostingVC = UIHostingController(rootView: contentView)
        navigationController.pushViewController(hostingVC, animated: false)
    }
    
    private func setupInitialViewController() {
        if securityProvider.isPINSet() {
            navigateToLockScreen()
        } else {
            navigateToMainScreen()
        }
    }
    
    private func navigateToMainScreen() {
        navigateToTVShowsListing()
    }
    
    private func navigateToTVShowsListing() {
        startChildFlow(with: tvShowsListingCoordinator)
    }
}

extension MainCoordinator: MainCoordinatorDelegateProtocol {
    func requestAuthentication() async {
        let validationView = validationProvider.makeValidationView { [weak self] success in
            if success {
                self?.navigateToMainScreen()
            }
        }
        
        await MainActor.run {
            let hostingVC = UIHostingController(rootView: validationView)
            navigationController.present(hostingVC, animated: false)
        }
    }
}
