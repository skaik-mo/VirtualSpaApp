//
//  ResponseHandler.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 19/07/2023.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

class ResponseHandler {

    class func responseHandler(error: Error?, isShowMessage: Bool = true) -> Bool {
        guard let error else { return true }
        Helper.showLoader(isLoding: false)
        if isShowMessage {
            SceneDelegate.shared?.window?.rootViewController?._showErrorAlertOK(message: error.localizedFirebaseErrorMessage)
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
            return self.localizedFirebaseStorageErrorMessage
        }
    }

    var localizedFirebaseStorageErrorMessage: String {
        let authErrorCode = StorageErrorCode.init(rawValue: (self as NSError).code)
        switch authErrorCode {
        case .objectNotFound:
            return Strings.OBJECT_NOT_FOUND_MESSAGE
        case .bucketNotFound:
            return Strings.BUCKET_NOT_FOUND_MESSAGE
        case .projectNotFound:
            return Strings.PROJECT_NOT_FOUND_MESSAGE
        case .invalidArgument:
            return Strings.INVALID_ARGUMENT_MESSAGE
        case .downloadSizeExceeded:
            return Strings.SIZE_EXCEEDED_MESSAGE
        case .retryLimitExceeded:
            return Strings.LIMIT_EXCEEDED_MESSAGE
        case .unauthenticated:
            return Strings.UNAUTHENTICATED_MESSAGE
        case .unauthorized:
            return Strings.UNAUTHORIZED_MESSAGE
        case .quotaExceeded:
            return Strings.QUOTA_EXCEEDED_STORAGE_MESSAGE
        case .nonMatchingChecksum:
            return Strings.MATCHING_CHECKSUM_MESSAGE
        case .cancelled:
            return Strings.CANCELLED_MESSAGE
        default:
            return self.localizedDescription
        }
    }

}
