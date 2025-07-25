//
//  ToDoItemCreationView.swift
//  Questlog
//
//  Created by Mars on 7/13/25.
//
import Foundation
import SwiftUI

struct ToDoItemCreationView: View {
    @Binding var page: Page
    @EnvironmentObject var dbManager: DBManager
    @EnvironmentObject var history: HistoryStack
    @Binding var lst: ListEntity?
    @Binding var todoState: ToDoItemEntity?
    @State private var itemDifficulty = 1
    @State private var estHours = 0
    @State private var estMinutes = 0
    @State private var month = Calendar.current.component(.month, from: Date())
    @State private var day = Calendar.current.component(.day, from: Date())
    @State private var year = Calendar.current.component(.year, from: Date()) 
    @State private var curYear = Calendar.current.component(.year, from: Date())// Gets the current year
    @State private var months: [String] = ["",
        "January", "February", "March", "April", "May", "June", "July",
        "August", "September", "October", "November", "December"]
    @State private var daysInMonth: [Int] = [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    var timeNMin: Int {
        return (60*estHours)+estMinutes
    }
    
    var itemDueDate: Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components) ?? Date()
    }

    var validName: Bool {
        guard let name = lst?.name else { return false }
        return !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var validTime: Bool {
        return (estHours != 0 || estMinutes != 0)
    }

    var validDate: Bool {
        return (dateIsAfter(day: day, month: month, year: year) ||
         dateIsEqual(day: day, month: month, year: year))
    }

    var isValid: Bool {
        return (validName && validTime && validDate)
    }
    
    var body: some View {
        ZStack {
            Background()
            
            ScrollView {
                VStack(spacing: 32) { // More space between sections
                    // Header
                    HStack {
                        Button(action: {
                            if let item = todoState {
                                dbManager.deleteItem(item)
                            }
                            page = history.pop() ?? .createList
                        }) {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundStyle(Color.black)
                                .padding(.top, 50)
                        }
                        Text("ToDo Creation")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 45)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    // Item Name
                    VStack(alignment: .center, spacing: 2) {
                        
                        TextField("Item Name...", text: Binding(
                            get: { todoState?.name ?? "" },
                            set: { todoState?.name = $0 }
                        ))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 350)
                        // Description input using TextEditor
                        VStack(alignment: .leading) {
                            // Text("Description") // Label for clarity
                            //     .font(.headline)
                            ZStack(alignment: .topLeading) {
                                // Placeholder text, only visible when itemDescription is empty
                                
                                // The actual TextEditor
                                TextEditor(text: Binding(
                                    get: { todoState?.desc ?? "" },
                                    set: { todoState?.desc = $0 }
                                ))
                                    .frame(minHeight: 40, maxHeight: 75)
                                    .padding(4)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                    )
                                if todoState?.desc?.isEmpty ?? true {
                                    Text("Description...")
                                        .foregroundColor(.gray.opacity(0.5))
                                        .padding(8) // Match TextEditor's padding
                                }
                            }
                            .frame(width: 350)
                        }
                        .frame(width: 350) // Match your other fields
                        
                        // Notes input using TextEditor
                        VStack(alignment: .leading) {
                            // Text("Notes") // Label for clarity
                            //     .font(.headline)
                            ZStack(alignment: .topLeading) {
                                // Placeholder text, only visible when itemNotes is empty
                                
                                // The actual TextEditor
                                TextEditor(text: Binding(
                                    get: { todoState?.notes ?? "" },
                                    set: { todoState?.notes = $0 }
                                ))
                                    .frame(minHeight: 40, maxHeight: 75)
                                    .padding(4)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                    )
                                    if todoState?.notes?.isEmpty ?? true {
                                    Text("Notes...")
                                        .foregroundColor(.gray.opacity(0.5))
                                        .padding(8) // Match TextEditor's padding
                                }
                            }
                            .frame(width: 350)
                        }
                        .frame(width: 350) // Match your other fields
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    // Estimated Completion Time (lines 62–74)
                    VStack(alignment: .center, spacing: 0) {
                        Text("Estimated Completion Time (HH:MM)") // Label for the picker
                            .font(.headline)
                        HStack {
                            // Hours picker (0–12)
                            Picker("Hours", selection: $estHours) {
                                ForEach(0..<13) { hour in
                                    Text("\(hour) h").tag(hour)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 80, height: 50)
                            .clipped()
                            // Minutes picker (0, 15, 30, 45)
                            Picker("Minutes", selection: $estMinutes) {
                                ForEach(0..<60, id: \.self) { min in
                                    Text(String(format: "%02d m", min)).tag(min)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 80, height:50)
                            .clipped()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 10)

                    // Difficulty
                    VStack(alignment: .center, spacing: 2) {
                        Text("Difficulty")
                            .font(.headline)
                        Picker("Difficulty", selection: Binding(
                            get: { todoState?.difficulty ?? 1 },
                            set: { todoState?.difficulty = $0 }
                        )) {
                            ForEach(1..<11) { num in
                                Text("\(num)").tag(num)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 350, height: 20)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    Spacer()
                    VStack(alignment: .center, spacing: 0) {
                        Text("Due Date (MM:DD:YYYY)") // Label for the picker
                            .font(.headline)
                        HStack(spacing: -10) {
                            // Month picker (0–12)
                            Picker("Month", selection: $month) {
                                ForEach(1..<13) { month in
                                    Text("\(months[month])").tag(month)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 150, height: 50)
                            .clipped()
                            // Day picker that updates when month changes
                            Picker("Day", selection: $day) {
                                ForEach(1...daysInMonth[month], id: \.self) { day in
                                    Text(String(format: "%02d", day)).tag(day)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 80, height: 50)
                            .clipped()
                            .id(month) // Forces the Picker to refresh when month changes
                            // Year picker (0–12)
                            Picker("Year", selection: $year) {
                                ForEach(curYear..<(curYear+10)) { year in
                                    Text(String(format: "%d", year)).tag(year)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 80, height:50)
                            .clipped()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 10)
                }
                .padding(.top, 20)
                .frame(maxWidth: .infinity, alignment: .center)
                Button(action: {
                    if let item = todoState {
                        dbManager.updateItem(item,
                            title: item.name ?? "",
                            description: item.desc ?? "",
                            difficulty: itemDifficulty,
                            notes: item.notes ?? "",
                            dueDate: itemDueDate
                        )
                    }
                    page = history.pop() ?? .createList
                }) {
                    Text("Create ToDo")
                        .font(.headline)
                        .padding()
                        .background(isValid ? Color.brown.opacity(0.50) : Color.brown.opacity(0.25))
                        .cornerRadius(10)
                        .foregroundColor(isValid ? .black : .black.opacity(0.25))
                }
                .disabled(!isValid)
                
            }
        }
        .onAppear {
            print(history.history)
            if todoState == nil {
                // Create a new ToDoItemEntity in the context
                if let list = lst {
                    dbManager.createToDoItem(title: "New ToDo", 
                    description: "New Description", difficulty: 1, comTime: 0,
                    notes: "New Notes", dueDate: Date(), in: list) 
                    todoState = dbManager.getItemsForList(list).last
                }
            }
            // else: todoState is already set, so just use it
        }
    }
}


#Preview {
    @State var testList: ListEntity? = {
        let listContext = PersistenceController.preview.container.viewContext
        let lst = ListEntity(context: listContext)
        lst.name = "Test List"
        lst.priority = 1
        lst.desc = "Test Description"
        lst.notes = "Test Notes"
        return lst
    }()
    @State var testTodo: ToDoItemEntity? = {
        let todoContext = PersistenceController.preview.container.viewContext
        let todo = ToDoItemEntity(context: todoContext)
        todo.name = "Test ToDo"
        todo.difficulty = 1
        todo.comTime = 1
        todo.desc = "Test Description"
        todo.notes = "Test Notes"
        todo.dateDue = Date()
        todo.list = testList
        return todo
    }()
    
    return ToDoItemCreationView(page: .constant(.toDo), lst: $testList, todoState: $testTodo)
        .environmentObject(DBManager())
        .environmentObject(HistoryStack())
}
