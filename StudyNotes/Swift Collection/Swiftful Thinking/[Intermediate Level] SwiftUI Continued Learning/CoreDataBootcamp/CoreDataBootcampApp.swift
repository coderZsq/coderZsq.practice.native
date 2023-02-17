//
//  CoreDataBootcampApp.swift
//  CoreDataBootcamp
//
//  Created by 朱双泉 on 2023/2/8.
//

import SwiftUI

@main
struct CoreDataBootcampApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
