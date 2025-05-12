//
//  SomeFeature.swift
//  TVShowListingCoordinator
//
//  Created by Giovanne Bressam on 09/05/25.
//

import Foundation
import UIKit
import SwiftUI
// Infra
import CoordinatorKitInterface
import NetworkCoreInterface
// Feats
import TVShowListingFeatureInterface
import TVShowListingFeatureData
import TVShowListingFeatureDomain

final public class TVShowListingCoordinator: TVShowListingCoordinatorProtocol {
    public var navigationController: UINavigationController
    
    let networkClient: NetworkClientProtocol

    private lazy var tvShowsRepositoryProtocol: TVShowsRepositoryProtocol = {
        return RemoteTVShowsRepository(networkClient: networkClient)
    }()

    private lazy var tvShowDetailsRepository: TVShowDetailsRepositoryProtocol = {
        return RemoteTVShowDetailsRepository(networkClient: networkClient)
    }()

    public init(navigationController: UINavigationController,
                networkClient: NetworkClientProtocol) {
        self.navigationController = navigationController
        self.networkClient = networkClient
        navigationController.navigationBar.prefersLargeTitles = true
    }

    public func start() {
        navigateToTVShowsListingView()
    }
    
    public func navigateToTVShowsListingView() {
        let fetchTVShowUsecase = FetchTVShowsUseCase(tvShowRepository: tvShowsRepositoryProtocol)
        let searchTVShowUsecase = SearchTVShowsUseCase(repository: tvShowsRepositoryProtocol)
        let tvShowListingViewModel: TVShowsListingViewModel = .init(coordinator: self,
                                                                    fetchTVShowUseCase: fetchTVShowUsecase,
                                                                    searchTVShowUseCase: searchTVShowUsecase)
        let hostingVC = UIHostingController(rootView: TVShowsListingView(viewModel: tvShowListingViewModel))
        hostingVC.navigationItem.backButtonTitle = "TV Shows"
        navigationController.pushViewController(hostingVC, animated: true)
    }
    
    public func navigateToTVShowDetailsView(showID: Int, showTitle: String) {
        let fetchTVShowDetailsUsecase = FetchTVShowDetailsUseCase(tvShowDetailsRepository: tvShowDetailsRepository)
        let tvShowDetailsViewModel = TVShowDetailsViewModel(coordinator: self,
                                                            fetchTVShowDetailsUseCase: fetchTVShowDetailsUsecase,
                                                            currentShowID: showID,
                                                            currentShowTitle: showTitle)
        
        let hostingVC = UIHostingController(rootView: TVShowDetailView(viewModel: tvShowDetailsViewModel))
        navigationController.pushViewController(hostingVC, animated: true)
    }
    
    public func navigateToEpisodeDetails(episode: TVShowEpisode) {
        let episodeDetailsViewModel = TVShowEpisodeDetailsViewModel(episode: episode)
        let hostingVC = UIHostingController(rootView: TVShowEpisodeDetailsView(viewModel: episodeDetailsViewModel))
        navigationController.pushViewController(hostingVC, animated: true)
    }
}
