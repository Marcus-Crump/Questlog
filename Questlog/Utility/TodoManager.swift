//
//  TodoManager.swift
//  Questlog
//
//  Created by Mars on 7/12/25.
//

import Foundation
import CoreData

// ObservableObject allows SwiftUI to watch this class for changes
class TodoManager: ObservableObject {
    // NSPersistentContainer manages the Core Data stack and database connection
    let container = NSPersistentContainer(name: "ToDoModel")
    // Contains these Core Data pieces:
    // - Managed Object Model (data schema)
    // - Persistent Store Coordinator (database connection manager) 
    // - Managed Object Context (data workspace)
    // - Persistent Stores (actual database files)

    // Initialize the TodoManager and set up Core Data
    init() {
        // Load the persistent stores (database files) from disk
        container.loadPersistentStores { _, error in
            if let error = error {
                // If loading fails, print the error
                print("Core Data failed to load: \(error)")
            }
        }
    }
    
    // MARK: - TodoList Management
    
    // Create a new todo list
    func createList(name: String) {
        // Create a new ToDoListEntity entity in the Core Data context
        let newList = ToDoListEntity(context: container.viewContext)
        newList.name = name  // Set the list name	
        
        // Save changes to the database
        saveContext()
    }
    
    // Get all todo lists
    func getAllLists() -> [ToDoListEntity] {
        // Create a fetch request for ToDoListEntity entities
        let request = ToDoListEntity.fetchRequest()
        
        do {
            // Execute the fetch request and return the results
            return try container.viewContext.fetch(request)
        } catch {
            // If fetch fails, print error and return empty array
            print("Failed to fetch lists: \(error)")
            return []
        }
    }
    
    // Delete a todo list and all its items (cascade delete)
    func deleteList(_ list: ToDoListEntity) {
        // Remove the list from the context
        container.viewContext.delete(list)
        // Save changes (this will also delete all related items due to cascade rule)
        saveContext()
    }
    
    // MARK: - TodoItem Management
    
    // Create a new todo item in a specific list
    func createToDoItem(title: String, description: String, difficulty: Int, 
    etc: Int, notes: String, dueDate: Date, in list: ToDoListEntity) {
        // Create a new ToDoItemEntity entity in the Core Data context
        let newToDoItem = ToDoItemEntity(context: container.viewContext)
        
        // Set all the item properties
        newToDoItem.name = title
        newToDoItem.desc = description  // Note: might be different from your struct
        newToDoItem.completed = false  // New items start as incomplete
        newToDoItem.dateAdded = Date()
        newToDoItem.dateDue = dueDate
        newToDoItem.difficulty = Int16(difficulty)
        newToDoItem.notes = notes
        
        // Connect the item to its parent list
        newToDoItem.list = list
        
        // Save changes to the database
        saveContext()
    }
    
    // Get all items in a specific list
    func getItemsForList(_ list: ToDoListEntity) -> [ToDoItemEntity] {
        // Use the relationship to get all items in this list
        return list.items?.allObjects as? [ToDoItemEntity] ?? []
    }
    
    // Update an item's completion status
    func toggleItemCompletion(_ item: ToDoItemEntity) {
        // Toggle the completed status
        item.completed.toggle()
        // Save changes
        saveContext()
    }
    
    // Delete a specific item
    func deleteItem(_ item: ToDoItemEntity) {
        // Remove the item from the context
        container.viewContext.delete(item)
        // Save changes
        saveContext()
    }
    
    // Update an item's properties
    func updateItem(_ item: ToDoItemEntity, title: String, description: String, 
    difficulty: Int, etc: String, notes: String, dueDate: Date) {
        // Update all the item properties
        item.name = title
        item.desc = description
        item.difficulty = Int16(difficulty)
        item.notes = etc
        item.notes = notes
        item.dateDue = dueDate
        
        // Save changes
        saveContext()
    }
    
    // MARK: - Utility Functions
    
    // Save the current context to persist changes
    private func saveContext() {
        // Check if there are any changes to save
        if container.viewContext.hasChanges {
            do {
                // Try to save the changes
                try container.viewContext.save()
            } catch {
                // If save fails, print the error
                print("Failed to save context: \(error)")
            }
        }
    }
    
    // Get items due today
    func getItemsDueToday() -> [ToDoItemEntity] {
        let request = ToDoItemEntity.fetchRequest()
        
        // Create a predicate to filter items due today
        let today = Calendar.current.startOfDay(for: Date())
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        
        request.predicate = NSPredicate(
            format: "dueDate >= %@ AND dueDate < %@", today as NSDate, 
            tomorrow as NSDate
            )
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Failed to fetch items due today: \(error)")
            return []
        }
    }
    
    // Get items by difficulty level
    func getItemsByDifficulty(_ difficulty: Int) -> [ToDoItemEntity] {
        let request = ToDoItemEntity.fetchRequest()
        request.predicate = NSPredicate(format: "difficulty == %d", Int16(difficulty))
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Failed to fetch items by difficulty: \(error)")
            return []
        }
    }
}
