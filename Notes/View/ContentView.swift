//
//  ContentView.swift
//  Notes
//
//  Created by Marco Alonso on 13/09/24.
// https://www.figma.com/design/LGaYwW5Htl7ucW9OclQ6KE/Expense-management-app-ui-kit-(Community)?node-id=0-1&node-type=canvas&t=kpF8sSrNtW2pCqvp-0

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
                        ForEach(categories) { category in
                            Button(action: { selectedCategoryName = category.name }) {
                                HStack {
                                    Image(systemName: category.iconName)
                                    Text(category.name)
                                }
                            }
                        } // For
                        Button(action: { selectedCategoryName = nil }) {
                            HStack {
                                Image(systemName: "tray.full")
                                Text("Todas las Notas")
                            } //Hstack
                        } //Button
                    }//Section
                    
                    Section(header: Text(selectedCategoryName ?? "Todas las notas")) {
                        ForEach(filteredNotes) { note in
                            VStack(alignment: .leading) {
                                Text(note.title)
                                    .font(.headline)
                                Text(note.content)
                                    .font(.subheadline)
                                    .lineLimit(3)
                                if let categoryName = note.categoryName,
                                   let category = categories.first(where: { $0.name == categoryName }) {
                                    HStack {
                                        Image(systemName: category.iconName)
                                        Text(categoryName)
                                        Text(formattedDate(note.createdAt))
                                    } // HStack
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                } // if let
                            } // VStack
                            .onTapGesture {
                                selectedNote = note
                            }
                        }
                        .onDelete(perform: deleteNotes)
                    }
                }// List
                .navigationTitle("Notas")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { isAddingNote = true }) {
                            // Label("Añadir Nota", systemImage: "plus")
                            Text("Añadir nota")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { isAddingCategory = true }) {
                            // Label("Añadir Categoría", systemImage: "folder.badge.plus")
                            Text("Añadir Categoría")
                        }
                    }
                }// toolbar
                .sheet(isPresented: $isAddingNote) {
                    NoteEditorView(note: nil, categories: categories) { newNote in
                        addNote(newNote)
                        isAddingNote = false
                    }
                } /// sheet
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
            
        }//Navigation
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES") // Configura la localización a español
        formatter.dateFormat = "EEEE dd MMMM" // Define el formato: "Jueves 18 septiembre"
        return formatter.string(from: date).capitalized // Capitaliza la primera letra
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
    
    private func deleteCategories(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(filteredNotes[index])
        }
    }
}


