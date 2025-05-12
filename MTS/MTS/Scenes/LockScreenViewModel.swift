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
    @Published var isUnlocked = false
    
    init(securityProvider: SecurityProviderProtocol,
         coordinatorDelegate: MainCoordinatorDelegateProtocol) {
        self.securityProvider = securityProvider
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    func authenticate() async {
        let validationResult = await coordinatorDelegate?.requestAuthentication()
        await MainActor.run {
            isUnlocked = validationResult ?? false
        }
    }
    
    func finishedUnlocking() {
        if isUnlocked {
            coordinatorDelegate?.didFinishValidation()
        }
    }
}
