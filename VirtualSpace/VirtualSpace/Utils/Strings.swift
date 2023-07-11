//_________SKAIK_MO_________
//
//  Strings.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 09/07/2023.
//

import Foundation

class Strings {

    // MARK: - Global String
    static let WRONG_TITLE = "Something wrong"._localizedKey
    static let OK_TITLE = "OK"._localizedKey
    static let ALERT_TITLE = "Alert"._localizedKey
    static let CANCEL_TITLE = "Cancel"._localizedKey
    static let NETWORK_ERROR_TITLE = "It seems that there is no internet connection."._localizedKey

    // MARK: - Validators
    static let INVALID_VALUE_MESSAGE = "{field} field is required"._localizedKey
    static let INVALID_RANGE_MESSAGE = "The {field} is not valid"._localizedKey
    static let INVALID_LENGTH_MINIMUM_EXACTLY_MESSAGE = "Incorrect length in the {field} field. Exactly {minimum} characters are allowed."._localizedKey
    static let INVALID_LENGTH_BETWEEN_MINIMUM_MAXIMUM_MESSAGE = "Incorrect length in the {field} field. Must be between {minimum} and {maximum} characters."._localizedKey
    static let INVALID_LENGTH_MINIMUM_MESSAGE = "Incorrect length in the {field} field. Minimum length required is {minimum} characters."._localizedKey
    static let INVALID_LENGTH_MAXIMUM_MESSAGE = "Incorrect length in the {field} field. Maximum length allowed is {maximum} characters."._localizedKey
    
    // MARK: - Authentication
    static let VIRTUAL_SPA_TITLE = "VIRTUAL SPA"._localizedKey
    static let LOREM_IPSUM_TITLE = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod"._localizedKey
    static let SIGN_IN = "Sign in"._localizedKey
    static let SIGN_UP = "Sign up"._localizedKey

    // MARK: - Sign Up
    static let PHONE_TITLE = "Phone"._localizedKey
    static let EMAIL_TITLE = "Email"._localizedKey
    static let FILL_DATA_TITLE = "Please fill in a few details below"._localizedKey
    static let USER_TITLE = "User"._localizedKey
    static let BUSNIESS_TITLE = "Busniess"._localizedKey
    static let PRIVACY_AGREE_TITLE = "By logging in or registering, you agree to our Terms of Service and Privacy Policy."._localizedKey
    static let NAME_TITLE = "Name"._localizedKey
    static let PASSWORD_TITLE = "Password"._localizedKey
    static let TERMS_TITLE = "Terms of Service"._localizedKey
    static let POLICY_TITLE = "Privacy Policy."._localizedKey

    // MARK: - Sign In
    static let SIGN_IN_PLACEHOLER = "Using jon.inventory@gmail.com to log in."._localizedKey
    static let FORGOT_TITLE = "Forgot Password?"._localizedKey

}
