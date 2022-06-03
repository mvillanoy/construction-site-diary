//
//  EnpointItem.swift
//  ConstructionSiteDiary
//
//  Created by Monica Villanoy on 6/3/22.
//

import Foundation

import Alamofire
enum NetworkEnvironment {
    case dev
    case staging
    case production
    
}

protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
}

enum EndpointItem {
    case addEntry
}

extension EndpointItem: EndPointType {

    
    var httpMethod: HTTPMethod {
        switch self {
        case .addEntry:
            return .post
        }
            
            
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .addEntry:
            return HTTPHeaders(["Content-type" : "multipart/form-data"])
        }
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .addEntry:
            return URLEncoding.httpBody
        }
    }
    
    var baseURL: String {
        switch APIManager.networkEnviroment {
            case .dev: return "https://api.dev.artemis.im/"
            case .staging: return "https://api.staging.artemis.im/"
            case .production: return "https://api.artemis.im"
        }
    }
    
    var path: String {
        switch self {
            case .addEntry:
                return "api/entries"
        }
    }
    
}
