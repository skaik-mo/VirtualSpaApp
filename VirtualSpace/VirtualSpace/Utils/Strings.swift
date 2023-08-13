// _________SKAIK_MO_________
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
    static let PERMISSION_DENIED_TITLE = "Microphone Permission Denied"._localizedKey
    static let PERMISSION_DENIED_MESSAGE = "Please grant microphone permission to use this feature. After changing the permission, please restart the app."._localizedKey
    static let SETTINGS_TITLE = "Settings"._localizedKey

    // MARK: - Validators
    static let INVALID_VALUE_MESSAGE = "{field} field is required"._localizedKey
    static let INVALID_RANGE_MESSAGE = "The {field} is not valid"._localizedKey
    static let INVALID_LENGTH_MINIMUM_EXACTLY_MESSAGE = "Incorrect length in the {field} field. Exactly {minimum} characters are allowed."._localizedKey
    static let INVALID_LENGTH_BETWEEN_MINIMUM_MAXIMUM_MESSAGE = "Incorrect length in the {field} field. Must be between {minimum} and {maximum} characters."._localizedKey
    static let INVALID_LENGTH_MINIMUM_MESSAGE = "Incorrect length in the {field} field. Minimum length required is {minimum} characters."._localizedKey
    static let INVALID_LENGTH_MAXIMUM_MESSAGE = "Incorrect length in the {field} field. Maximum length allowed is {maximum} characters."._localizedKey

    // MARK: - Firebase Errors
    static let EMAIL_ALREADY_IN_USE_MESSAGE = "The email is already in use with another account."._localizedKey
    static let USER_NOT_FOUND_MESSAGE = "Account not found for the specified user. Please check and try again"._localizedKey
    static let INVALID_SENDER_RECIPIENT_EMAIL_MESSAGE = "Please enter a valid email"._localizedKey
    static let WEAK_PASSWORD_MESSAGE = "Your password is too weak. The password must be 6 characters long or more."._localizedKey
    static let WRONG_PASSWORD_MESSAGE = "Your password is incorrect. Please try again or use 'Forgot password' to reset your password"._localizedKey
    static let QUOTA_EXCEEDED_MESSAGE = "The SMS quota for this project has been exceeded."._localizedKey
    static let TOO_MANY_REQUESTS_MESSAGE = "We have blocked all requests from this device due to unusual activity. Try again later."._localizedKey
    static let SESSION_EXPIRED_MESSAGE = "The verification code has expired. Please try again."._localizedKey
    static let INVALID_CREDENTIAL_MESSAGE = "The verification ID used to create the phone auth credential is invalid."._localizedKey
    static let INVALID_VERIFICATION_CODE_MESSAGE = "The verification code used to create the phone auth credential is invalid."._localizedKey
    static let TOKEN_EXPIRED_MESSAGE = "User token has expired."._localizedKey
    static let INVALID_TOKEN_MESSAGE = "Invalid user token."._localizedKey
    static let USER_DISABLED_MESSAGE = "Your account has been disabled. Please contact support."._localizedKey

    static let OBJECT_NOT_FOUND_MESSAGE = "File doesn't exist."._localizedKey
    static let BUCKET_NOT_FOUND_MESSAGE = "The specified bucket does not exist."._localizedKey
    static let PROJECT_NOT_FOUND_MESSAGE = "No project is configured for Firebase Storage."._localizedKey
    static let INVALID_ARGUMENT_MESSAGE = "An invalid argument was provided."._localizedKey
    static let SIZE_EXCEEDED_MESSAGE = "The size of the downloaded file exceeds the limit (Maximum allowed: 2GB)."._localizedKey
    static let LIMIT_EXCEEDED_MESSAGE = "The maximum time limit on an operation (upload, download, delete, etc.) has been exceeded."._localizedKey
    static let UNAUTHENTICATED_MESSAGE = "User is unauthenticated. Authenticate and try again."._localizedKey
    static let UNAUTHORIZED_MESSAGE = "Unauthorized to access the file."._localizedKey
    static let QUOTA_EXCEEDED_STORAGE_MESSAGE = "Quota on your Firebase Storage bucket has been exceeded."._localizedKey
    static let MATCHING_CHECKSUM_MESSAGE = "File on the client does not match the checksum of the file received by the server."._localizedKey
    static let CANCELLED_MESSAGE = "The operation was cancelled."._localizedKey

    // MARK: - Authentication
    static let VIRTUAL_SPA_TITLE = "VIRTUAL SPA"._localizedKey
    static let LOREM_IPSUM_TITLE = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod"._localizedKey
    static let SIGN_IN = "Sign in"._localizedKey
    static let SIGN_UP = "Sign up"._localizedKey

    // MARK: - Sign Up
    static let PHONE_NUM_TITLE = "Phone number"._localizedKey
    static let EMAIL_TITLE = "Email"._localizedKey
    static let FILL_DATA_TITLE = "Please fill in a few details below"._localizedKey
    static let USER_TITLE = "User"._localizedKey
    static let BUSINESS_TITLE = "Business"._localizedKey
    static let PRIVACY_AGREE_TITLE = "By logging in or registering, you agree to our Terms of Service and Privacy Policy."._localizedKey
    static let NAME_TITLE = "Name"._localizedKey
    static let PASSWORD_TITLE = "Password"._localizedKey
    static let TERMS_TITLE = "Terms of Service"._localizedKey
    static let POLICY_TITLE = "Privacy Policy."._localizedKey

    // MARK: - Sign In
    static let SIGN_IN_PLACEHOLER = "Using jon.inventory@gmail.com to log in."._localizedKey
    static let FORGOT_TITLE = "Forgot Password?"._localizedKey

    // MARK: - Forgot Password
    static let FORGOT_PASSWORD_TITLE = "Forgot Password"._localizedKey
    static let SEND_TITLE = "Send"._localizedKey
    static let RESET_PASSWORD_Message = "We have sent a password reset email to your email address:\n{email}.\nPlease check your inbox to continue."._localizedKey

    // MARK: - Profile
    static let PROFILE_TITLE = "Profile"._localizedKey
    static let LOGOUT_TITLE = "Log out"._localizedKey
    static let DELETE_ACCOUNT_TITLE = "Delete account"._localizedKey
    static let FOLLOWERS_TITLE = "Followers"._localizedKey
    static let MESSAGES_TITLE = "Massages"._localizedKey
    static let MESSAGE_TITLE = "Massage"._localizedKey
    static let ACCOUNT_PRIVACY_TITLE = "Account Privacy"._localizedKey
    static let CONFIRM_LOGOUT_MESSAGE = "Are you sure you want to logout?"._localizedKey
    static let CONFIRM_DELETE_ACCOUNT_MESSAGE = "Are you sure you want to delete your account?"._localizedKey

    // MARK: - Edit Profile
    static let EDIT_PROFILE_TITLE = "Edit Profile"._localizedKey
    static let BIO_TITLE = "Bio"._localizedKey
    static let SAVE_TITLE = "Save"._localizedKey
    static let ADD_PHOTO_MESSSAGE = "Please add photo"._localizedKey
    static let ADD_COVER_PHOTO_MESSSAGE = "Please add cover photo"._localizedKey
    static let EDITED_SUCCESSFULLY_MESSAGE = "Edited successfully"._localizedKey

    // MARK: - Change Password
    static let CHANGE_PASS_TITLE = "Change Password"._localizedKey
    static let CURRENT_PASS_TITLE = "Current password"._localizedKey
    static let NEW_PASS_TITLE = "New password"._localizedKey
    static let REPEAT_PASS_TITLE = "Repeat password"._localizedKey
    static let CURRENT_PASS_INCORRECT_MESSAGE = "The current password is incorrect"._localizedKey
    static let NOT_SAME_PASS_MESSAGE = "The new password must not be the same as the current password"._localizedKey
    static let SAME_PASS_MESSAGE = "Ensure that the repeat password is the same as the new password"._localizedKey
    static let CHANGED_PASS_SUCCESSFULLY_MESSAGE = "Changed password successfully"._localizedKey

    // MARK: - Notification
    static let NOTIFY_TITLE = "Notification"._localizedKey
    static let NO_NOTIFY_EMPTY_TITLE = "There are no notification yet"._localizedKey

    // MARK: - Friend
    static let MY_FRIENDS_TITLE = "My Friends"._localizedKey
    static let UNFRIEND_TITLE = "Unfriend"._localizedKey
    static let ADD_TITLE = "Add"._localizedKey
    static let FRIENDS_EMPTY_TITLE = "There are no friends yet"._localizedKey

    // MARK: - Following
    static let FOLLOWING_TITLE = "Following"._localizedKey
    static let FOLLOWING_EMPTY_TITLE = "There are no Following yet"._localizedKey
    static let FOLLOWER_EMPTY_TITLE = "There are no Follower yet"._localizedKey

    // MARK: - Reservations
    static let MY_RESERVATIONS_TITLE = "My reservations"._localizedKey
    static let RESERVATIONS_EMPTY_TITLE = "You haven't made any reservations yet"._localizedKey

    // MARK: - Invite
    static let NEARBY_TITLE = "Nearby"._localizedKey
    static let INVITE_TITLE = "Invite"._localizedKey
    static let INVITED_TITLE = "Invited"._localizedKey
    static let INVITATION_BODY = "invited you"._localizedKey

    // MARK: - Favorite
    static let FAVORITE_TITLE = "Favorite"._localizedKey
    static let FAVORITE_EMPTY_TITLE = "There are no favorite places"._localizedKey

    // MARK: - Therapists Places
    static let THERAPISTS_PLACES_TITLE = "Therapists Places"._localizedKey
    static let THERAPISTS_PLACES_EMPTY_TITLE = "There are no therapists places"._localizedKey

    // MARK: - Place Info
    static let DESCRIPTION_TITLE = "Description"._localizedKey
    static let MESSAGE_THERAPISTS_TITLE = "Massage Therapists"._localizedKey
    static let THERAPISTS_EMPTY_TITLE = "There are no therapists"._localizedKey

    // MARK: - Orders
    static let ORDERS_TITLE = "Orders"._localizedKey
    static let PENDING_TITLE = "Pending"._localizedKey
    static let ACCEPTED_TITLE = "Accepted"._localizedKey
    static let ACCEPT_TITLE = "Accept"._localizedKey
    static let REJECT_TITLE = "Reject"._localizedKey
    static let REJECTED_TITLE = "Rejected"._localizedKey
    static let ORDERS_EMPTY_TITLE = "No orders received yet"._localizedKey
    static let ORDERS_EMPTY_ACCEPTED_TITLE = "No orders have been accepted yet"._localizedKey
    static let ACCEPT_RESERVATAION_BODY = "Accept reservation"._localizedKey

    // MARK: - Chat
    static let TODAY_TITLE = "Today"._localizedKey
    static let YESTERDAY_TITLE = "Yesterday"._localizedKey
    static let WRITE_PLACEHOLDER = "Write a message"._localizedKey

    // MARK: - Therapist
    static let MESSAGE_THERAPIST_TITLE = "Massage Therapist"._localizedKey
    static let FOLLOW_TITLE = "Follow"._localizedKey
    static let BOOK_NOW_TITLE = "Book Now"._localizedKey
    static let NEW_FOLLOWER_BODY = "{senderName} start following you"._localizedKey
    static let CONFIRM_REPORT_THERAPIST_MESSAGE = "Are you sure you want to report this therapist?"._localizedKey

    // MARK: - Posts
    static let SOCIAL_MEDIA_POSTS_TITLE = "Social Media Posts"._localizedKey
    static let POSTS_TITLE = "Posts"._localizedKey
    static let POST_EMPTY_TITLE = "There are no posts"._localizedKey
    static let DELETE_TITLE = "Delete"._localizedKey
    static let REPORT_TITLE = "Report"._localizedKey
    static let OPTION_TITLE = "Option"._localizedKey
    static let CONFIRM_REPORT_POST_MESSAGE = "Are you sure you want to report this post?"._localizedKey

    // MARK: - TherapistInfo
    static let INFO_TITLE = "Information"._localizedKey
    static let WORK_IN_TITLE = "Work in"._localizedKey

    // MARK: - BookNow
    static let SELECT_DATE_TITLE = "Select date & time"._localizedKey
    static let SUBMIT_TITLE = "Submit"._localizedKey
    static let INVALID_DATE_TIME_MESSAGE = "date & time"._localizedKey

    // MARK: - Post Detials
    static let POSTS_DETAILS_TITLE = "Post Details"._localizedKey
    static let COMMENTS_TITLE = "Comments"._localizedKey
    static let ADD_COMMENT_PLACEHOLDER = "Add a comment"._localizedKey
    static let TAKE_TOUR_TITLE = "Take a tour of Club {Club} - Dominican Republic [360°]"._localizedKey
    static let NO_COMMENTS_EMPTY_TITLE = "No comments yet"._localizedKey

    // MARK: - New Post
    static let NEW_POST_TITLE = "New Post"._localizedKey
    static let POST_TITLE = "Post"._localizedKey
    static let ASK_SOMTHING_PLACEHOLDER = "Ask Something"._localizedKey
    static let DESCRIPTION_POST_MESSAGE = "Description Post"._localizedKey
    static let INVALID_DESCRIPTION_POST_MESSAGE = "Description Post field is required"._localizedKey
    static let INVALID_LENGTH_DESCRIPTION_POST_MESSAGE = "The description posted is too long"._localizedKey

    // MARK: - Home User
    static let SEARCH_FREIENDS_PLACEHOLDER = "Search Here…"._localizedKey
    static let NO_RESULTS_TITLE = "No results found"._localizedKey

    // MARK: - Message
    static let MESSAGE_EMPTY_TITLE = "There are no message"._localizedKey
    static let NEW_MESSAGE_BODY = "sent you a new message"._localizedKey

    // MARK: - SelectLocation
    static let DETERMINE_LOCATION_TITLE = "You must allow an app to determine your location"
    static let LOCATION_PRIVACY_SETTINGS_MESSAGE = "Go to Settings > Privacy > Location Services."

    // MARK: - User Details
    static let NEW_FRIEND_BODY = "{senderName} is now your friend"._localizedKey
}
