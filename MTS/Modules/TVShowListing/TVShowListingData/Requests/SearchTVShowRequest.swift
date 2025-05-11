//
//  SearchTVShowRequest.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import NetworkCoreInterface

struct SearchTVShowRequest: HTTPNetworkRequest {
    var queryItems: [URLQueryItem]? = nil
    let query: String

    var host: String { "api.tvmaze.com" }
    var path: String { "/search/shows" }
    var method: HTTPMethod { .get }
    
    var parameters: [String: Any]? {
        ["q": query]
    }
    
    var headers: [String : String]? { nil }
    var encoding: RequestEncoding { .urlEncoded }
}
