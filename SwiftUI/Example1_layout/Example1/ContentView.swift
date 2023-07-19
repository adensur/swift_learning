//
//  ContentView.swift
//  Example1
//
//  Created by Maksim Gaiduk on 22/02/2023.
//

import SwiftUI

struct MyStruct {
    
}

struct ContentView: View {
    var body: some View {
        Grid(alignment: .leading) {
            /*
            for i in 0...5 {
                GridRow {
                    Text("Row #\(i)")
                }
            }*/
            var flag = false
            if flag {
                GridRow {
                    Text("Header")
                }
            } else {
                GridRow {
                    Text("HeaderFalse")
                }
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
