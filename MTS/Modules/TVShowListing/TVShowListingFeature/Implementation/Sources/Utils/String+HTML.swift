//
//  String+HTML.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

extension String {
    /// Removes any HTML related characters
    func stripHTML() -> Self {
        self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
