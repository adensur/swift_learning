//
//  ContentView.swift
//  iExpense
//
//  Created by Maksim Gaiduk on 21/08/2023.
//

import SwiftUI

struct ExampleView: View {
    @State private var counter = 0
    let scale: Double
    var body: some View {
        Button("Tap Count: \(counter)") {
            counter += 1
        }
        .scaleEffect(scale)
    }
    init(scale: Double) {
        print("ExampleView::init()")
        self.scale = scale
    }
}

struct ContentView: View {
    @State private var scaleUp = false
    private var exampleView: some View {
        if scaleUp {
            return ExampleView(scale: 2).id("id1")
        } else {
            return ExampleView(scale: 1).id("id1")
        }
    }
    var body: some View {
        VStack {
            exampleView
            Toggle("Scale Up", isOn: $scaleUp.animation())
        }
        .padding() }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
