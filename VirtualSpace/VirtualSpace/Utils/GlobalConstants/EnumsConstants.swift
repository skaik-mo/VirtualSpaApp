//
//  EnumsConstants.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import Foundation
import UIKit

// MARK: - enums
extension GlobalConstants {
    enum UserType: Int {
        case User = 0
        case Business = 1
    }

    enum ButtonStyle: Equatable {
        case Primary
        case SecondaryLightPurple(CGFloat)
        case SecondaryLightGray
        case SecondaryDarkGray
        case SecondaryGreen
        case SecondaryRed
        case OutlinedWhite
        case OutlinedPurple

        var height: CGFloat {
            switch self {
            case .Primary, .OutlinedWhite:
                return 40.0
            case .SecondaryLightPurple(let height):
                return height
            case .OutlinedPurple, .SecondaryLightGray:
                return 36.0
            case .SecondaryGreen, .SecondaryRed, .SecondaryDarkGray:
                return 28
            }
        }

        var borderWidth: CGFloat {
            switch self {
            case .OutlinedWhite, .OutlinedPurple:
                return 1
            default:
                return 0
            }
        }

        var borderColor: UIColor {
            switch self {
            case .OutlinedWhite:
                return .color_FFFFFF
            case .OutlinedPurple:
                return .color_8C4EFF
            default:
                return .clear
            }
        }

        var buttonBackgroundColor: UIColor {
            switch self {
            case .Primary:
                return .color_8C4EFF
            case .SecondaryLightPurple:
                return .color_8C4EFF.withAlphaComponent(0.1)
            case .SecondaryLightGray:
                return .color_FAF9FD
            case .SecondaryGreen:
                return .color_18B58C
            case .SecondaryRed:
                return .color_FF0101
            case .SecondaryDarkGray:
                return .color_000000.withAlphaComponent(0.05)
            case .OutlinedWhite, .OutlinedPurple:
                return .clear
            }
        }

        var titleColor: UIColor {
            switch self {
            case .Primary, .SecondaryRed, .SecondaryGreen, .OutlinedWhite:
                return .color_FFFFFF
            case .SecondaryLightGray:
                return .color_000000
            case .SecondaryDarkGray:
                return .color_5E5E5E
            case .SecondaryLightPurple, .OutlinedPurple:
                return .color_8C4EFF
            }
        }

        var font: UIFont {
            return .poppinsMedium13
        }

        func setCorner(_ height: CGFloat) -> CGFloat {
            switch self {
            case .Primary, .SecondaryLightPurple, .SecondaryLightGray, .OutlinedWhite, .OutlinedPurple:
                return height / 2
            case .SecondaryGreen, .SecondaryRed, .SecondaryDarkGray:
                return 10
            }
        }
    }

    enum ProfileMenu: String {
        case AccountPrivacy = "Account Privacy"
        case Reservations = "My reservations"
        case Massages = "Massages"
        case Following = "Following"
        case Followers = "Followers"
        case Friends = "My Friends"
        case EditProfile = "Edit Profile"
        case ChangePassword = "Change Password"
        case DeleteAccount = "Delete account"

        func action() {
            switch self {
            case .AccountPrivacy:
                debugPrint("AccountPrivacy")
            case .Reservations:
                let vc = ReservationsViewController()
                vc._push()
            case .Massages:
                debugPrint("Massages")
            case .Following:
                let vc = FollowingViewController()
                vc._push()
            case .Followers:
                debugPrint("Followers")
            case .Friends:
                let vc = FriendsViewController()
                vc._push()
            case .EditProfile:
                let vc = EditProfileViewController()
                vc._push()
            case .ChangePassword:
                let vc = ChangePasswordViewController()
                vc._push()
            case .DeleteAccount:
                debugPrint("DeleteAccount")
            }

        }
    }
}
