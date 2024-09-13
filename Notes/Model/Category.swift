//
//  Category.swift
//  Notes
//
//  Created by Marco Alonso on 13/09/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class Category {
    var name: String
    var iconName: String
    
    init(name: String, iconName: String) {
        self.name = name
        self.iconName = iconName
    }
}
