//
//  APIClient.swift
//
//  Created by Jacob Martin on 7/18/20.
//

import Foundation
import ComposableArchitecture
import Combine

public enum APIError: Error, Equatable {
    case token(GetTokenError)
    case session(URLSession.DataTaskPublisher.Failure)
}

// PURPOSE:
// - wrap token logic
// - log traffic between client and API
// - manage change from
public class APIClient: NSObject, URLSessionTaskDelegate {
//    public static var shared: APIClient = APIClient("api.platform.dev.fruitstreet.com")
    
    internal let authService: AuthService
    
    private let scheme: String
    private let host: String

    private var session: URLSession!

    public init(authService: AuthService, scheme: String = "https", host: String) {
        
        self.authService = authService
        self.scheme = scheme
        self.host = host
        
        super.init()
        
        self.session = URLSession(configuration: .ephemeral, delegate: self, delegateQueue: nil)
    }

    /// Request  with authentication headers set
    /// - Parameters:
    ///   - request: base request
    ///   - token: id token
    /// - Returns: authenticated request
    func authenticated(request: URLRequest, with token: String) -> URLRequest {
        var request = request
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }

    /// build a URLRequest
    /// - Parameters:
    ///   - path: path of resource
    ///   - queryItems: query items to be added to url (optional)
    /// - Returns: a URLRequest
    public func request(_ path: String, queryItems: [String: String?]? = nil) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems.map {
                URLQueryItem(name: $0, value: $1)
            }
        }
        
        let request = URLRequest(url: urlComponents.url!)
    
        return request
    }
    
    /// Send a request
    /// - Parameters:
    ///   - request: request to be sent
    ///   - authenticated: denotes if the request sent requires authentication
    /// - Returns: An Effect reulting in Data or a DataTaskPublisher Failure
    public func send(_ request: URLRequest, authenticated: Bool = false) -> Effect<Data, APIError> {
        
        guard authenticated else {
            return self.session.dataTaskPublisher(for: request)
            .mapError(APIError.session)
            .map { $0.0 }
            .eraseToEffect()
        }
        
        return getToken()
            .mapError(APIError.token)
            .map { self.authenticated(request: request, with: $0.token) }
            .flatMap({ request in
                return self.session.dataTaskPublisher(for: request)
                    .mapError(APIError.session)
                
            })
            .map { $0.0 }
            .eraseToEffect()
    }
    
}
