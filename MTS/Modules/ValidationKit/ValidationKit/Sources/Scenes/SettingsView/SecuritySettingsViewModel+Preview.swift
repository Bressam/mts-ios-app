//
//  SecuritySettingsViewModel+Preview.swift
//  ValidationKit
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import SecurityFrameworkTesting

@MainActor
extension SecuritySettingsViewModel {
    static var preview: SecuritySettingsViewModel {
        let spy = SecurityProviderSpy()
        spy.shouldSucceedBiometric = false
        
        return SecuritySettingsViewModel(securityProvider: spy)
    }
}
