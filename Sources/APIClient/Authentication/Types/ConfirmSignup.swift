//
//  ConfirmSignup.swift
//
//  Created by Jacob Martin on 7/9/20.
//

 
import Foundation

// MARK: - Confirm Signup
public struct ConfirmSignupRequest {
    public var username: String
    public var confirmationCode: String
    
    public init(
        username: String,
        confirmationCode: String
    ) {
        self.username = username
        self.confirmationCode = confirmationCode
    }
}

public struct ConfirmSignupResponse: Equatable {
    public var token: String
    
    public init( token: String) {
        self.token = token
    }
}

public enum ConfirmSignupError: Equatable, Error {
    case generic(String)
    case invalidConfirmationCode
}

