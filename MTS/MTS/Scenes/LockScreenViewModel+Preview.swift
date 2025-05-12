//
//  LockScreenViewModel+Preview.swift
//  MTS
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import SecurityFrameworkInterface
import SecurityFrameworkTesting

@MainActor
extension LockScreenViewModel {
    public static var preview: LockScreenViewModel {
        let securityProviderSpy = SecurityProviderSpy()
        return LockScreenViewModel(securityProvider: securityProviderSpy,
                                   coordinatorDelegate: MainCoordinatorDelegatePreview())
    }
    
    // Would be on Testing target for modules or more complex scenarios
    final class MainCoordinatorDelegatePreview: MainCoordinatorDelegateProtocol {
        func requestAuthentication() {}
    }
}
