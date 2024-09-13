//
//  NoteEditorView.swift
//  Notes
//
//  Created by Marco Alonso on 13/09/24.
//

import SwiftUI

struct NoteEditorView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var title: String
    @State private var content: String
    @State private var selectedCategoryName: String?
    let note: Note?
    let categories: [Category]
    let onSave: (Note) -> Void
    @Environment(\.dismiss) private var dismiss
    
    init(note: Note?, categories: [Category], onSave: @escaping (Note) -> Void) {
        self.note = note
        self.categories = categories
        self.onSave = onSave
        _title = State(initialValue: note?.title ?? "")
        _content = State(initialValue: note?.content ?? "")
        _selectedCategoryName = State(initialValue: note?.categoryName)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Título", text: $title)
                TextEditor(text: $content)
                Picker("Categoría", selection: $selectedCategoryName) {
                    Text("Sin categoría").tag(nil as String?)
                    ForEach(categories) { category in
                        Text(category.name).tag(category.name as String?)
                    }
                }
            }
            .navigationTitle(note == nil ? "Nueva Nota" : "Editar Nota")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        let updatedNote = Note(title: title, content: content, categoryName: selectedCategoryName)
                        onSave(updatedNote)
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
