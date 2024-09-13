//
//  Note.swift
//  Notes
//
//  Created by Marco Alonso on 13/09/24.
//

import SwiftUI
import SwiftData

@Model
final class Note {
    var title: String
    var content: String
    var createdAt: Date
    var categoryName: String?
    
    init(title: String, content: String, categoryName: String? = nil) {
        self.title = title
        self.content = content
        self.createdAt = Date()
        self.categoryName = categoryName
    }
}
