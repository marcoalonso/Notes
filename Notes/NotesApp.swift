//
//  NotesApp.swift
//  Notes
//
//  Created by Marco Alonso on 13/09/24.
//

import SwiftUI
import SwiftData

@main
struct NotesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Note.self)
    }
}
