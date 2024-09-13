//
//  CategoryEditorView.swift
//  Notes
//
//  Created by Marco Alonso on 13/09/24.
//

import SwiftUI

struct CategoryEditorView: View {
    @State private var name: String = ""
    let onSave: (Category) -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nombre de la categoría", text: $name)
            }
            .navigationTitle("Nueva Categoría")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        let newCategory = Category(name: name)
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
