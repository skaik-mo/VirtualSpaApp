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

    enum NotificationType: Int {
        case Alert = 0
        case Message = 1
        case Invite = 2
        case Following = 3
        case Friend = 4

        static func getType(_ type: Int?) -> NotificationType {
            switch type {
            case 4:
                return .Friend
            case 3:
                return .Following
            case 2:
                return .Invite
            case 1:
                return .Message
            default:
                return .Alert
            }
        }
    }
}

// MARK: - Firbase Collections
extension GlobalConstants {
    enum Collection: String {
        case User
        case Post
        case Comment
        case Place
        case Category
        case SubCategory
        case Reservation
        case Follow
        case Friend
        case Conversation
        case Message
        case Notification
    }
}

// MARK: - Button Style
extension GlobalConstants {
    enum ButtonStyle: Equatable {
        case Primary(CGFloat)
        case SecondaryLightPurple(CGFloat)
        case SecondaryLightGray
        case SecondaryDarkGray
        case SecondaryGreen
        case SecondaryRed
        case OutlinedWhite
        case OutlinedPurple((CGFloat))

        var height: CGFloat {
            switch self {
            case .Primary(let height):
                return height
            case .OutlinedWhite:
                return 40.0
            case .SecondaryLightPurple(let height):
                return height
            case .OutlinedPurple(let height):
                return height
            case .SecondaryLightGray:
                return 35.0
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
            case .Primary(let height), .SecondaryLightPurple(let height), .OutlinedPurple(let height):
                return height / 2
            case .SecondaryLightGray, .OutlinedWhite:
                return height / 2
            case .SecondaryGreen, .SecondaryRed, .SecondaryDarkGray:
                return 10
            }
        }
    }
}

// MARK: - Menu
extension GlobalConstants {
    enum ProfileMenu {
        case AccountPrivacy
        case Reservations
        case Massages
        case Following
        case Followers
        case Friends
        case EditProfile
        case ChangePassword
        case DeleteAccount

        var title: String {
            switch self {
            case .AccountPrivacy:
                return Strings.ACCOUNT_PRIVACY_TITLE
            case .Reservations:
                return Strings.MY_RESERVATIONS_TITLE
            case .Massages:
                return Strings.MESSAGES_TITLE
            case .Following:
                return Strings.FOLLOWING_TITLE
            case .Followers:
                return Strings.FOLLOWERS_TITLE
            case .Friends:
                return Strings.MY_FRIENDS_TITLE
            case .EditProfile:
                return Strings.EDIT_PROFILE_TITLE
            case .ChangePassword:
                return Strings.CHANGE_PASS_TITLE
            case .DeleteAccount:
                return Strings.DELETE_ACCOUNT_TITLE
            }
        }

        func action() {
            switch self {
            case .AccountPrivacy:
                debugPrint("AccountPrivacy")
            case .Reservations:
                let vc = ReservationsViewController()
                vc._push()
            case .Massages:
                let vc = MessageViewController()
                vc._push()
            case .Following:
                let vc = FollowingViewController()
                vc._push()
            case .Followers:
                let vc = FollowingViewController()
                vc._push()
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
                UserController().deleteAccount()
            }

        }
    }
}
