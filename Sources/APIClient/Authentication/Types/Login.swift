//
//  Login.swift
//
//  Created by Jacob Martin on 7/8/20.
//

import Foundation

// MARK: - Login
public struct LoginRequest {
    public var email: String
    public var password: String
    
    public init(
        email: String,
        password: String
    ) {
        self.email = email
        self.password = password
    }
}

public struct LoginResponse: Equatable {
    public var token: String
    
    public init(
        token: String
    ) {
        self.token = token
    }
}

public enum LoginError: Equatable, Error {
    case generic(String)
    case invalidPassword
    
    public var description : String {
      switch self {
      // Use Internationalization, as appropriate.
      case .generic(let string):
        return string
      default:
        return "There was an error"
      }
    // TODO: we should do a custom error mapping if possible
    }
}

