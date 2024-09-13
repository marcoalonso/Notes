//
//  Note.swift
//  Notes
//
//  Created by Marco Alonso on 13/09/24.
//

import SwiftUI
import SwiftData

@Model
class Note {
    var title: String
    var content: String
    var createdAt: Date
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
        self.createdAt = Date()
    }
}
