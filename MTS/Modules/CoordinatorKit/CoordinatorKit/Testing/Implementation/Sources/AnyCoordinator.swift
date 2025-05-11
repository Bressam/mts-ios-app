//
//  AnyCoordinator.swift
//  CoordinatorKit
//
//  Created by Giovanne Bressam on 09/05/25.
//

import Foundation
import UIKit
import CoordinatorKitInterface

/// Simple implementation of `CoordinatorProtocol`, allowing default behavior tests and prevent duplicate implementations for tests
final public class AnyCoordinator: CoordinatorProtocol {
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController ?? .init()
    }
    
    public func start() {}
}
