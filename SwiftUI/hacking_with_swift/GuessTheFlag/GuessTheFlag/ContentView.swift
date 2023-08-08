//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Maksim Gaiduk on 20/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var flag = false
    @State private var name = ""
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your name", text: $name)
                Button("Play") {
                    flag = true
                }.alert(Text("Enter your name"), isPresented: $flag) {
                    Button("Start") {
                        
                    }
                } message: {
                    TextField("Enter your name", text: $name)
                }
                NavigationLink {
                    PlayView()
                } label: {
                    Text("Play")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
