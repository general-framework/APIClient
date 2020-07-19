//
//  LogOut.swift
//
//  Created by Jacob Martin on 7/10/20.
//

import Foundation

// MARK: - Logout

public struct LogOutResponse: Equatable {
    public init() { }
}

public enum LogOutError: Equatable, Error {
    case generic(String)
}
