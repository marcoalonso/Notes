//
//  ContentView.swift
//  Notes
//
//  Created by Marco Alonso on 13/09/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var categories: [Category]
    @Query private var notes: [Note]
    @State private var isAddingNote = false
    @State private var isAddingCategory = false
    @State private var selectedCategoryName: String?
    @State private var selectedNote: Note?
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Categorías")) {
                    Button("Todas las Notas") {
                        selectedCategoryName = nil
                    }
                    ForEach(categories) { category in
                        Button(category.name) {
                            selectedCategoryName = category.name
                        }
                    }
                }
                
                Section(header: Text("Notas")) {
                    ForEach(filteredNotes) { note in
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                            Text(note.content)
                                .font(.subheadline)
                                .lineLimit(2)
                            if let categoryName = note.categoryName {
                                Text(categoryName)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .onTapGesture {
                            selectedNote = note
                        }
                    }
                    .onDelete(perform: deleteNotes)
                }
            }
            .navigationTitle("Notas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isAddingNote = true }) {
                        Label("Añadir Nota", systemImage: "square.and.pencil")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isAddingCategory = true }) {
                        Label("Añadir Categoría", systemImage: "folder.badge.plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingNote) {
                NoteEditorView(note: nil, categories: categories) { newNote in
                    addNote(newNote)
                    isAddingNote = false
                }
            }
            .sheet(item: $selectedNote) { note in
                NoteEditorView(note: note, categories: categories) { updatedNote in
                    updateNote(note, with: updatedNote)
                    selectedNote = nil
                }
            }
            .sheet(isPresented: $isAddingCategory) {
                CategoryEditorView { newCategory in
                    addCategory(newCategory)
                    isAddingCategory = false
                }
            }
        }
    }
    
    private var filteredNotes: [Note] {
        guard let categoryName = selectedCategoryName else {
            return notes
        }
        return notes.filter { $0.categoryName == categoryName }
    }
    
    private func addNote(_ note: Note) {
        modelContext.insert(note)
    }
    
    private func updateNote(_ note: Note, with updatedNote: Note) {
        note.title = updatedNote.title
        note.content = updatedNote.content
        note.categoryName = updatedNote.categoryName
    }
    
    private func addCategory(_ category: Category) {
        modelContext.insert(category)
    }
    
    private func deleteNotes(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(filteredNotes[index])
        }
    }
}


