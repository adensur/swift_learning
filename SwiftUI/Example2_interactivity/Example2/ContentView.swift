//
//  ContentView.swift
//  Example2
//
//  Created by Maksim Gaiduk on 23/02/2023.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        List {
            Section {
                Text("Bottom")
            }.overlay(alignment: .topTrailing) {
                Text("Top")
                    .frame(minHeight: 400)
                    .background(Color.green)
                    .offset(y: 25)
            }
            
            Section{
                Text("Form2")
            }
            Section{
                Text("Form3")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
