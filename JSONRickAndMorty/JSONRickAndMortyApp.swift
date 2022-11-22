//
//  JSONRickAndMortyApp.swift
//  JSONRickAndMorty
//
//  Created by Appa on 21/11/22.
//

import SwiftUI

@main
struct JSONRickAndMortyApp: App {
    @StateObject var modelo: ConsultarModelView = ConsultarModelView()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelo)
        }
    }
}
