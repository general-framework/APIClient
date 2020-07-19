//
//  GetToken.swift
//
//  Created by Jacob Martin on 7/9/20.
//

import Foundation

// MARK: - Get Token

public struct GetTokenResponse: Equatable {
    public let token: String
    
    public init(token: String) {
        self.token = token
    }
}

public enum GetTokenError: Equatable, Error {
    case noAuthPool
    case generic(String)
}
