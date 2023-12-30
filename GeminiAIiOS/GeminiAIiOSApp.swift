//
//  GeminiAIiOSApp.swift
//  GeminiAIiOS
//
//  Created by @TechHabiles on 27/12/23.
//

import SwiftUI

@main
struct GeminiAIiOSApp: App {
    @StateObject var viewModel: GeminiViewModel = GeminiViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                MainView()
            }.environmentObject(viewModel) // View Model to be used on all the screens
                                           // Can be received using @EnvironmentObject in child screens
        }
    }
}
