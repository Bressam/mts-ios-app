//
//  StubService.swift
//  SignInTesting
//
//  Created by Giovanne Bressam on 09/05/25.
//  Copyright © 2024 dev.bressam. All rights reserved.
//

import Foundation
import UIKit
import CoordinatorKitInterface

/// Spy implementation for `CoordinatorProtocol`. Notifies by closure any protocol method called
public final class CoordinatorSpy: CoordinatorProtocol {
    public var navigationController: UINavigationController
    public var didStart: (() -> Void)?
    public var didDisismiss: (() -> Void)?
    public var didStartChildFlow: ((CoordinatorProtocol) -> Void)?

    public init(navigationController: DefaultNavigationController? = nil) {
        self.navigationController = navigationController ?? .init()
    }
    

    public func start() {
        didStart?()
    }

    public func dismiss(animated: Bool) {
        didDisismiss?()
    }

    public func startChildFlow(with coordinator: CoordinatorProtocol, animated: Bool) {
        didStartChildFlow?(coordinator)
    }
}
