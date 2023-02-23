//
//  ContentView.swift
//  Example1
//
//  Created by Maksim Gaiduk on 22/02/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Turtle Rock").font(.title)
//            HStack {
//                Text("Joshua Tree National Park").font(.subheadline)
//                Spacer()
//                Text("California").font(.subheadline)
//            }
//        }.padding()
        Grid(alignment: .leading) {
            GridRow {
                Text("Header")
            }
            Spacer()
            GridRow {
                Text("Content")
                Text("Content2")
            }
            Spacer()
            GridRow {
                Text("Footer")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
