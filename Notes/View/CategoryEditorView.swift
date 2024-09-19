//
//  CategoryEditorView.swift
//  Notes
//
//  Created by Marco Alonso on 13/09/24.
//

import SwiftUI

struct CategoryEditorView: View {
    @State private var name: String = ""
    @State private var selectedIcon: String = "folder"
    let onSave: (Category) -> Void
    @Environment(\.dismiss) private var dismiss
    
    let icons = ["folder", "bookmark", "star", "flag", "bell", "clock", "calendar", "house", "car", "person"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nombre de la categoría", text: $name)
                
                Picker("Icono", selection: $selectedIcon) {
                    ForEach(icons, id: \.self) { icon in
                        Image(systemName: icon).tag(icon)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .navigationTitle("Nueva Categoría")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        let newCategory = Category(name: name, iconName: selectedIcon)
                        onSave(newCategory)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
    }
}
