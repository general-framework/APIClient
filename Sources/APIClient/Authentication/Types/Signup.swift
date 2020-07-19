//
//  Signup.swift
//
//  Created by Jacob Martin on 7/8/20.
//

import Foundation

// MARK: - Signup
public struct SignupRequest {
    public var firstName: String
    public var lastName: String
    public var email: String
    public var password: String
    
    public init(
        firstName: String,
        lastName: String,
        email: String,
        password: String
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
}

public struct SignupResponse: Equatable {
    public var token: String
    
    public init(token: String) {
        self.token = token
    }
}

public enum SignupError: Equatable, Error {
    case generic(String)
    case invalidSignup
    
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
