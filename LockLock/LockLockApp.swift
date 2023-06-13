//
//  LockLockApp.swift
//  LockLock
//
//  Created by Devin Maleke on 20/03/23.
//

import SwiftUI
import Firebase

@main
struct LockLockApp: App {
    @StateObject var dbQuery = DBQuery()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(dbQuery)
        }
    }
}
