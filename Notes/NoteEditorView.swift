//
//  NoteEditorView.swift
//  Notes
//
//  Created by Marco Alonso on 13/09/24.
//

import SwiftUI

struct NoteEditorView: View {
    let note: Note?
    let onSave: (Note) -> Void
    @State private var title: String
    @State private var content: String
    @Environment(\.dismiss) private var dismiss
    
    init(note: Note?, onSave: @escaping (Note) -> Void) {
        self.note = note
        self.onSave = onSave
        _title = State(initialValue: note?.title ?? "")
        _content = State(initialValue: note?.content ?? "")
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Título", text: $title)
                TextEditor(text: $content)
            }
            .navigationTitle(note == nil ? "Nueva Nota" : "Editar Nota")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        let newNote = Note(title: title, content: content)
                        onSave(newNote)
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
