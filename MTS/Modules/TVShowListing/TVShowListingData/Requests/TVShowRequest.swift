//
//  TVShowRequest.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import NetworkCoreInterface

enum TVShowRequest: HTTPNetworkRequest {   
    case listAll(page: Int)
    case details(id: Int)
    case search(query: String)

    var host: String { "api.tvmaze.com" }
    
    var path: String {
        switch self {
        case .listAll:
            return "/shows"
        case .details(let id):
            return "/shows/\(id)"
        case .search:
            return "/search/shows"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .listAll(let page):
            return ["page": page]
        case .details(let id):
            return [
                "id": id,
                "embed[]": ["episodes", "cast", "seasons"]
            ]
        case .search(let query):
            return ["q": query]
        }
    }

    var method: HTTPMethod {
        return .get
    }
}
