//
//  ListDetailView.swift
//  Questlog
//
//  Created by M on 7/16/25.
//

import Foundation
import SwiftUI

struct ListDetailView: View {
    @Binding var page: String
    @ObservedObject var dbManager: DBManager
    @Binding var lst: ListEntity?
    
    var body: some View{
        ZStack{
            
            Image("Stars")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack(spacing: 10){
                
                HStack{
                    Spacer()
                    Button(action: {
                        page = "Lists"
                    }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.black)
                            .padding(.top, 50)
                    }
                    Text(lst?.name ?? "Error")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 50)
                    
                    Button(action: {
                        page = "CreateList"
                    }) {
                        Image("WriteNewThing")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }

                    Button(action: {
                        page = "ToDo"
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                Spacer()
                }

                ForEach(Array(lst?.items as? Set<ToDoItemEntity> ?? []), id: \.self) { item in
                    Button(action: {
                        
                        page = "ToDo"
                    }) {
                        Text(item.name ?? "")
                    }
                }

            }
        }
    }
}

#Preview {
    @State var testList: ListEntity? = {
        let listContext = PersistenceController.preview.container.viewContext
        let lst = ListEntity(context: listContext)
        lst.name = "Test List"
        lst.desc = "Test Description"
        lst.notes = "Test Notes"
        return lst
    }()
    return ListDetailView(page: .constant("ListDetail"), dbManager: DBManager(), lst: $testList)
}
