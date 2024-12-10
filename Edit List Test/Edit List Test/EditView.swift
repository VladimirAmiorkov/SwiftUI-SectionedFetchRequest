//
//  EditView.swift
//  Edit List Test
//
//  Created by Vladimir Amiorkov on 10.12.24.
//

import SwiftUI

struct EditView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject private var book: Item
    
    init(book: Item) {
        print("Init hit")
        self.book = book
    }
    
    
    var body: some View {
        VStack {
            Text("Item at \(book.timestamp!, formatter: itemFormatter)")
            Text("Text - \(book.text!)")
            
            Button {
                book.text = book.text! + " " + "\(Int.random(in: 1...9))"
                
                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            } label: {
                Text("Change text")
            }

        }
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}

//#Preview {
//    EditView()
//}
