//
//  ResponseHandler.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 19/07/2023.
//

import Foundation
import FirebaseAuth

class ResponseHandler {

    class func responseHandler(error: Error?, isShowMessage: Bool = true) -> Bool {
        guard let error else { return true }
        Helper.showLoader(isLoding: false)
        if isShowMessage {
            SceneDelegate.shared?.rootNavigationController?._showErrorAlertOK(message: error.localizedFirebaseErrorMessage)
        }
        return false
    }

}

extension Error {
    var localizedFirebaseErrorMessage: String {
        let authErrorCode = AuthErrorCode.init(_nsError: self as NSError).code
        switch authErrorCode {
        case .emailAlreadyInUse:
            return Strings.EMAIL_ALREADY_IN_USE_MESSAGE
        case .userNotFound:
            return Strings.USER_NOT_FOUND_MESSAGE
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return Strings.INVALID_SENDER_RECIPIENT_EMAIL_MESSAGE
        case .weakPassword:
            return Strings.WEAK_PASSWORD_MESSAGE
        case .wrongPassword:
            return Strings.WRONG_PASSWORD_MESSAGE
        case .quotaExceeded:
            return Strings.QUOTA_EXCEEDED_MESSAGE
        case .tooManyRequests:
            return Strings.TOO_MANY_REQUESTS_MESSAGE
        case .sessionExpired:
            return Strings.SESSION_EXPIRED_MESSAGE
        case .invalidCredential:
            return Strings.INVALID_CREDENTIAL_MESSAGE
        case .invalidVerificationCode:
            return Strings.INVALID_VERIFICATION_CODE_MESSAGE
        case .userTokenExpired:
            return Strings.TOKEN_EXPIRED_MESSAGE
        case .invalidUserToken:
            return Strings.INVALID_TOKEN_MESSAGE
        case .userDisabled:
            return Strings.USER_DISABLED_MESSAGE
        case .networkError:
            return Strings.NETWORK_ERROR_TITLE
        default:
            return self.localizedDescription
        }
    }

}
