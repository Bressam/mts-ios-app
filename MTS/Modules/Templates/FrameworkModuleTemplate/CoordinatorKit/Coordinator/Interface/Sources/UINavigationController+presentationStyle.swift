//
//  UINavigationController+presentationStyle.swift
//  Coordinator
//
//  Created by Giovanne Bressam on 09/05/25.
//  Copyright © 2024 dev.bressam. All rights reserved.
//

import UIKit

public class DefaultNavigationController: UINavigationController {
    private var isPresentationStyleSetManually = false

    public override var modalPresentationStyle: UIModalPresentationStyle {
        get {
            return isPresentationStyleSetManually ? super.modalPresentationStyle : .fullScreen
        } set {
            isPresentationStyleSetManually = true
            super.modalPresentationStyle = newValue
        }
    }
}
