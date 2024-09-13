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
    
    init(name: String) {
        self.name = name
    }
}
