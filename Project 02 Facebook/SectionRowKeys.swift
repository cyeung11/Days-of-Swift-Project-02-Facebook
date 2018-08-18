//
//  SectionRowKeys.swift
//  Project 02 Facebook
//
//  Created by Chris on 18/8/2018.
//  Copyright © 2018 Chris. All rights reserved.
//

import Foundation

struct SelectionRowKeys {
    
    static let allSections = [Section.userProfile, .pages, .favorites, .settings, .logOut]
    
    enum Section{
        case userProfile
        case pages
        case favorites
        case settings
        case logOut
        
        func title() -> String? {
            return self == .favorites ?"Favorites" :nil
        }
        
        func child(isExpanded: Bool) -> [Row] {
            switch self {
            case .userProfile:
                return [ .userProfile]
            case .pages:
                return isExpanded ?[.friends, .events, .groups, .home, .education, .saved, .notes, .jobs, .seeMore] :[.friends, .events, .groups, .home, .education, .seeMore]
            case .favorites:
                return [.addFavorite]
            case .settings:
                return [.settings, .privacy, .help]
            case .logOut:
                return [.logOut]
            }
        }
    }
    
    enum Row {
        case userProfile
        case friends
        case events
        case groups
        case home
        case education
        case saved
        case notes
        case jobs
        case seeMore
        case addFavorite
        case settings
        case privacy
        case help
        case logOut
        
        func title(withUser user: User, isExpanded: Bool) -> String? {
            switch self {
            case .userProfile:
                return user.name
            case .friends:
                return "Friends"
            case .events:
                return "Events"
            case .groups:
                return "Groups"
            case .home:
                return "Home"
            case .education:
                return user.educationName
            case .saved:
                return "Saved"
            case .notes:
                return "Notes"
            case .jobs:
                return "Jobs"
            case .seeMore:
                return isExpanded ?"See Less" :"See More..."
            case .addFavorite:
                return "Add Favorites..."
            case .settings:
                return "Settings"
            case .privacy:
                return "Privacy Shortcuts"
            case .help:
                return "Help and Support"
            case .logOut:
                return "Logout"
            }
        }
        
        func image(withUser user: User) -> String? {
            switch self {
            case .userProfile:
                return user.photo
            case .friends:
                return "fb_friends"
            case .events:
                return "fb_events"
            case .groups:
                return "fb_groups"
            case .home:
                return "fb_home"
            case .education:
                return "fb_education"
            case .saved:
                return "fb_saved"
            case .notes:
                return "fb_notes"
            case .jobs:
                return "fb_jobs"
            case .settings:
                return "fb_settings"
            case .privacy:
                return "fb_privacy_shortcuts"
            case .help:
                return "fb_help_and_support"
            case .seeMore, .addFavorite, .logOut:
                return nil
            }
        }
        
        func rowHeight() -> Double {
            switch self {
            case .userProfile:
                return 75.0
            default:
                return 45.0
            }
        }
    }
}
