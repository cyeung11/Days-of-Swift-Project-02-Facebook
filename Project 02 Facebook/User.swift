//
//  User.swift
//  Project 02 Facebook
//
//  Created by Chris on 18/8/2018.
//  Copyright © 2018 Chris. All rights reserved.
//

import Foundation

struct User {
    let photo: String
    let name: String
    let educationName: String
    
    init(name: String, photo: String, educationName: String) {
        self.name = name
        self.photo = photo
        self.educationName = educationName
    }
}
