//
//  TVShowListingCoordinatorStub.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 09/05/25.
//

import Foundation
import UIKit
import TVShowListingFeatureInterface

/// Stub for required dependencies of `TVShowListingCoordinatorProtocol` that won't matter the implementation
final public class TVShowListingCoordinatorStub: TVShowListingCoordinatorProtocol {
    public var navigationController: UINavigationController = .init()
    
    public init() {}

    public func start() { }
}
