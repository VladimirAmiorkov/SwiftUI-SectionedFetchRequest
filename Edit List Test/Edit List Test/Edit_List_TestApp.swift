//
//  Edit_List_TestApp.swift
//  Edit List Test
//
//  Created by Vladimir Amiorkov on 10.12.24.
//

import SwiftUI

@main
struct Edit_List_TestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
