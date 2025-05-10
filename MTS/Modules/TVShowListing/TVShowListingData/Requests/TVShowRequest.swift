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
    
    var host: String { "api.tvmaze.com" }
    
    var path: String {
        switch self {
        case .listAll:
            return "/shows"
        case .details(let id):
            return "/shows/\(id)"
        }
    }
    
    var queryItems: [URLQueryItem]? { nil }
    var headers: [String : String]? { nil }
    var parameters: [String : Any]? {
        switch self {
        case .listAll(let page):
            return ["page": page]
        case .details(let id):
            return [
                "id": id,
                "embed[]": ["episodes", "cast", "seasons"]
            ]
        }
    }
    
    var encoding: NetworkCoreInterface.RequestEncoding {
        return .urlEncoded
    }
    
    var method: NetworkCoreInterface.HTTPMethod {
        return .get
    }
}
