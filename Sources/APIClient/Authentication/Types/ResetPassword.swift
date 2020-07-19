//
//  ResetPassword.swift
//
//  Created by Jacob Martin on 7/9/20.
//

import Foundation

// MARK: - Confirm Signup
public struct ResetPasswordRequest {
    public var username: String
    
    public init(
        username: String
    ) {
        self.username = username
    }
}

public struct ResetPasswordResponse: Equatable {
    
    public init() {}
}

public enum ResetPasswordError: Equatable, Error {
    case generic(String)
    case usernameDoesNotExist
}

