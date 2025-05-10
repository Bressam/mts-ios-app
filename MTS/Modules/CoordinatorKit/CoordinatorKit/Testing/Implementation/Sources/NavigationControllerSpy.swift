//
//  NavigationControllerSpy.swift
//  CoordinatorKit
//
//  Created by Giovanne Bressam on 09/05/25.
//

import Foundation
import UIKit

/// Spy implementation for a `UINavigationController`. Notifies when dismiss is called
final public class NavigationControllerSpy: UINavigationController {
    public var didDisismiss: (() -> Void)?

    override public func dismiss(animated flag: Bool,
                                 completion: (() -> Void)? = nil) {
        completion?()
        didDisismiss?()
    }
}
