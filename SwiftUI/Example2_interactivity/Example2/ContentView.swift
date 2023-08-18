//
//  ContentView.swift
//  MyAudioPlayerApp
//
//  Created by test on 4/18/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.46), Color(red: 0.66, green: 0.2, blue: 0.26)], startPoint: UnitPoint(x: 0.0, y: 0.0), endPoint: UnitPoint(x: 0, y: 1))
                .ignoresSafeArea()
            Form {
                Section(header: Text("Section 1")) {
                    Text("Row 1")
                    Text("Row 2")
                }
                
                Section(header: Text("Section 2")) {
                    Text("Row 3")
                    Text("Row 4")
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
