//
//  ContentView.swift
//  Example2
//
//  Created by Maksim Gaiduk on 23/02/2023.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        Form {
            Section {
                VStack {
                    Text("TextInput")
                        .overlay(alignment: .topTrailing) {
                            Text("SuggestOptions")
                                .frame(minHeight: 400)
                                .background(Color.green)
                                .offset(x: 25, y: 25)
                                .opacity(0.5)
                        }
                }
                .frame(minHeight: 400, alignment: .topLeading)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
