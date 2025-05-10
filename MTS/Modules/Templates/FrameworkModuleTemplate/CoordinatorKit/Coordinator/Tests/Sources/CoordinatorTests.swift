//
//  CoordinatorTests.swift
//  SignIn
//
//  Created by Giovanne Bressam on 09/05/25.
//  Copyright © 2024 dev.bressam. All rights reserved.
//

import Foundation
import XCTest
import CoordinatorKitInterface
import CoordinatorKitTesting

@MainActor
final public class CoordinatorTests: XCTestCase {
    func test_coordinatorDismiss_shouldDismissRootVC() {
        let navigationControllerSpy = NavigationControllerSpy()
        let sut = AnyCoordinator(navigationController: navigationControllerSpy)
        
        let expectation = expectation(description: "Coordinator should dismiss")
        navigationControllerSpy.didDisismiss = { [weak expectation] in
            expectation?.fulfill()
        }

        sut.dismiss()
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_coordinatorDismiss_shouldClearVCs() {
        let navigationControllerSpy = NavigationControllerSpy()
        let sut = AnyCoordinator(navigationController: navigationControllerSpy)
        
        navigationControllerSpy.viewControllers = [UIViewController()]

        sut.dismiss()
        XCTAssertEqual(navigationControllerSpy.viewControllers.count, 0)
    }
    
    func test_coordinatorStartChildFlow_shouldCallStartOnChild() {
        let coordinatorSpy = CoordinatorSpy()
        let sut = AnyCoordinator()

        let expectation = expectation(description: "Coordinator should call start on child coordinator")
        coordinatorSpy.didStart = { [weak expectation] in
            expectation?.fulfill()
        }
        
        sut.startChildFlow(with: coordinatorSpy)
        wait(for: [expectation], timeout: 0.1)
    }
}
