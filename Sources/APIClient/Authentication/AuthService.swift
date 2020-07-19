//
//  AuthService.swift
//  
//  Created by Jacob Martin on 7/18/20.
//

import Foundation
import ComposableArchitecture
import Combine

// MARK: - AuthService Definition
public class AuthService {
    
    public enum Action: Equatable {
        case signedIn
        case sessionExpired
        case signedOut
    }
    
    public init() {}
    
    public var create: (AnyHashable) -> Effect<Action, Never> = { _ in _unimplemented("create") }
    public var destroy: (AnyHashable) -> Effect<Never, Never> = { _ in _unimplemented("destroy") }
    public var getToken: () -> AnyPublisher<GetTokenResponse, GetTokenError> = { _unimplemented("getToken") }
    public var signup: (SignupRequest) -> Effect<SignupResponse, SignupError> = { _ in _unimplemented("signup") }
    public var login: (LoginRequest) -> Effect<LoginResponse, LoginError> = { _ in _unimplemented("login") }
    public var confirmSignup: (ConfirmSignupRequest) -> Effect<ConfirmSignupResponse, ConfirmSignupError> = { _ in _unimplemented("confirmSignUp") }
    public var resetPassword: (ResetPasswordRequest) -> Effect<ResetPasswordResponse, ResetPasswordError> = { _ in _unimplemented("resetPassword") }
    public var logOut: () -> Effect<LogOutResponse, LogOutError> = { _unimplemented("logOut") }
}

// MARK: - APIClient AuthService Passthrough
extension APIClient {
    
    public func getToken() -> AnyPublisher<GetTokenResponse, GetTokenError> {
        return self.authService.getToken()
    }
    
    public func signup(_ request: SignupRequest) -> Effect<SignupResponse, SignupError> {
        return self.authService.signup(request)
    }
    
    public func login(_ request: LoginRequest) -> Effect<LoginResponse, LoginError> {
        return self.authService.login(request)
    }
    
    public func confirmSignup(_ request: ConfirmSignupRequest) -> Effect<ConfirmSignupResponse, ConfirmSignupError> {
        return self.authService.confirmSignup(request)
    }
    
    public func resetPassword(_ request: ResetPasswordRequest) -> Effect<ResetPasswordResponse, ResetPasswordError> {
        return self.authService.resetPassword(request)
    }
    
    public func logOut() -> Effect<LogOutResponse, LogOutError> {
        return self.authService.logOut()
    }
}
