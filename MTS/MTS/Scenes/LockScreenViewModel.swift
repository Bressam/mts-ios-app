//
//  LockScreenViewModel.swift
//  MTS
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import SecurityFrameworkInterface

class LockScreenViewModel: ObservableObject {
    private let securityProvider: SecurityProviderProtocol
    private weak var coordinatorDelegate: MainCoordinatorDelegateProtocol?
    
    init(securityProvider: SecurityProviderProtocol,
         coordinatorDelegate: MainCoordinatorDelegateProtocol) {
        self.securityProvider = securityProvider
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    func authenticate() async {
        await coordinatorDelegate?.requestAuthentication()
    }
}
