//
//  SwiftUI_tutorialApp.swift
//  SwiftUI tutorial
//
//  Created by Maksim Gaiduk on 06/06/2023.
//

import SwiftUI

@main
struct SwiftUI_tutorialApp: App {
    @StateObject private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(modelData)
        }
    }
}
