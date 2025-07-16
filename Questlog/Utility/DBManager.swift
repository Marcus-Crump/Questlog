//
//  DBManager.swift
//  Questlog
//
//  Created by Mars on 7/12/25.
//

import Foundation
import CoreData

// ObservableObject allows SwiftUI to watch this class for changes
class DBManager: ObservableObject {
    // NSPersistentContainer manages the Core Data stack and database connection
    let container = NSPersistentContainer(name: "ToDoModel")
    // Contains these Core Data pieces:
    // - Managed Object Model (data schema)
    // - Persistent Store Coordinator (database connection manager) 
    // - Managed Object Context (data workspace)
    // - Persistent Stores (actual database files)

    // Initialize the DBManager and set up Core Data
    init() {
        // Load the persistent stores (database files) from disk
        container.loadPersistentStores { _, error in
            if let error = error {
                // If loading fails, print the error
                print("Core Data failed to load: \(error)")
            }
        }
    }
}
    
// MARK: - List Management
extension DBManager {
    // All ListEntity-related methods
    func createList(name: String, description: String, notes: String,
     priority: Int16) {
        let newList = ListEntity(context: container.viewContext)
        newList.name = name
        newList.desc = description
        newList.notes = notes
        newList.priority = priority
        saveContext()
    }
    func updateList(_ list: ListEntity, name: String, description: String,
     notes: String, priority: Int16) {
        list.name = name
        list.desc = description
        list.notes = notes
        list.priority = priority
        saveContext()
    }

    func getAllLists() -> [ListEntity] {
        let request = ListEntity.fetchRequest()
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Failed to fetch lists: \(error)")
            return []
        }
    }

    func getListByName(_ name: String) -> ListEntity? {
        let request = ListEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        do {
            return try container.viewContext.fetch(request).first
        }
    }

    func getListByPriority(_ priority: Int16) -> ListEntity? {
        let request = ListEntity.fetchRequest()
        request.predicate = NSPredicate(format: "priority == %d", priority)
        do {
            return try container.viewContext.fetch(request).first
        }
    }

    func getNumberOfLists() -> Int {
        let request = ListEntity.fetchRequest()
        do {
            return try container.viewContext.count(for: request)
        } catch {
            print("Failed to fetch number of lists: \(error)")
            return 0
        }
    }

    func deleteList(_ list: ListEntity) {
        container.viewContext.delete(list)
        saveContext()
    }
}
    
// MARK: - ToDo Management
extension DBManager {
    // All ToDoItemEntity-related methods
    func createToDoItem(title: String, description: String, difficulty: Int, 
    comTime: Int, notes: String, dueDate: Date, in list: ListEntity) {
        let newToDoItem = ToDoItemEntity(context: container.viewContext)
        newToDoItem.name = title
        newToDoItem.desc = description
        newToDoItem.dateAdded = Date()
        newToDoItem.dateDue = dueDate
        newToDoItem.difficulty = Int16(difficulty)
        newToDoItem.comTime = Int16(comTime)
        newToDoItem.notes = notes
        newToDoItem.list = list
        saveContext()
    }
    func getItemsForList(_ list: ListEntity) -> [ToDoItemEntity] {
        return list.items?.allObjects as? [ToDoItemEntity] ?? []
    }
    func deleteItem(_ item: ToDoItemEntity) {
        container.viewContext.delete(item)
        saveContext()
    }
    func updateItem(_ item: ToDoItemEntity, title: String, description: String, 
    difficulty: Int, etc: String, notes: String, dueDate: Date) {
        item.name = title
        item.desc = description
        item.difficulty = Int16(difficulty)
        item.notes = etc
        item.notes = notes
        item.dateDue = dueDate
        saveContext()
    }
    }
    
    // MARK: - Utility Functions
extension DBManager {
    // Utility methods for saving and fetching
    private func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
    func getItemsDueToday() -> [ToDoItemEntity] {
        let request = ToDoItemEntity.fetchRequest()
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

    func deleteAllData() {
    let context = container.viewContext

    // Delete all ListEntity objects
    let listRequest = ListEntity.fetchRequest() // Create a fetch request for all ListEntity objects
    if let lists = try? context.fetch(listRequest) as? [ListEntity] { // Try to fetch all lists; if successful, cast to [ListEntity]
        for list in lists { // Loop through each list in the array
            context.delete(list) // Mark the list for deletion in the context
        }
    }

    // Delete all ToDoItemEntity objects
    let itemRequest = ToDoItemEntity.fetchRequest()
    if let items = try? context.fetch(itemRequest) as? [ToDoItemEntity] {
        for item in items {
            context.delete(item)
        }
    }

    // Save changes
    try? context.save()
    }
}
