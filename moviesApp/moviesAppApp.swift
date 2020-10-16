//
//  moviesAppApp.swift
//  moviesApp
//
//  Created by Francisco Misael Landero Ychante on 07/10/20.
//

import SwiftUI

@main
struct moviesAppApp: App {
    let stateController = StateController()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(stateController)
        }
    }
}
