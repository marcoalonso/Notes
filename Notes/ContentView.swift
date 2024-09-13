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
        @Query private var notes: [Note]
        @State private var isAddingNote = false
        @State private var editingNote: Note?
        
        var body: some View {
            NavigationView {
                List {
                    ForEach(notes) { note in
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                            Text(note.content)
                                .font(.subheadline)
                                .lineLimit(2)
                        }
                        .onTapGesture {
                            editingNote = note
                        }
                    }
                    .onDelete(perform: deleteNotes)
                }
                .navigationTitle("Notas")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { isAddingNote = true }) {
                            Label("Añadir Nota", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $isAddingNote) {
                    NoteEditorView(note: nil) { newNote in
                        addNote(newNote)
                        isAddingNote = false
                    }
                }
                .sheet(item: $editingNote) { note in
                    NoteEditorView(note: note) { updatedNote in
                        updateNote(note, with: updatedNote)
                        editingNote = nil
                    }
                }
            }
        }
        
        private func addNote(_ note: Note) {
            modelContext.insert(note)
        }
        
        private func deleteNotes(at offsets: IndexSet) {
            for index in offsets {
                modelContext.delete(notes[index])
            }
        }
        
        private func updateNote(_ note: Note, with updatedNote: Note) {
            note.title = updatedNote.title
            note.content = updatedNote.content
        }
    }


