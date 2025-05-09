//
//  CoordinatorProtocol.swift
//  SignIn
//
//  Created by Giovanne Bressam on 09/05/25.
//  Copyright © 2024 dev.bressam. All rights reserved.
//

import UIKit

@MainActor
public protocol CoordinatorProtocol: AnyObject {
    var navigationController: DefaultNavigationController { get }
    func start()
    func dismiss(animated: Bool)
    func startChildFlow(with coordinator: CoordinatorProtocol, animated: Bool)
}

public extension CoordinatorProtocol {
    func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: animated, completion: {
            self.navigationController.viewControllers.removeAll()
        })
    }

    func startChildFlow(with coordinator: CoordinatorProtocol,
                        animated: Bool = true) {
        // Setup new flow presentation style
        navigationController.present(coordinator.navigationController, animated: animated)

        // Starts new flow
        coordinator.start()
    }
}
