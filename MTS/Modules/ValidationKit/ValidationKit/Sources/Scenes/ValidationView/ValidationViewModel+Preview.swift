//
//  ValidationViewModel+Preview.swift
//  ValidationKit
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import ValidationKitInterface
import SecurityFrameworkTesting

@MainActor
extension ValidationViewModel {
    static var preview: ValidationViewModel {
        let spy = SecurityProviderSpy()
        spy.shouldSucceedBiometric = false
        spy.storedPIN = "1234"
        
        return ValidationViewModel(securityProvider: spy) { success in
            print("Preview Authenticated: \(success)")
        }
    }
}
