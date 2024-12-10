//
//  ContentView.swift
//  Edit List Test
//
//  Created by Vladimir Amiorkov on 10.12.24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    // Test 1 - start
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    // Test 1 - end
    
    // Test 2 - start
    @SectionedFetchRequest<Int16, Item>(
        sectionIdentifier: \.category,
        sortDescriptors: [SortDescriptor(\.category)]
    )
    private var items: SectionedFetchResults<Int16, Item>
    
    // Test 2 - end
   

    var body: some View {
        NavigationView {
            List {
                // Test 1 - start
                
//                ForEach(items) { item in
//                    NavigationLink {
//                        EditView(book: item)
//                    } label: {
//                        VStack {
//                            Text(item.timestamp!, formatter: itemFormatter)
//                            Text("Text - \(item.text!)")
//                        }
//                    }
//                }
                
                // Test 1 - end

                // Test 2 - start
                
                ForEach(items) { section in
                    Section {
                        ForEach(section) { item in
                            NavigationLink {
                                EditView(book: item)
                            } label: {
                                VStack {
                                    Text(item.timestamp!, formatter: itemFormatter)
                                    Text("Text - \(item.text!)")
                                }
                            }
                        }
                    } header: {
                        Text("ID: \(section.id)")
                    }
                }
                
                // Test 2 - end
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.category = 1
            newItem.name = "\(Date())"
            newItem.text = "0"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
